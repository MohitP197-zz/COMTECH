import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gdgbloc/src/reporisitories/user_api.dart';
import 'package:gdgbloc/src/ui/homepage/homescreen/taskscreen/model/task_model.dart';
import 'package:http/http.dart' as http;

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class AddTaskScreen extends StatefulWidget {
  AssignedTask assignedTask;
  AddTaskScreen({this.assignedTask});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  bool _isLoading = false;
  CallApi _apiService = CallApi();
  bool _isFieldTaskValid;
  bool _isFieldDescriptionValid;
  // String _isFieldCategoryValid;
  bool _isFieldLocationValid;
  // bool _isFieldUserIdValid;

  TextEditingController _controllerTask = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();
  TextEditingController _controllerCategory = TextEditingController();
  TextEditingController _controllerLocation = TextEditingController();
  TextEditingController _controllerUserId = TextEditingController();

  var _categories = [
    'Security Camera',
    'Video Recorder',
    'Attendance System',
    'EPABX',
    'Fire Fighting'
  ];
  var _currentSelectedCategory = 'Security Camera';

  // var _technicians = [
  //   'Ganesh',
  //   'Dipak',
  //   'Parshu',
  //   'Rabine',
  // ];
  // var _currentSelectedTechnician = 'Ganesh';
  // CallApi callApi;

  String _currentlySelectedTechnician;

  final String url = "https://app.comtechnepal.com/api/technicians/";

  List data = List(); //edited line

  Future<String> getTechnicians() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody;
    });

    print(resBody);

    return "Sucess";
  }

  @override
  void initState() {
    if (widget.assignedTask != null) {
      _isFieldTaskValid = true;
      _controllerTask.text = widget.assignedTask.task_name;

      _isFieldDescriptionValid = true;
      _controllerDescription.text = widget.assignedTask.description;

      // _isFieldCategoryValid = true;
      _controllerCategory.text = widget.assignedTask.category;

      _isFieldLocationValid = true;
      _controllerLocation.text = widget.assignedTask.location;

      // _isFieldUserIdValid = true;
      _controllerUserId.text = widget.assignedTask.user_id;
    }
    super.initState();
    getTechnicians();
    // final _technicians = callApi.getTechnicians();
  }

  @override
  Widget build(BuildContext context) {
    final app = TextStyle(
        color: Colors.white,
        fontSize: 26.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Lobster');

    return Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          backgroundColor: Colors.grey,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            widget.assignedTask == null ? "Add Task" : "Edit Task Details",
            style: app,
          ),
          centerTitle: true,
        ),
        body: Stack(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              // mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _categoryLabel(),
                _buildTextFieldCategory(),
                _buildTextFieldTask(),
                SizedBox(
                  height: 8.0,
                ),
                _buildTextFieldDescription(),
                SizedBox(
                  height: 8.0,
                ),
                SizedBox(
                  height: 8.0,
                ),
                _buildTextFieldLocation(),
                SizedBox(
                  height: 8.0,
                ),
                _TechnicianLabel(),
                _buildTextFieldUserId(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    onPressed: () {
                      print(_currentSelectedCategory);

                      if (_isFieldTaskValid == null ||
                          _isFieldDescriptionValid == null ||
                          // _isFieldCategoryValid == null ||
                          _isFieldLocationValid == null ||
                          // _isFieldUserIdValid == null ||
                          !_isFieldTaskValid ||
                          !_isFieldDescriptionValid ||
                          // !_isFieldCategoryValid ||
                          // !_isFieldUserIdValid ||
                          !_isFieldLocationValid) {
                        _scaffoldState.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Please fill all field"),
                          ),
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      String task_name = _controllerTask.text.toString();
                      String description =
                          _controllerDescription.text.toString();
                      String category = _currentSelectedCategory;
                      String location = _controllerLocation.text.toString();
                      String user_id = _currentlySelectedTechnician;

                      AssignedTask assignedTask = AssignedTask(
                          task_name: task_name,
                          description: description,
                          category: category,
                          location: location,
                          user_id: user_id);

                      // print(assignedTask);
                      if (widget.assignedTask == null) {
                        _apiService.createTask(assignedTask).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(_scaffoldState.currentState.context);
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text('Submit data failed'),
                            ));
                          }
                        });
                      } else {
                        assignedTask.id = widget.assignedTask.id;
                        _apiService.updateTask(assignedTask).then((isSuccess) {
                          setState(() => _isLoading = false);
                          print(isSuccess);
                          if (!isSuccess) {
                            Navigator.pop(_scaffoldState.currentState.context);
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Update data failed"),
                            ));
                          }
                        });
                      }
                    },
                    child: Text(
                      "Submit".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.orange[600],
                  ),
                )
              ],
            ),
          ),
          _isLoading
              ? Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.3,
                      child: ModalBarrier(
                        dismissible: false,
                        color: Colors.grey,
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                )
              : Container(),
          // ],
          // ),
        ]));
  }

  Widget _categoryLabel() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Category:",
          style: TextStyle(fontSize: 20.0),
        ),
      );

  Widget _TechnicianLabel() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Technician:",
          style: TextStyle(fontSize: 20.0),
        ),
      );

  Widget _buildTextFieldTask() {
    return TextField(
      controller: _controllerTask,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0)),
        labelText: "Task name",
        errorText: _isFieldTaskValid == null || _isFieldTaskValid
            ? null
            : "Task name is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldTaskValid) {
          setState(() => _isFieldTaskValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldDescription() {
    return TextField(
      controller: _controllerDescription,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0)),
        labelText: "Task Description",
        errorText: _isFieldDescriptionValid == null || _isFieldDescriptionValid
            ? null
            : "Description is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldDescriptionValid) {
          setState(() => _isFieldDescriptionValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldCategory() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 5.0),
        child: Column(
          children: <Widget>[
            DropdownButton<String>(
              // Map function gets the value as a string in a iteration for each list
              items: _categories.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem),
                );
              }).toList(),
              onChanged: (String newValueSelected) {
                setState(() {
                  this._currentSelectedCategory = newValueSelected;
                  // _isFieldCategoryValid = _isFieldCategoryValid;
                });
              },

              value: _currentSelectedCategory,
              isExpanded: false,
              hint: Text(
                'Choose Category',
                style: TextStyle(color: Color(0xFF11b719)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldLocation() {
    return TextField(
      controller: _controllerLocation,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0)),
        labelText: "Location",
        errorText: _isFieldLocationValid == null || _isFieldLocationValid
            ? null
            : "Location is Required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldLocationValid) {
          setState(() => _isFieldLocationValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldUserId() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 5.0),
        child: Column(
          children: <Widget>[
            DropdownButton<String>(
              items: data.map((item) {
                return new DropdownMenuItem(
                  child: new Text(item['name']),
                  value: item['name'].toString(),
                );
              }).toList(),
              onChanged: (newVal) {
                setState(() {
                  _currentlySelectedTechnician = newVal;
                });
              },
              value: _currentlySelectedTechnician,
            ),
          ],
        ),
      ),
    );
  }
}
