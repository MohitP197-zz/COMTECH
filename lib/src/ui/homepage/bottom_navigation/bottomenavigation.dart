import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gdgbloc/src/ui/homepage/bottom_navigation/feedback/feedback.dart';
import 'home.dart';
import 'message/message.dart';
// import 'user.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

 int _currentIndex = 0;
 final List<Widget> _children = [
   Home(),
   Message(),
   FeedBack(),
 ];

  void onTabTapped(int index){
    setState(() {
     _currentIndex = index;
    });
  }
  @override
   Widget build(BuildContext context) {
   return Scaffold(
     body: _children[_currentIndex],
     bottomNavigationBar: BottomNavigationBar(
       type: BottomNavigationBarType.fixed,
      //  backgroundColor: Colors.grey,
      elevation: 64.0,
       onTap: onTabTapped, // new
       currentIndex: _currentIndex, // new
       items: [
         new BottomNavigationBarItem(
           icon: Icon(FontAwesomeIcons.home, color: Colors.black, size: 30.0,),
           title: Text('Home', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),),
         ),
         new BottomNavigationBarItem(
           icon: Icon(FontAwesomeIcons.fileContract, color: Colors.black,size: 30.0,),
           title: Text('About', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),),
         ),
         new BottomNavigationBarItem(
           icon: Icon(FontAwesomeIcons.comment, color: Colors.black,size: 30.0,),
           title: Text('Query', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),)
         )
       ],
     ),
   );
 }
}