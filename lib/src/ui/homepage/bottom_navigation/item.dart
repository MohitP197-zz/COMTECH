import 'package:flutter/material.dart';
import 'package:gdgbloc/src/bloc/getValue.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class HomeItem extends StatefulWidget {
  @override
  _HomeItemState createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  @override
  void initState() {
    someMethod();
    super.initState();
  }

  final userVal = new GetValue();
  String s;

  someMethod() {
    userVal.userCheck().then((value) {
      print(value);
      setState(() {
        s = value;
      });
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Container(
      // height: screenSize.height,
      // height: 290.0,
      height: screenSize.height,
      // color: Colors.white70,
      // padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
      child: GridView.count(
        // scrollDirection: Axis.horizontal,
        crossAxisCount: 2,
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          makeDashboardItem(1, "Tasks", FontAwesomeIcons.tasks),
          makeDashboardItem(2, "Technician", FontAwesomeIcons.userShield),
          makeDashboardItem(3, "Assistant", FontAwesomeIcons.userAstronaut),
          makeDashboardItem(4, "Office", FontAwesomeIcons.solidBuilding),
          // makeDashboardItem(5, "FeedBack", FontAwesomeIcons.comment),
          // makeDashboardItem(6, "Maps", FontAwesomeIcons.mapMarkedAlt),
        ],
      ),
    );
  }

  Card makeDashboardItem(int id, String title, IconData icon) {
    return Card(
        elevation: 80.0,
        margin: new EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.transparent),
          child: new InkWell(
            onTap: () {
              if (id == 1 && s == 'operator') {
                Navigator.pushNamed(context, '/TaskScreenss');
              } else if (id == 2) {
                // print('oli');
                Navigator.pushNamed(context, '/OperatorsScreen');

              } else if (id == 3) {
                Navigator.pushNamed(context, '/AssistantsScreen');

                // print('Hey');
              } else if (id == 4) {
                Navigator.pushNamed(context, '/OfficeScreen');

                // print('thank you');
              }else if(id == 5){

              } else if(id == 6){
                Navigator.pushNamed(context, '/MapsScreen');
                // Navigator.pushNamed(context, '/MapsDemo');


              }
                else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                      title: new Text("Sorry you are not the user"),
                      content: new Text("To access this links"),
                      actions: <Widget>[
                        // usually buttons at the bottom of the dialog
                        new FlatButton(
                          child: new Text("Close"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height:40.0),
                Center(
                    child: Icon(
                  icon,
                  size: 46.0,
                  color: Colors.black,
                )),
                SizedBox(height: 14.0),
                new Center(
                  child: new Text(title,
                      style:
                          new TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
        ));
  }
}
