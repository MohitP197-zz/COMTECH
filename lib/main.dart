import 'package:flutter/material.dart';
// import 'package:gdgbloc/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/login_page.dart';
import 'src/ui/homepage/bottom_navigation/message/service/service_locator.dart';
import 'src/ui/homepage/home_page.dart';
import 'src/ui/homepage/homescreen/assistantsscreen/assistants.dart';
import 'src/ui/homepage/homescreen/completedtaskscreen/completed.dart';
import 'src/ui/homepage/homescreen/mapscreen/map.dart';
// import 'src/ui/homepage/homescreen/mapscreen/map2.dart';
import 'src/ui/homepage/homescreen/officescreen/addOffice.dart';
import 'src/ui/homepage/homescreen/officescreen/office.dart';
import 'src/ui/homepage/homescreen/operatorscreen/operator.dart';
import 'src/ui/homepage/homescreen/taskscreen/add_task_form.dart';
import 'src/ui/homepage/homescreen/taskscreen/task_details.dart';
import 'src/ui/homepage/homescreen/taskscreen/tasks_home.dart';
// import 'src/ui/homepage/homescreen/taskscreen/task.dart';

var routes= <String,WidgetBuilder>{
        "/LoginPage":(BuildContext context) => LoginPage(),
        "/TaskScreenss": (BuildContext context) => TaskScreenss(),
        "/CompletedScreen": (BuildContext context) => CompletedScreen(),
        "/AssistantsScreen": (BuildContext context) => AssistantsScreen(),
        "/OperatorsScreen": (BuildContext context) => OperatorsScreen(),
        "/OfficeScreen": (BuildContext context) => OfficeScreen(),
        // "/FeedbackScreen": (BuildContext context) => FeedbackScreen(),
        // "/ComplaintScreen": (BuildContext context) => ComplaintScreen(),
        "/MapsScreen": (BuildContext context) => MapsScreen(),
        // "/MapsDemo": (BuildContext context) => MapsDemo(),
        "/TaskDetails": (BuildContext context)=> TaskDetails(),
        "/AddTaskScreen": (BuildContext context)=> AddTaskScreen(),
        "/AddOfficeScreen": (BuildContext context)=> AddOfficeScreen(),

};

void main() async{  
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  var check = localStorage.getString('token');
  // var rolecheck = localStorage.getString('role');
  // var  err = (localStorage.getString('role') ?? 'sel');
  print(check);
  setupLocator();
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    // home: check == null ? LoginPage(): PageTwo(),
    home: check == null ? LoginPage(): PageTwo(),
    debugShowCheckedModeBanner: false,
  routes: routes,
));

}



