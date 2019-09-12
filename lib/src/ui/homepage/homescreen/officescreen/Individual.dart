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
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          office.office_name,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontSize: 22.0),
        ),
        SizedBox(
          height: 5.0,
        ),
        Container(
          width: 90.0,
          child: Divider(color: Colors.green),
        ),
        // SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 1.0),
                    child: Text(
                      office.user_id.toString(),
                      style: TextStyle(color: Colors.red, fontSize: 17),
                    ))),
            Expanded(
                flex: 4,
                child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Container(
                      padding: const EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          office.location,
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    )))
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
          height: 40.0,
          width: MediaQuery.of(context).size.width,
          child: Divider(color: Colors.black),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.23,
          padding: EdgeInsets.all(30.0),
          width: MediaQuery.of(context).size.width,
          // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
      ],
    );

    final bottomContentText = Text(
      office.description,
      style: TextStyle(fontSize: 18.0),
    );
    final bottomContent = Container(
      // width: MediaQuery.of(context).size.width * 1.0,
      width: MediaQuery.of(context).size.width * 1.0,
      // padding: EdgeInsets.all(1.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 15.0,
              ),
              topContent,
              Text(
                "Details",
                style: TextStyle(fontSize: 20.0, color: Colors.blue),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Container(
                    width: 60.0,
                    height: 5.0,
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 0.5)),
                    )),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(child: bottomContentText),
            ],
          ),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Office Details"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[bottomContent],
      ),
    );
  }
}
