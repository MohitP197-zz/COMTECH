import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:gdgbloc/src/reporisitories/user_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'validator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/cupertino.dart';

class Bloc extends Object with Validators implements BaseBloc {
  TextEditingController emailcon = new TextEditingController();
  TextEditingController pascon = new TextEditingController();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Function(String) get emailChanged => _emailController.sink.add;
  Function(String) get passwordChanged => _passwordController.sink.add;

  Stream<String> get email => _emailController.stream.transform(emailValidator);
  Stream<String> get password =>
      _passwordController.stream.transform(passwordValidator);

  Stream<bool> get submitCheck =>
      Observable.combineLatest2(email, password, (e, p) => true);

  //check user
  userCheck() async {
    var data = {'email': emailcon.text, 'password': pascon.text};

    var res = await CallApi().postData(data, 'login');
    var body = json.decode(res.body);
    print(body);

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('role', body['role']);
    localStorage.setString('id', body['id'].toString());
    // var user_role = localStorage.getString('role');
    print(localStorage.getString('email'));
    print(localStorage.getString('id'));

    if (body['access_token'] != null) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['access_token']);
      localStorage.setString('role', body['role']);
      localStorage.setString('id', body['id'].toString());
      localStorage.setString('name', body['name']);
      localStorage.setString('email', body['email']);
      //  getin = localStorage.getString('role');

      // print(localStorage.getString('token'));
      // print(localStorage.getString('role'));
      // print(jsonDecode(body['name']));
      // print(json.decode(res.body));
      return 0;
    } else {
      return 1;
    }
  }

  //  List userTask;

  // getTask() async{
  //   var res = await CallApi().getData('task');
  //   var userTaskConvert = json.decode(res.body);
  //     userTask =  userTaskConvert["data"];
  //     print(userTask[0]["description"]);
  //   // print(res);
  //   // print(res[0]['description']);
  //   return res;
  // }

  @override
  void dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}

abstract class BaseBloc {
  void dispose();
}
