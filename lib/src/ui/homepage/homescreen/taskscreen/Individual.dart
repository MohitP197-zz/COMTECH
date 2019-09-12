import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gdgbloc/src/reporisitories/user_api.dart';
import 'package:gdgbloc/src/ui/homepage/homescreen/taskscreen/model/task_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:gdgbloc/src/ui/homepage/homescreen/taskscreen/model/task_model.dart';
final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class Individuals extends StatefulWidget {
  final AssignedTask assignedTask;
  // final String latitude;

  Individuals(this.assignedTask);
  // const Individuals({Key key, this.assignedTask}) : super(key: key);
  // final AssignedTask assignedTask;
  // Individuals({Key key, this.assignedTask}) : super(key: key);
  @override
  _IndividualsState createState() =>
      _IndividualsState(assignedTask: this.assignedTask);
}

class _IndividualsState extends State<Individuals> {
  final AssignedTask assignedTask;
  Completer<GoogleMapController> _controller = Completer();
  bool _isLoading = false;
  CallApi _apiService = CallApi();

  // var latitude = assignedTask.latitude as double;
  // var longitude = assignedTask.longitude as double;
  // final LatLng _center = LatLng(latitude, longitude);
  List<Marker> allMarkers = [];
  GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    super.initState();
    allMarkers.add(Marker(
        markerId: MarkerId('myMarker'),
        // draggable: true,
        onTap: () {
          print('Marker Tapped');
        },
        position: LatLng(double.parse(assignedTask.latitude),
            double.parse(assignedTask.longitude))));
  }

  _IndividualsState({this.assignedTask});
  @override
  Widget build(BuildContext context) {
    var latitude = double.parse(assignedTask.latitude);
    var longitude = double.parse(assignedTask.longitude);
    // double latitudes = latitude.toDouble();
    // double longitudes = longitude.toDouble();
    double latitudes = latitude + .0;
    double longitudes = longitude + .0;

    Color determineColor() {
      if (assignedTask.status == "Not Complete") {
        return Colors.red;
      } else {
        return Colors.green;
      }
    }

    final topContentText = Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          assignedTask.task_name,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontSize: 10.0),
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
                      assignedTask.user_id.toString(),
                      style: TextStyle(color: Colors.red, fontSize: 17),
                    ))),
            Expanded(
                flex: 5,
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
                          assignedTask.status,
                          style: TextStyle(color: determineColor()),
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
    final bottomContentMap = Container(
      // height: MediaQuery.of(context).size.height * 0.5,
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        markers: Set.from(allMarkers),
        initialCameraPosition: CameraPosition(
          target: LatLng(latitudes, longitudes),
          zoom: 16.0,
        ),
      ),
    );

    final bottomContentText = Text(
      assignedTask.description,
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
              bottomContentMap,
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
      key: _scaffoldState,
      appBar: AppBar(
        title: Text("Task Details"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            // onPressed: _addTask,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        "Update Project",
                        style: TextStyle(color: Colors.blue),
                      ),
                      content: Text(
                          "Are you sure the task ${assignedTask.task_name} is completed?"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("Yes"),
                          onPressed: () {
                            setState(() {
                              _isLoading = true;
                            });
                            String task = "Completed";
                            String status = task.toString();
                            AssignedTask assignedTask =
                                AssignedTask(status: status);

                            assignedTask.id = widget.assignedTask.id;
                            _apiService
                                .taskIsCompleted(assignedTask)
                                .then((isSuccess) {
                              setState(() {
                                _isLoading = false;
                              });
                              if (!isSuccess) {
                                _taskIsCompleted(context);
                              } else {
                                _scaffoldState.currentState
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      'Unable to set the task to complete'),
                                ));
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
          )
        ],
      ),
      body: Column(
        children: <Widget>[bottomContent],
      ),
    );
  }

  void _taskIsCompleted(BuildContext context) {
    Navigator.pop(_scaffoldState.currentState.context);
    Navigator.pop(context);
    SnackBar(
      content: Text("Task Updated Successfully"),
    );
  }
}
