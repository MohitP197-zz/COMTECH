import 'package:flutter/material.dart';

import 'model/office_model.dart';
// import 'package:gdgbloc/src/ui/homepage/homescreen/taskscreen/model/task_model.dart';

class Individual extends StatefulWidget {
  final Office office;

  Individual(this.office);
  @override
  _IndividualState createState() => _IndividualState(office);
}

class _IndividualState extends State<Individual> {
  final Office office;
  _IndividualState(this.office);

  @override
  Widget build(BuildContext context) {
    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 50.0),
        Icon(
          Icons.home,
          color: Colors.white,
          size: 40.0,
        ),
        Container(
          width: 90.0,
          child: new Divider(color: Colors.green),
        ),
        SizedBox(height: 10.0),
        Text(
          office.office_name,
          style: TextStyle(color: Colors.white, fontSize: 22.0),
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 1.0),
                    child: Text(
                      office.location,
                      style: TextStyle(color: Colors.red, fontSize: 17),
                    ))),
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        // Container(
        //     padding: EdgeInsets.only(left: 10.0),
        //     height: MediaQuery.of(context).size.height * 0.5,
        //     decoration: new BoxDecoration(
        //       image: new DecorationImage(
        //         image: new AssetImage("drive-steering-wheel.jpg"),
        //         fit: BoxFit.cover,
        //       ),
        //     )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );
    final bottomContentText = Text(
      office.description,
      style: TextStyle(fontSize: 18.0),
    );
    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText],
        ),
      ),
    );
    return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}
