import 'package:flutter/material.dart';
import 'package:gdgbloc/src/reporisitories/user_api.dart';
import 'package:gdgbloc/src/ui/homepage/homescreen/taskscreen/Individual.dart';
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
    //  final app = TextStyle(
    //     color: Colors.white,
    //     fontSize: 26.0,
    //     fontWeight: FontWeight.bold,
    //     fontFamily: 'Lobster');

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Add Task', style: app,),
    //     centerTitle: true,
    //   ),

    // );
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Task Details', style: app,),
      //   centerTitle: true,
      //   actions: <Widget>[
      //      IconButton(
      //           icon: Icon(Icons.add),
      //           // onPressed: _addTask,
      //           onPressed: (){
      //             Navigator.pushNamed(context, "/AddTaskScreen");
      //           },

      //         )
      //   ],
      // ),
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
                    Text(assignedTask.latitude),
                    Text(assignedTask.longitude),
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
                          onPressed: () {},
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {},
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
