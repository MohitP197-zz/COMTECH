import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gdgbloc/src/reporisitories/user_api.dart';
import 'package:http/http.dart' as http;

class AssistantsScreen extends StatefulWidget {
  @override
  _AssistantsScreenState createState() => _AssistantsScreenState();
}

class _AssistantsScreenState extends State<AssistantsScreen> {
  CallApi api = CallApi();
  List data;
  List a;


  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http
        .get(Uri.encodeFull(api.url), headers: {"Accept": "application/json"});

    setState(() {
      data = json.decode(response.body);
      print(response.body);
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    final ui = TextStyle(
        color: Colors.white,
        fontSize: 26.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Lobster');

    final taskui = TextStyle(
        color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(
        title: new Text(
          "Office Assistant Details",
          style: ui,
        ),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          if (data[index]['role'] == "office_assistant") {
            return GestureDetector(
              child: Card(
                elevation: 18.0,
                // padding: EdgeInsets.all(10.0),
                color: index % 2 == 0 ? Colors.white : Colors.white70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      size: 30.0,
                    ),
                    Text(
                      data[index]['name'],
                      style: taskui,
                    ),
                    SizedBox(
                      height: 60.0,
                    ),
                    Text(
                      data[index]['email'],
                      style: taskui,
                    ),
                  ],
                ),
                
              ),
              onTap: () {
                print('sorry');
              },
            );
          } else {
            return ListBody();
          }
        },
      ),
    );
  }
}
