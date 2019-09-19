import 'package:flutter/material.dart';
import 'package:gdgbloc/src/bloc/getValue.dart';
import 'package:gdgbloc/src/ui/homepage/homescreen/drawer/drawer.dart';
import 'package:gdgbloc/src/ui/homepage/homescreen/taskscreen/completed.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gdgbloc/src/ui/homepage/homescreen/taskscreen/task_details.dart';

class TaskScreenss extends StatefulWidget {
  @override
  _TaskScreenssState createState() => _TaskScreenssState();
}

class _TaskScreenssState extends State<TaskScreenss> {
  @override
  void initState() {
    getRole();
    super.initState();
  }

  final userRole = new GetValue();
  String role;

  getRole() {
    userRole.userCheck().then((value) {
      // print(value);
      setState(() {
        role = value;
        print(role);
        // print(s);
      });
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final app = TextStyle(
        color: Colors.white,
        fontSize: 26.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Lobster');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey,
            title: Container(
              child: Text(
                'Task Details',
                style: app,
              ),
            ),
            centerTitle: true,
            actions: <Widget>[
              if (role == "admin" || role == "office_assistant")
                IconButton(
                  icon: Icon(Icons.add),
                  // onPressed: _addTask,
                  onPressed: () {
                    Navigator.pushNamed(context, "/AddTaskScreen");
                  },
                )
            ],
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(FontAwesomeIcons.tasks),
                ),
                Tab(
                  icon: Icon(FontAwesomeIcons.tablet),
                ),
              ],
            ),
            // title: Text('Flutter'),
          ),
          drawer: Menues(),
          body: TabBarView(
            children: <Widget>[
              TaskDetails(),
              Completed(),
              // Tabs(),
            ],
          ),
        ),
      ),
    );
  }

  // void _addTask(){
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) => Scaffold(
  //       appBar: AppBar(
  //         title: Text('Add Task'),
  //         centerTitle: true,
  //       ),
  //     )
  //   );

  // }
}
