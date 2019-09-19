import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'bloc/bloc_user.dart';
import 'ui/homepage/home_page.dart';

final loginbloc = Bloc();

class LoginPage extends StatefulWidget {
  @override
  _MyLoginPage createState() => _MyLoginPage();
}

class _MyLoginPage extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  int _state = 0;
  double _width = double.infinity;
  Animation _animation;
  GlobalKey _globalKey = GlobalKey();
  bool _isButtonDisabled = false;

  changeThePage(BuildContext context) async {
    int bloclogin = await loginbloc.userCheck();
    if (bloclogin == 0) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => PageTwo()));
    } else {
      print('you are beautiful');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final imgfield = Image.asset(
    //   'assets/images/comtech.png',
    //   width: 300.0,
    //   height: 250,
    //   fit: BoxFit.cover,
    // );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          key: _globalKey,
          // color: Colors.white,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.green, Colors.white]),
          ),
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(16.0),
          child: ListView(
            // mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text("COMTECH",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 30.0)),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              ListTile(
                title: Text("A Task Management App",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.yellow, fontSize: 20.0)),
              ),
              SizedBox(
                height: 25.0,
              ),
              StreamBuilder<String>(
                stream: loginbloc.email,
                builder: (context, snapshot) => TextField(
                  controller: loginbloc.emailcon,
                  onChanged: loginbloc.emailChanged,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      hintText: "Enter email",
                      labelText: "Email",
                      errorText: snapshot.error),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              StreamBuilder<String>(
                stream: loginbloc.password,
                builder: (context, snapshot) => TextField(
                  controller: loginbloc.pascon,
                  onChanged: loginbloc.passwordChanged,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      hintText: "Enter password",
                      labelText: "Password",
                      errorText: snapshot.error),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              StreamBuilder<bool>(
                stream: loginbloc.submitCheck,
                builder: (context, snapshot) => RaisedButton(
                  color: _state == 2 ? Colors.green : Colors.green,
                  elevation: 12.0,
                  onPressed: () {
                    snapshot.hasData ? changeThePage(context) : null;
                    setState(() {
                      _isPressed = _isPressed;
                      if (_state == 0) {
                        animateButton();
                      }
                    });
                  },
                  child: buildButtonChild(),
                ),
                // ),
              ),
              SizedBox(
                height: 10.0,
              ),
              FlatButton(
                child: Text(
                  'Privacy Policy',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  void animateButton() {
    double initialWidth = _globalKey.currentContext.size.width;

    var controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);

    _animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          _width = initialWidth - ((initialWidth - 48.0) * _animation.value);
        });
      });

    controller.forward();

    setState(() {
      _state = 1;
    });
    Timer(Duration(milliseconds: 3300), () {
      setState(() {
        _state = 2;
      });
    });
  }

  Widget buildButtonChild() {
    if (_state == 0) {
      return Padding(
        padding: const EdgeInsets.all(15),
        child: Text(
          "Login",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      );
    } else if (_state == 1) {
      return SizedBox(
          height: 34.0,
          width: 36.0,
          child: CircularProgressIndicator(
              value: null,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red)));
    } else {
      return Icon(FontAwesomeIcons.times, color: Colors.white);
    }
  }
}
