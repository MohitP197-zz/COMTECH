
import 'package:flutter/material.dart';

import 'bottom_navigation/bottomenavigation.dart';



class PageTwo extends StatefulWidget {
  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  
  @override
  Widget build(BuildContext context) {
    
    return BottomBar();
    // return Scaffold(      
    //   bottomNavigationBar: BottomBar(),
    // );
  }
}
