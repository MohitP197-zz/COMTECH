import 'package:shared_preferences/shared_preferences.dart';


   class GetValue{
    SharedPreferences localStorage;
     
    Future<String> userCheck() async{
      localStorage = await SharedPreferences.getInstance();
      String check = localStorage.getString('role').toString();

      return check;
    }

      Future<String> userNameCheck() async{
      localStorage = await SharedPreferences.getInstance();
      String name = localStorage.getString('name').toString();

      return name;
    }

     Future<String> userEmailCheck() async{
      localStorage = await SharedPreferences.getInstance();
      String email = localStorage.getString('email').toString();

      return email;
    }
    
  
  
  }