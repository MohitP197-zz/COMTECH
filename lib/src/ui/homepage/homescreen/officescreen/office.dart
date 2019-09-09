import 'package:flutter/material.dart';
import 'package:gdgbloc/src/reporisitories/user_api.dart';

class OfficeScreen extends StatefulWidget {
  @override
  _OfficeScreenState createState() => _OfficeScreenState();
}

class _OfficeScreenState extends State<OfficeScreen> {
  @override
  Widget build(BuildContext context) {
    final app = TextStyle(
        color: Colors.white,
        fontSize: 26.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Lobster');

  // CallApi (). getOffice (). then ((value) => print ("value: $value")); 
CallApi (). getOffice (). then ((value) => print ("value: $value"));


    return Scaffold(
      appBar: AppBar(
        title: Text('Office Details', style: app,),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
      ),
      
    );
  }
}