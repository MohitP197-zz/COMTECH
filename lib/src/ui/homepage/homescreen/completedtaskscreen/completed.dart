import 'package:flutter/material.dart';

class CompletedScreen extends StatefulWidget {
  @override
  _CompletedScreenState createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  @override
  Widget build(BuildContext context) {
    final app = TextStyle(
        color: Colors.white,
        fontSize: 26.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Lobster');
    return Scaffold(
      appBar: AppBar(
        title: Text('Completed Task', style: app,),
        centerTitle: true,
      ),
      
    );
  }
}