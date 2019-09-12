import 'package:flutter/material.dart';
import 'package:gdgbloc/src/reporisitories/user_api.dart';
import 'package:gdgbloc/src/ui/homepage/homescreen/taskscreen/Individual.dart';
import 'package:gdgbloc/src/ui/homepage/homescreen/taskscreen/add_task_form.dart';
import 'package:gdgbloc/src/ui/homepage/homescreen/taskscreen/model/task_model.dart';

class TaskDetails extends StatefulWidget {
  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  CallApi callApi;
  @override
  void initState() {
    super.initState();
    callApi = CallApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: callApi.getAssignedTask(),
        builder:
            (BuildContext context, AsyncSnapshot<List<AssignedTask>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<AssignedTask> assignedtask = snapshot.data;
            return _buildListView(assignedtask);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildListView(List<AssignedTask> assignedtask) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          AssignedTask assignedTask = assignedtask[index];
          if (assignedtask[index].status == "Not Complete") {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Card(
                elevation: 8.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        assignedTask.task_name,
                        style: Theme.of(context).textTheme.title,
                      ),
                      Text(
                        assignedTask.description,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(assignedTask.category),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              _getTaskDetails(context, assignedTask);
                            },
                            child: Text(
                              "View",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                        "Warning",
                                        style:
                                            TextStyle(color: Colors.redAccent),
                                      ),
                                      content: Text(
                                          "Are you sure want to delete task ${assignedTask.task_name}?"),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text("Yes"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            callApi
                                                .deleteTask(assignedTask.id)
                                                .then((isSuccess) {
                                              if (!isSuccess) {
                                                setState(() {
                                                  // super.initState();
                                                  callApi = CallApi();
                                                });
                                                Scaffold.of(this.context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            "Deleted Task Successfully")));
                                              } else {
                                                setState(() {
                                                  callApi = CallApi();
                                                });
                                                Scaffold.of(this.context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            "Unable to delete the task")));
                                              }
                                            });
                                          },
                                        ),
                                        FlatButton(
                                          child: Text("No"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    );
                                  });
                            },
                            child: Text(
                              "Delete",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return AddTaskScreen(
                                    assignedTask: assignedTask);
                              }));
                            },
                            child: Text(
                              "Edit",
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return ListBody();
          }
        },
        itemCount: assignedtask.length,
      ),
    );
  }

  Future _getTaskDetails(BuildContext context, AssignedTask assignedTask) {
    return Navigator.push(context,
        MaterialPageRoute(builder: (context) => Individuals(assignedTask)));
  }
}
