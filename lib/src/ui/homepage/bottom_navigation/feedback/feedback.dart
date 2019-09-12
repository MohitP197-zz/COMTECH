import 'package:flutter/material.dart';
import 'package:gdgbloc/src/reporisitories/user_api.dart';
import 'package:gdgbloc/src/ui/homepage/bottom_navigation/feedback/feedback_model.dart';
import 'package:gdgbloc/src/ui/homepage/homescreen/drawer/drawer.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class FeedBack extends StatefulWidget {
  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  bool _isLoading = false;
  CallApi _apifeed = CallApi();

  bool _isFieldTitleValid;
  bool _isFieldNameValid;
  bool _isFieldFeedBackValid;

  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerFeedBack = TextEditingController();

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
        title: Text(
          'Add FeedBack',
          style: app,
        ),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),
      drawer: Menues(),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTitleFieldName(),
                SizedBox(
                  height: 20.0,
                ),
                _buildTextFieldName(),
                SizedBox(
                  height: 20.0,
                ),
                _buildTextFieldFeedBack(),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_isFieldNameValid == null ||
                          _isFieldTitleValid == null ||
                          _isFieldFeedBackValid == null ||
                          !_isFieldNameValid ||
                          !_isFieldFeedBackValid ||
                          !_isFieldTitleValid) {
                        _scaffoldState.currentState.showSnackBar(SnackBar(
                          content: Text("Please all the fields"),
                        ));
                        return;
                      }

                      setState(() => _isLoading = true);

                      String title = _controllerTitle.text.toString();
                      String name = _controllerName.text.toString();
                      String description = _controllerFeedBack.text.toString();

                      FeedBackModel feed =
                          FeedBackModel(title: title, user_name: name, description: description);
                      _apifeed.createFeedBack(feed).then((isSuccess) {
                        setState(() => _isLoading = false);
                        if (isSuccess) {
                         Navigator.pop(_scaffoldState.currentState.context);
                        } else {
                          _scaffoldState.currentState.showSnackBar(
                            SnackBar(
                              content: Text("Submit data failed"),
                            ),
                          );
                        }
                      });
                    },
                    child:
                        Text("Submit", style: TextStyle(color: Colors.black87)),
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
                    )
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildTitleFieldName() {
    return TextField(
      controller: _controllerTitle,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0)),
        labelText: "Title",
        errorText: _isFieldTitleValid == null || _isFieldTitleValid
            ? null
            : "Full name is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldTitleValid) {
          setState(() {
            _isFieldTitleValid = isFieldValid;
          });
        }
      },
    );
  }

  Widget _buildTextFieldName() {
    return TextField(
      controller: _controllerName,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0)),
        labelText: "Full name",
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "Full name is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNameValid) {
          setState(() {
            _isFieldNameValid = isFieldValid;
          });
        }
      },
    );
  }

  Widget _buildTextFieldFeedBack() {
    return TextField(
      controller: _controllerFeedBack,
      keyboardType: TextInputType.text,
      maxLines: 4,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0)),
        labelText: "FeedBack name",
        errorText: _isFieldFeedBackValid == null || _isFieldFeedBackValid
            ? null
            : "Full name is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldFeedBackValid) {
          setState(() {
            _isFieldFeedBackValid = isFieldValid;
          });
        }
      },
    );
  }
}
