import 'package:flutter/material.dart';
import 'package:gdgbloc/src/reporisitories/user_api.dart';
import 'package:gdgbloc/src/ui/homepage/homescreen/taskscreen/model/task_model.dart';

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
  bool _isLoading = false;
  CallApi _apiService = CallApi();

  @override
  void initState() {
    super.initState();
  }

  _IndividualsState({this.assignedTask});
  @override
  Widget build(BuildContext context) {
    Color determineColor() {
      if (assignedTask.status == "Not Complete") {
        return Colors.brown;
      } else {
        return Colors.white;
      }
    }

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 1.0),
        Icon(
          Icons.bookmark,
          color: Colors.white,
          size: 40.0,
        ),
        Container(
          width: 90.0,
          child: new Divider(color: Colors.green),
        ),
        SizedBox(height: 10.0),
        Text(
          assignedTask.task_name,
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        SizedBox(
          height: 10.0,
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 8,
                child: Padding(
                    padding: EdgeInsets.only(left: 1.0),
                    child: Text(
                      assignedTask.location,
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ))),
            Expanded(
                flex: 7,
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
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.lightGreen),
          child: Center(
            child: topContentText,
          ),
        ),
      ],
    );
    // final bottomContentMap = Container(
    //   // height: MediaQuery.of(context).size.height * 0.5,
    //   height: MediaQuery.of(context).size.height * 0.3,
    //   width: MediaQuery.of(context).size.width,
    //   child: GoogleMap(
    //     onMapCreated: _onMapCreated,
    //     markers: Set.from(allMarkers),
    //     initialCameraPosition: CameraPosition(
    //       target: LatLng(latitudes, longitudes),
    //       zoom: 16.0,
    //     ),
    //   ),
    // );

    final bottomContentText = Text(
      assignedTask.description,
      style: TextStyle(fontSize: 18.0),
    );
    final bottomContent = Container(
      // width: MediaQuery.of(context).size.width * 1.0,
      width: MediaQuery.of(context).size.width * 1.0,
      // padding: EdgeInsets.all(1.0),
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText],
        ),
      ),
    );
    return Scaffold(
      key: _scaffoldState,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Task Details"),
        backgroundColor: Colors.lightGreen,
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
                        style: TextStyle(color: Colors.lightGreen),
                      ),
                      content: Text(
                          "Are you sure the task ${assignedTask.task_name} is completed?"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            "Yes",
                            style: TextStyle(color: Colors.lightGreen),
                          ),
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
                          child: Text(
                            "No",
                            style: TextStyle(color: Colors.redAccent),
                          ),
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[topContent, bottomContent],
        ),
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
