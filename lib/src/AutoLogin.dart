import 'dart:convert';

import 'package:fachowcy_app/Config/Config.dart';
import 'package:fachowcy_app/Data/ServiceCard.dart';
import 'package:fachowcy_app/src/LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'UserMainPage.dart';
import 'customWidgets/Loader.dart';

class AutoLogin extends StatefulWidget {
  AutoLogin({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _AutoLoginState createState() => _AutoLoginState();
}

class _AutoLoginState extends State<AutoLogin> {
  
  
  
  @override
  void initState() {
    autoLogIn().then((value)
    {
      if(value==1)
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      UserMainPage()));
        }
      if(value==0)
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      LoginPage()));
        }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      home: Container(
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage("assets/logo.png"),fit: BoxFit.fill)),
      )
        );

    // return FutureBuilder<int>(
    //     future: autoLogIn(), // function where you call your api
    //     builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
    //       // AsyncSnapshot<Your object type>
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return Loader();
    //       } else {
    //         if (snapshot.hasError)
    //           return autoLoginFailure();
    //         else
    //           return autoLoginSuccess();
    //       }
    //     });
  }

  Widget autoLoginSuccess()
  {
    //_showToastGood(context);
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) =>
    //             UserMainPage()));

    return Scaffold();
  }

  Widget autoLoginFailure()
  {
    //_showToastGood(context);
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) =>
    //             LoginPage()));

    return Scaffold();
  }

  Future<int> autoLogIn() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userEmail = prefs.getString('email');
    final String userPassword = prefs.getString('password');

    if (userEmail != null && userPassword != null) {

      final temp = await loginFromSharedData(userEmail, userPassword);
      if(temp == 1)
        {
          return 1;
        }
      }
    return 0;
    }


  Future<int> loginFromSharedData(String email, String password) async {
    var userJson = {};
    // userJson["id"] = 4444;
    userJson["name"] = '';
    userJson["lastName"] = '';
    userJson["password"] = password;
    userJson["telephone"] = '';
    userJson["adresse"] = '';
    userJson["email"] = email;
    String str = json.encode(userJson);

    final http.Response response = await http.post(
        Config.serverHostString + 'api/users/loginHashed',
        headers: {'Content-Type': 'application/json'},
        body: str);
    if ((response.statusCode >= 200) && (response.statusCode <= 299)) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // User temp = User.fromJson(jsonDecode(response.body));
      prefs.setString('email', email);
      prefs.setString('password', password);
      return 1;

    }
    return 0;
  }
}
