import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gdgbloc/src/reporisitories/user_api.dart';
import 'package:gdgbloc/src/ui/homepage/bottom_navigation/message/service/calls_and_messages_service.dart';
import 'package:gdgbloc/src/ui/homepage/bottom_navigation/message/service/service_locator.dart';
import 'package:http/http.dart' as http;
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OperatorsScreen extends StatefulWidget {
  @override
  _OperatorsScreenState createState() => _OperatorsScreenState();
}

class _OperatorsScreenState extends State<OperatorsScreen> {
  final String email = "ganesholi109@gmail.com";
  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();
  CallApi api = CallApi();
  List data;
  List dat;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http
        .get(Uri.encodeFull(api.url), headers: {"Accept": "application/json"});
    var respons = await http
        .get(Uri.encodeFull(api.urli), headers: {"Accept": "application/json"});

    setState(() {
      data = json.decode(response.body);
      print(response.body);

      dat = json.decode(respons.body);
      print(respons.body);
    });

    return "Success";
  }

  // void _taskcompleted() {
  //   print('Ganesh');
  // }

  @override
  Widget build(BuildContext context) {
    final ui = TextStyle(
        color: Colors.white,
        fontSize: 26.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Lobster');

    final taskui = TextStyle(
        color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold);
    // final uname = TextStyle(
    //     color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w700);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: new Text(
          "Technicians Details",
          style: ui,
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          if (data[index]['role'] == "operator") {
            return GestureDetector(
              child: Card(
                elevation: 18.0,
                // padding: EdgeInsets.all(10.0),
                color: index % 2 == 0 ? Colors.grey : Colors.grey,
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
                showDialog(
                    context: context,
                    builder: (BuildContext context) => Scaffold(
                          appBar: AppBar(
                            backgroundColor: Colors.grey,
                            title: Text(
                              'User Details',
                              style: ui,
                            ),
                            centerTitle: true,
                          ),
                          body: ListView.builder(
                              padding: EdgeInsets.all(16.0),
                              scrollDirection: Axis.vertical,
                              itemCount: dat == null ? 0 : dat.length,
                              itemBuilder: (BuildContext contxt, int inde) {
                                if (data[index]['id'] == dat[inde]['user_id']) {
                                  return Card(
                                    // padding: EdgeInsets.all(10.0),
                                    color: index % 2 == 0
                                        ? Colors.grey
                                        : Colors.grey,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          dat[inde]['task_name'],
                                          style: taskui,
                                        ),
                                        Text(dat[inde]['description']),
                                        Column(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 200.0),
                                              child: RaisedButton(
                                                color: Colors.cyan,
                                                child: Text(
                                                  "$email",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20.0,
                                                      fontFamily: 'Railway'),
                                                ),
                                                onPressed: () =>
                                                    _service.sendEmail(email),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                } else {
                                  return ListBody();
                                }
                              }),
                        ));
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
