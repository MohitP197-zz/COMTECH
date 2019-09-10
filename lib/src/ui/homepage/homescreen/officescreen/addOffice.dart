import 'package:flutter/material.dart';
import 'package:gdgbloc/src/reporisitories/user_api.dart';

import 'model/office_model.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class AddOfficeScreen extends StatefulWidget {
  Office office;
  AddOfficeScreen({this.office});

  @override
  _AddOfficeScreenState createState() => _AddOfficeScreenState();
}

class _AddOfficeScreenState extends State<AddOfficeScreen> {
  bool _isLoading = false;
  CallApi _apiService = CallApi();
  bool _isFieldOfficeValid;
  bool _isFieldDescriptionValid;
  bool _isFieldLocationValid;
  bool _isFieldUserIdValid;
  bool _isFieldTaskIdValid;

  TextEditingController _controllerOffice = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();
  TextEditingController _controllerLocation = TextEditingController();
  TextEditingController _controllerUserId = TextEditingController();
  TextEditingController _controllerTaskId = TextEditingController();

  @override
  void initState() {
    if (widget.office != null) {
      _isFieldOfficeValid = true;
      _controllerOffice.text = widget.office.office_name;

      _isFieldDescriptionValid = true;
      _controllerDescription.text = widget.office.description;

      _isFieldLocationValid = true;
      _controllerLocation.text = widget.office.location;

      _isFieldLocationValid = true;
      _controllerLocation.text = widget.office.location;

      _isFieldUserIdValid = true;
      _controllerUserId.text = widget.office.user_id.toString();

      _isFieldTaskIdValid = true;
      _controllerTaskId.text = widget.office.task_id.toString();
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
            widget.office == null ? "Add Office" : "Edit Office Details",
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
                _buildTextFieldOffice(),
                SizedBox(
                  height: 8.0,
                ),
                _buildTextFieldDescription(),
                SizedBox(
                  height: 8.0,
                ),
                _buildTextFieldLocation(),
                SizedBox(
                  height: 8.0,
                ),
                _buildTextFieldUserId(),
                SizedBox(
                  height: 8.0,
                ),
                _buildTextFieldTaskId(),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_isFieldOfficeValid == null ||
                          _isFieldDescriptionValid == null ||
                          _isFieldLocationValid == null ||
                          _isFieldTaskIdValid == null ||
                          _isFieldUserIdValid == null ||
                          !_isFieldOfficeValid ||
                          !_isFieldDescriptionValid ||
                          !_isFieldLocationValid ||
                          !_isFieldTaskIdValid ||
                          !_isFieldUserIdValid) {
                        _scaffoldState.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Please fill all field"),
                          ),
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      String office_name = _controllerOffice.text.toString();
                      String description =
                          _controllerDescription.text.toString();
                      String location = _controllerLocation.text.toString();
                      int task_id = int.parse(_controllerTaskId.text.toString());
                      int user_id =
                          int.parse(_controllerUserId.text.toString());

                      Office office = Office(
                          office_name: office_name,
                          description: description,
                          location: location,
                          task_id: task_id,
                          user_id: user_id);

                      // print(assignedTask);
                      if (widget.office == null) {
                        _apiService.createOffice(office).then((isSuccess) {
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
                        office.id = widget.office.id;
                        _apiService.updateOffice(office).then((isSuccess) {
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

  Widget _buildTextFieldOffice() {
    return TextField(
      controller: _controllerOffice,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0)),
        labelText: "Office name",
        errorText: _isFieldOfficeValid == null || _isFieldOfficeValid
            ? null
            : "Task name is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldOfficeValid) {
          setState(() => _isFieldOfficeValid = isFieldValid);
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

  Widget _buildTextFieldLocation() {
    return TextField(
      controller: _controllerLocation,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0)),
        labelText: "Category",
        errorText: _isFieldLocationValid == null || _isFieldLocationValid
            ? null
            : "Description is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldLocationValid) {
          setState(() => _isFieldLocationValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldTaskId() {
    return TextField(
      controller: _controllerTaskId,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0)),
        labelText: "Latitude",
        errorText: _isFieldTaskIdValid == null || _isFieldTaskIdValid
            ? null
            : "Latitude is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldTaskIdValid) {
          setState(() => _isFieldTaskIdValid = isFieldValid);
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
