import 'package:flutter/material.dart';
import 'package:gdgbloc/src/reporisitories/user_api.dart';
import 'package:gdgbloc/src/ui/homepage/homescreen/officescreen/model/office_model.dart';

import 'Individual.dart';
import 'addOffice.dart';

class OfficeScreen extends StatefulWidget {
  @override
  _OfficeScreenState createState() => _OfficeScreenState();
}

class _OfficeScreenState extends State<OfficeScreen> {
  CallApi callApi;
  @override
  void initState() {
    super.initState();
    callApi = CallApi();
  }

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
          'Office Details',
          style: app,
        ),
        centerTitle: true,
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.add),
      // ),
      body: FutureBuilder(
        future: callApi.getOffice(),
        builder: (BuildContext context, AsyncSnapshot<List<Office>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<Office> office = snapshot.data;
            return _buildListView(office);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildListView(List<Office> officeData) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Office office = officeData[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              elevation: 8.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      office.office_name,
                      style: Theme.of(context).textTheme.title,
                    ),
                    Text(office.description),
                    Text(office.location),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            _getTaskDetails(context, office);
                          },
                          child: Text(
                            "View",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      "Warning",
                                      style: TextStyle(color: Colors.redAccent),
                                    ),
                                    content: Text(
                                        "Are you sure want to delete task ${office.office_name}?"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Yes"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          callApi
                                              .deleteTask(office.id)
                                              .then((isSuccess) {
                                            if (!isSuccess) {
                                              setState(() {
                                                // super.initState();
                                                callApi = CallApi();
                                              });
                                              Scaffold.of(this.context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Deleted Task Successfully")));
                                            } else {
                                              setState(() {
                                                callApi = CallApi();
                                              });
                                              Scaffold.of(this.context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Unable to delete the task")));
                                            }
                                          });
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("No"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return AddOfficeScreen(office: office);
                            }));
                          },
                          child: Text(
                            "Edit",
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: officeData.length,
      ),
    );
  }

  Future _getTaskDetails(BuildContext context, Office office) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => Individual(office)));
  }
}
