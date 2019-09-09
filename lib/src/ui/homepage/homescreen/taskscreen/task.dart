import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gdgbloc/src/reporisitories/user_api.dart';
import 'package:http/http.dart' as http;

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  // final String url = "http://nishuflutter.herokuapp.com/api/task/";
  CallApi taskapi = new CallApi();
  List data;

  @override
  void initState() {
    super.initState();

    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http.get(
        // urlEncode
        Uri.encodeFull(taskapi.urli),
        headers: {"Accept": "application/json"});

    setState(() {
      data = json.decode(response.body);
      //  print(response.body);
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    final ui = TextStyle(
        color: Colors.black,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Lobster');


    final taskui = TextStyle(
        color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold);
        
// CallApi (). getAssignedTask (). then ((value) => print ("value: $value"));

        return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Container(
              padding: EdgeInsets.all(10.0),
              color: index % 2 == 0 ? Colors.greenAccent : Colors.cyan,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            'Task Name: ',
                            style: ui,
                          ),
                          Text(
                            data[index]['task_name'],
                            style: ui,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Date:',
                            style: ui,
                          ),
                          Text(
                            data[index]['created_at'],
                            style: ui,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                      ),
                      
                      
                      Text(
                        'Description:',
                        style: ui,
                      ),
                      Text(
                        data[index]['description'],
                        style: taskui,
                      ),
                      SizedBox(height: 8.0,),
                      Text(
                        'Location:',
                        style: ui,
                      ),
                      Text(
                        data[index]['location'],
                        style: taskui,
                      ),
                      SizedBox(height: 8.0,),

                      Text(
                        'Assigned_to:',
                        style: ui,
                      ),

                     ], )
                ],
              ),
            ),
            onTap: () {
              print('sorry');
            },
          );
        },
      );
    // );
  }
}
