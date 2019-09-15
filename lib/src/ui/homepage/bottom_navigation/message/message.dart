import 'package:flutter/material.dart';
import 'package:gdgbloc/src/ui/homepage/homescreen/drawer/drawer.dart';

import 'messageDesign.dart';
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
  final String url = "www.comtechnepal.com";
  final String address = "Putalisadak, Kathmandu,Nepal";

  @override
  Widget build(BuildContext context) {
    final app = TextStyle(
        color: Colors.white,
        fontSize: 26.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Lobster');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact US',
          style: app,
        ),
        backgroundColor: Colors.grey,
        centerTitle: true,
        elevation: 0.0,
      ),

      drawer: Menues(),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/images/comtech.png"),
              ),
              Text(
                "COMTECH",
                style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  fontSize: 24.0,
                  color: Colors.teal[50],
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 9,
                width: 200,
                child: Divider(
                  color: Colors.teal.shade700,
                ),
              ),
              MessageDesign(
                text: number,
                icon: Icons.phone,
                onPressed: () {
                  _service.call(number);
                },
              ),
              MessageDesign(
                text: email,
                icon: Icons.email,
                onPressed: () {
                  _service.sendEmail(email);
                },
              ),
              MessageDesign(
                text: url,
                icon: Icons.web,
                onPressed: () {},
              ),
              MessageDesign(
                text: address,
                icon: Icons.location_city,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(58, 70, 86, 1.0),

      // body: Container(
      //   padding: EdgeInsets.only(top: 100.0),
      //   width: double.infinity,
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     mainAxisSize: MainAxisSize.min,
      //     children: <Widget>[
      //       RaisedButton(
      //         color: Colors.cyan,
      //         child: Text(
      //           "call: $number", style: TextStyle(color: Colors.black, fontSize: 20.0, fontFamily: 'Raleway'),
      //         ),
      //         onPressed: () => _service.call(number),
      //       ),
      //       SizedBox(height: 40.0),
      //       RaisedButton(
      //         color: Colors.cyan,
      //         child: Text(
      //           "message: $number", style: TextStyle(color: Colors.black, fontSize: 20.0, fontFamily: 'Railway'),
      //         ),
      //         onPressed: () => _service.sendSms(number),
      //       ),
      //       SizedBox(height: 40.0),
      //       RaisedButton(
      //         color: Colors.cyan,
      //         child: Text(
      //           "email: $email", style: TextStyle(color: Colors.black, fontSize: 20.0, fontFamily: 'Railway'),
      //         ),
      //         onPressed: () => _service.sendEmail(email),
      //       ),
      //     ],
      //   ),

      // ),
    );
  }
}
