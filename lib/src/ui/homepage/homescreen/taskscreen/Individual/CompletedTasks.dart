import 'package:flutter/material.dart';
import 'package:gdgbloc/src/bloc/getValue.dart';
import 'package:gdgbloc/src/reporisitories/user_api.dart';
import 'package:gdgbloc/src/ui/homepage/homescreen/taskscreen/Individual.dart';
// import 'package:gdgbloc/src/ui/homepage/homescreen/taskscreen/add_task_form.dart';
import 'package:gdgbloc/src/ui/homepage/homescreen/taskscreen/model/task_model.dart';

class CompletedTasks extends StatefulWidget {
  @override
  _CompletedTasksState createState() => _CompletedTasksState();
}

class _CompletedTasksState extends State<CompletedTasks> {
  CallApi callApi;
  @override
  void initState() {
    super.initState();
    getUserID();
    callApi = CallApi();
  }

  final userId = new GetValue();
  String s;

  getUserID() {
    userId.userIDCheck().then((value) {
      print(value);
      setState(() {
        s = value;
      });
      return value;
    });
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
          if (assignedtask[index].status == "Completed" &&
              (assignedtask[index].user_id.toString() == s)) {
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
                      Text(assignedTask.description),
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
