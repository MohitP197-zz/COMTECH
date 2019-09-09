import 'package:flutter/material.dart';
import 'package:gdgbloc/src/ui/homepage/homescreen/drawer/drawer.dart';

import 'service/calls_and_messages_service.dart';
import 'service/service_locator.dart';

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();

  final String number = "9868634359";
  final String email = "ganesholi109@gmail.com";

  @override
  Widget build(BuildContext context) {
    final app = TextStyle(
        color: Colors.white,
        fontSize: 26.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Lobster');
    return Scaffold(
      appBar: AppBar(
        title: Text('Message or Email us', style: app,),
        backgroundColor: Colors.grey,
        centerTitle: true,
        elevation: 0.0,
      ),

      drawer: Menues(),

      body: Container(
        padding: EdgeInsets.only(top: 100.0),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
              color: Colors.cyan,
              child: Text(
                "call: $number", style: TextStyle(color: Colors.black, fontSize: 20.0, fontFamily: 'Raleway'),
              ),
              onPressed: () => _service.call(number),
            ),
            SizedBox(height: 40.0),
            RaisedButton(
              color: Colors.cyan,
              child: Text(
                "message: $number", style: TextStyle(color: Colors.black, fontSize: 20.0, fontFamily: 'Railway'),
              ),
              onPressed: () => _service.sendSms(number),
            ),
            SizedBox(height: 40.0),
            RaisedButton(
              color: Colors.cyan,
              child: Text(
                "email: $email", style: TextStyle(color: Colors.black, fontSize: 20.0, fontFamily: 'Railway'),
              ),
              onPressed: () => _service.sendEmail(email),
            ),
          ],
        ),

      ),
      
    );
  }
}