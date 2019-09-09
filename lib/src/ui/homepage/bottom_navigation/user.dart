import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gdgbloc/src/bloc/bloc_user.dart';
import 'package:gdgbloc/src/bloc/getValue.dart';
import 'package:gdgbloc/src/reporisitories/user_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../login_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {

  @override
  void initState(){
    userName();
    super.initState();
  }
  final userVal = new GetValue();
  String n;

  userName() {
      userVal.userNameCheck().then((value) {
        print(value);
        setState(() {
          n = value;
        });
        // return value;
          });
      }

  
  final logoutBloc = Bloc();

   void _userlogout() async{
      // logout from the server ... 
      var res = await CallApi().getData('logout');
      var body =  json.decode(res.body);
      if(body['message'] != null ){
         SharedPreferences localStorage = await SharedPreferences.getInstance();
         localStorage.remove('role');
         localStorage.remove('token');
         Navigator.push(context,
        new MaterialPageRoute(
            builder: (context) => LoginPage()));

      }
  }

  
  @override
  Widget build(BuildContext context) {
    final app = TextStyle(
        color: Colors.white,
        fontSize: 26.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Lobster');
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile', style: app,),
        centerTitle: true,
        elevation: 0.0,

      ),

      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(height: 30.0,),
              Icon(FontAwesomeIcons.usersCog, size: 150.0,),
              SizedBox(height: 20.0,),
              Text(n, style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold,),),
              SizedBox(height: 24.0,),
              RaisedButton(
                child: Text('Logout'),
                onPressed: _userlogout,
                color: Colors.indigoAccent,
              ),

              SizedBox(height: 20.0,),

              GestureDetector(
                
                child: Text('Change Password', style: TextStyle(fontSize: 16.0),),
                onTap: (){},
              )
            ],
          )
        ],
      ),
      //  body: Center(
      //   child: RaisedButton(
      //     child: Text('Logout'),
      //     onPressed: _userlogout,
      //   ),
      // ),
     
      
    );
  }
}