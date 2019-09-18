import 'package:flutter/material.dart';
import 'package:gdgbloc/src/bloc/getValue.dart';
import 'package:gdgbloc/src/ui/homepage/homescreen/drawer/drawer.dart';
import 'package:gdgbloc/src/ui/homepage/homescreen/taskscreen/Individual/CompletedTasks.dart';
import 'package:gdgbloc/src/ui/homepage/homescreen/taskscreen/Individual/InCompleteTasks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IndividualTaskScreen extends StatefulWidget {
  @override
  _IndividualTaskScreenState createState() => _IndividualTaskScreenState();
}

class _IndividualTaskScreenState extends State<IndividualTaskScreen> {
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
            title: Text(
              'Task Details',
              style: app,
            ),
            centerTitle: true,
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
              InCompleteTasks(),
              CompletedTasks(),
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
