import 'dart:convert';
import 'package:gdgbloc/src/ui/homepage/bottom_navigation/feedback/feedback_model.dart';
import 'package:gdgbloc/src/ui/homepage/homescreen/officescreen/model/office_model.dart';
import 'package:gdgbloc/src/ui/homepage/homescreen/taskscreen/model/task_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' show Client;

class CallApi {
  final String _loginurl = 'http://nishuflutter.herokuapp.com/api/auth/';
  final String url = 'http://nishuflutter.herokuapp.com/api/user/';
  // final String baseurl = 'http://nishuflutter.herokuapp.com/';
  final String baseurl = 'http://10.0.2.2:8000/';

  final String urli = 'http://nishuflutter.herokuapp.com/api/task/';

  // final String urlii = 'http://nishuflutter.herokuapp.com/api/office/';
  // final String _loginurl = 'http://10.0.2.2:8000/api/auth/';
  // final String url = 'http://10.0.2.2:8000/api/user/';
  // final String urli = 'http://10.0.2.2:8000/api/task/';

  Client client = Client();

  //Login
  var token;
  postData(data, apiUrl) async {
    var fullUrl = _loginurl + apiUrl + await getToken();
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiUrl) async {
    var fullUrl = _loginurl + apiUrl + await getToken();
    return await http.get(fullUrl, headers: _setHeaders());
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token');
    return '?token=$token';
  }

  //Task
  Future<List<AssignedTask>> getAssignedTask() async {
    // final response = await client.get("$baseurl/api/task");
    final response = await client.get("http://10.0.2.2:8000/api/task");
    if (response.statusCode == 200) {
      return assignedTaskFromJson(response.body);
    } else {
      return null;
    }
  }

  // Create task
  Future<bool> createTask(AssignedTask data) async {
    print(assignedTaskToJson(data));
    final response = await client.post(
      "http://10.0.2.2:8000/api/task",
      headers: {"content-type": "application/json"},
      body: assignedTaskToJson(data),
    );
    print(response.statusCode);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  // Update Task
  Future<bool> updateTask(AssignedTask data) async {
    final response = await client.put(
      "$baseurl/api/task/${data.id}",
      headers: {"content-type": "application/json"},
      body: assignedTaskToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Delete Task
  Future<bool> deleteTask(int id) async {
    final response = await client.delete(
      "$baseurl/api/task/$id",
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

//Office
  Future<List<Office>> getOffice() async {
    final response = await client.get("$baseurl/api/office");
    print(response.body);
    if (response.statusCode == 200) {
      return officeFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> createFeedBack(FeedBackModel feed) async {
    final response = await client.post(
      "$baseurl/api/feedback",
      headers: {"content-type": "application/json"},
      body: feedBackModelToJson(feed),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
