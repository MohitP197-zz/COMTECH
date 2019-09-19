import 'package:flutter/material.dart';
import 'package:gdgbloc/src/ui/homepage/homescreen/drawer/drawer.dart';
// import 'package:gdgbloc/src/reporisitories/user_api.dart';
// import 'package:gdgbloc/src/ui/homepage/homescreen/taskscreen/model/task_model.dart';
import 'item.dart';
// import 'package:table_calendar/table_calendar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // CalendarController _controller;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = CalendarController();
  // }

  @override
  Widget build(BuildContext context) {
// CallApi (). getAssignedTask (). then ((value) => print ("value: $value"));
// AssignedTask task = AssignedTask();
// print(task);

    final app = TextStyle(
        color: Colors.white,
        fontSize: 26.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Lobster');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text(
          'Task Management',
          style: app,
        ),
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[],
      ),
      drawer: Menues(),
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          Column(
            children: <Widget>[
              // SizedBox(
              //   height: 10.0,
              // ),
              // Text(
              //   'Quick links',
              //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              // ),
              HomeItem(),
              // SizedBox(
              //   height: 18.0,
              // ),
              // TableCalendar(
              //   initialCalendarFormat: CalendarFormat.month,
              //   calendarStyle: CalendarStyle(
              //     todayColor: Colors.orange,
              //     selectedColor: Theme.of(context).primaryColor,
              //     todayStyle: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         fontSize: 20.0,
              //         color: Colors.white),
              //   ),
              //   headerStyle: HeaderStyle(
              //     centerHeaderTitle: true,
              //     formatButtonDecoration: BoxDecoration(
              //       color: Colors.orange,
              //       borderRadius: BorderRadius.circular(20.0),
              //     ),
              //     formatButtonTextStyle: TextStyle(color: Colors.white),
              //     formatButtonShowsNext: false,
              //   ),
              //   startingDayOfWeek: StartingDayOfWeek.sunday,
              //   onDaySelected: (date, envnts) {
              //     // print(date.toIso8601String());
              //      showDialog(
              //     context: context,
              //     builder: (BuildContext context) {
              //       // return object of type Dialog
              //       return AlertDialog(
              //         title: Text('hello'),
              //         content: Text("Task Details"),
              //         actions: <Widget>[
              //           // usually buttons at the bottom of the dialog
              //           FlatButton(
              //             child: Text("Close"),
              //             onPressed: () {
              //               Navigator.of(context).pop();
              //             },
              //           ),
              //         ],
              //       );
              //     },
              //   );
              //   },
              //   builders: CalendarBuilders(
              //       selectedDayBuilder: (context, date, events) => Container(
              //             margin: EdgeInsets.all(4.0),
              //             alignment: Alignment.center,
              //             decoration: BoxDecoration(
              //                 color: Theme.of(context).primaryColor,
              //                 borderRadius: BorderRadius.circular(10.0)),
              //             child: Text(date.day.toString(),
              //                 style: TextStyle(color: Colors.white)),
              //           ),
              //       todayDayBuilder: (context, date, events) => Container(
              //             margin: EdgeInsets.all(4.0),
              //             alignment: Alignment.center,
              //             decoration: BoxDecoration(
              //               color: Colors.orange,
              //               borderRadius: BorderRadius.circular(10.0),
              //             ),
              //             child: Text(
              //               date.day.toString(),
              //               style: TextStyle(color: Colors.white),
              //             ),
              //           )),
              //   calendarController: _controller,
              // ),
              // SizedBox(
              //   height: 40.0,
              // ),
            ],
          )
        ],
      ),
    );
  }
}
