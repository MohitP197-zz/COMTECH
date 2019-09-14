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

    // final taskui = TextStyle(
    //     color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(
        title: new Text(
          "Office Assistants",
          style: ui,
        ),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          if (data[index]['role'] == "office_assistant") {
            return Row(children: <Widget>[
              Expanded(
                  child: SizedBox(
                      height: 60.0,
                      child: ListView(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(
                              Icons.person,
                              size: 30.0,
                            ),
                            title: Text(
                              data[index]['name'],
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                            ),
                            subtitle: Text(
                              data[index]['email'],
                              style: TextStyle(color: Colors.green),
                            ),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          )
                        ],
                      )))
            ]);
          } else {
            return ListBody();
          }
        },
      ),
    );
  }
}
