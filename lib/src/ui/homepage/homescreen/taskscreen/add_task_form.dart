import 'package:flutter/material.dart';
import 'package:gdgbloc/src/reporisitories/user_api.dart';
import 'package:gdgbloc/src/ui/homepage/homescreen/taskscreen/model/task_model.dart';

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
  bool _isFieldCategoryValid;
  bool _isFieldLatitudeValid;
  bool _isFieldLongitudeValid;
  bool _isFieldUserIdValid;

  TextEditingController _controllerTask = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();
  TextEditingController _controllerCategory = TextEditingController();
  TextEditingController _controllerLatitude = TextEditingController();
  TextEditingController _controllerLongitude = TextEditingController();
  TextEditingController _controllerUserId = TextEditingController();

  @override
  void initState() {
    if (widget.assignedTask != null) {
      _isFieldTaskValid = true;
      _controllerTask.text = widget.assignedTask.task_name;

      _isFieldDescriptionValid = true;
      _controllerDescription.text = widget.assignedTask.description;

      _isFieldCategoryValid = true;
      _controllerCategory.text = widget.assignedTask.category;

      _isFieldLatitudeValid = true;
      _controllerLatitude.text = widget.assignedTask.latitude;

      _isFieldLongitudeValid = true;
      _controllerLongitude.text = widget.assignedTask.longitude;

      _isFieldUserIdValid = true;
      _controllerUserId.text = widget.assignedTask.user_id.toString();
    }
    super.initState();
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
                _buildTextFieldTask(),
                SizedBox(
                  height: 8.0,
                ),
                _buildTextFieldDescription(),
                SizedBox(
                  height: 8.0,
                ),
                _buildTextFieldCategory(),
                SizedBox(
                  height: 8.0,
                ),
                _buildTextFieldLatitude(),
                SizedBox(
                  height: 8.0,
                ),
                _buildTextFieldLongitude(),
                SizedBox(
                  height: 8.0,
                ),
                _buildTextFieldUserId(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_isFieldTaskValid == null ||
                          _isFieldDescriptionValid == null ||
                          _isFieldCategoryValid == null ||
                          _isFieldLatitudeValid == null ||
                          _isFieldLongitudeValid == null ||
                          _isFieldUserIdValid == null ||
                          !_isFieldTaskValid ||
                          !_isFieldDescriptionValid ||
                          !_isFieldCategoryValid ||
                          !_isFieldLatitudeValid ||
                          !_isFieldLongitudeValid ||
                          !_isFieldUserIdValid) {
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
                      String category = _controllerCategory.text.toString();
                      String latitude = _controllerLatitude.text.toString();
                      String longitude = _controllerLongitude.text.toString();
                      int user_id =
                          int.parse(_controllerUserId.text.toString());

                      AssignedTask assignedTask = AssignedTask(
                          task_name: task_name,
                          description: description,
                          category: category,
                          latitude: latitude,
                          longitude: longitude,
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
    return TextField(
      controller: _controllerCategory,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0)),
        labelText: "Category",
        errorText: _isFieldCategoryValid == null || _isFieldCategoryValid
            ? null
            : "Description is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldCategoryValid) {
          setState(() => _isFieldCategoryValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldLatitude() {
    return TextField(
      controller: _controllerLatitude,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0)),
        labelText: "Latitude",
        errorText: _isFieldLatitudeValid == null || _isFieldLatitudeValid
            ? null
            : "Latitude is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldLatitudeValid) {
          setState(() => _isFieldLatitudeValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldLongitude() {
    return TextField(
      controller: _controllerLongitude,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0)),
        labelText: "Longitude",
        errorText: _isFieldLongitudeValid == null || _isFieldLongitudeValid
            ? null
            : "Longitude is Required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldLongitudeValid) {
          setState(() => _isFieldLongitudeValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldUserId() {
    return TextField(
      controller: _controllerUserId,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0)),
        labelText: "User Id",
        errorText: _isFieldUserIdValid == null || _isFieldUserIdValid
            ? null
            : "User Id is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldUserIdValid) {
          setState(() => _isFieldUserIdValid = isFieldValid);
        }
      },
    );
  }
}
