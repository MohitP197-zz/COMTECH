import 'package:flutter/material.dart';
import 'bloc/bloc_user.dart';
import 'ui/homepage/home_page.dart';

final loginbloc = Bloc();

class LoginPage extends StatelessWidget {
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
    final imgfield = Image.asset(
      'images/logo/logo1.jpg',
      width: 300.0,
      fit: BoxFit.cover,
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // color: Colors.white,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.blue, Colors.white]),
          ),
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(16.0),
          child: ListView(
            // mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Complain Management System",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontSize: 25.0, fontFamily: 'Lobster'),
              ),
              imgfield,
              SizedBox(
                height: 20.0,
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
                height: 20.0,
              ),
              StreamBuilder<bool>(
                stream: loginbloc.submitCheck,
                builder: (context, snapshot) => RaisedButton(
                  elevation: 12.0,
                  color: Colors.tealAccent,
                  onPressed:
                      snapshot.hasData ? () => changeThePage(context) : null,
                  child: Text("Login"),
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
}
