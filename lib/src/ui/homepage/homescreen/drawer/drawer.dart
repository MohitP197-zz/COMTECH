import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gdgbloc/src/bloc/bloc_user.dart';
import 'package:gdgbloc/src/bloc/getValue.dart';
import 'package:gdgbloc/src/login_page.dart';
import 'package:gdgbloc/src/reporisitories/user_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menues extends StatefulWidget {
  @override
  _MenuesState createState() => _MenuesState();
}

class _MenuesState extends State<Menues> {
  final userVal = new GetValue();
  String n;
  String e;

  @override
  void initState(){
    userName();
    userEmail();
    super.initState();
  }

  userName(){
    userVal.userNameCheck().then((value){
      print(value);
      setState((){
        n = value;
      });
    });
  }

    userEmail(){
    userVal.userEmailCheck().then((value){
      print(value);
      setState((){
        e = value;
      });
    });
  }
  

  final logoutBoc = Bloc();
  void _userLogout() async{
    var res = await CallApi().getData('logout');
    var body = json.decode(res.body);
    if(body['message'] != null){
      SharedPreferences localstorage = await SharedPreferences.getInstance();
      localstorage.remove('role');
      localstorage.remove('token');

      Navigator.push(context, new MaterialPageRoute(
        builder: (context)=> LoginPage()
      ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
       child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(n),
              accountEmail: Text(e),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.blue
                        : Colors.white,
                child: Text(
                  n[0],
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              title: Text("Settings"),
              trailing: Icon(FontAwesomeIcons.arrowRight),
              onTap: () {},
            ),
            ListTile(
              title: Text("Logout"),
              trailing: Icon(FontAwesomeIcons.arrowRight),
              onTap: _userLogout,
            ),
          ],
        ),
      
    );
  }
}