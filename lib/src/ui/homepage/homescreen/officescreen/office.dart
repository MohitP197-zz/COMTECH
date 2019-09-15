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
          'All Offices',
          style: app,
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            // onPressed: _addTask,
            onPressed: () {
              Navigator.pushNamed(context, "/AddOfficeScreen");
            },
          )
        ],
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
                    Text(
                      office.description,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            flex: 7,
                            child: Padding(
                                padding: EdgeInsets.only(left: 1.0),
                                child: Text(
                                  office.location,
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 16),
                                ))),
                        // Expanded(flex: 4, child: Text(office.location))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            _getOfficeDetails(context, office);
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
                                        "Are you sure want to delete office ${office.office_name}?"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Yes"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          callApi
                                              .deleteOffice(office.id)
                                              .then((isSuccess) {
                                            if (!isSuccess) {
                                              setState(() {
                                                // super.initState();
                                                callApi = CallApi();
                                              });
                                              Scaffold.of(this.context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Deleted Office Successfully")));
                                            } else {
                                              setState(() {
                                                callApi = CallApi();
                                              });
                                              Scaffold.of(this.context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Unable to delete the office")));
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

  Future _getOfficeDetails(BuildContext context, Office office) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => Individual(office)));
  }
}
