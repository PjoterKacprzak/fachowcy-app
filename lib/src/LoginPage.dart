import 'dart:convert';

import 'package:fachowcy_app/Config/Config.dart';
import 'package:fachowcy_app/Data/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'RegisterPage.dart';
import 'UserMainPage.dart';
class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool isLoggedIn = false;
  String emailShared = '';
  String passwordShared = '';
  @override
  void initState() {
    super.initState();
    autoLogIn();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1, // 20%
              child: Container(),
            ),
            Expanded(
              flex: 8, // 60%
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  SizedBox(height: 80),
                  Text(
                    'Fachowcy',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 50, color: Colors.white)
                  ),
                  SizedBox(height: 80),
                  TextFormField(
                    controller: emailController,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                      ),
                      labelText: 'E-mail',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 3.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: Colors.white,
                      ),
                      labelText: 'Hasło',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 3.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  FlatButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(16.0),
                    splashColor: Colors.greenAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                    ),
                    onPressed: ()async {
                      var result = await login(emailController.text,passwordController.text);
                      print(result);
                      if(result==200)
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UserMainPage()));

                    },
                    child: Text(
                      "Zaloguj się",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Nie masz konta?",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  FlatButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(16.0),
                    splashColor: Colors.greenAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                    },
                    child: Text(
                      "Zarejestruj się",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
              ],
              ),
            ),
            Expanded(
              flex: 1, // 20%
              child: Container(),
            )
          ],
        ),
      ),
    );
  }

  Future<int>login(String email,String password)async {
    var UserXML = {};
    // UserXML["id"] = 4444;
    UserXML["name"] = '';
    UserXML["lastName"] = '';
    UserXML["password"] = password;
    UserXML["telephone"] = '';
    UserXML["adresse"] = '';
    UserXML["email"] = email;
    String str = json.encode(UserXML);

    emailController.clear();
    passwordController.clear();

    final http.Response response = await http.post(
       //'http://10.0.2.2:8080/api/users/login',
         'http://fachowcy-server.herokuapp.com/api/users/login',
        headers:{'Content-Type': 'application/json'},
        body: str
    );
    print('Login resposne code ' + response.statusCode.toString());
    print('Login resposne body ' + response.body.toString());
    // CHECK THE REPOSONE NUMBERS
    if ((response.statusCode >= 200)&&(response.statusCode <=299)) {

      final SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString('email', email);
      prefs.setString('password', response.body);
      setState(() {
        emailShared = emailController.text;
        passwordShared = passwordController.text;
        isLoggedIn = true;
      });

        return response.statusCode;
      // return User.fromJson(jsonDecode(response.body));
    }
    return response.statusCode;
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userEmail = prefs.getString('email');
    final String userPassword = prefs.getString('password');

    if (userEmail != null) {
      setState(() {
        isLoggedIn = true;
        emailShared = userEmail;
        passwordShared = userPassword;
      });
        final temp=  await loginFromSharedData(userEmail, userPassword);

        if(temp==1) {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserMainPage()));
          }
        else {
            print('Failed to Auto login');
          }
      };

    }



  Future<int> loginFromSharedData(String email,String password)async {
    var UserXML = {};
    // UserXML["id"] = 4444;
    UserXML["name"] = '';
    UserXML["lastName"] = '';
    UserXML["password"] = password;
    UserXML["telephone"] = '';
    UserXML["adresse"] = '';
    UserXML["email"] = email;
    String str = json.encode(UserXML);

    emailController.clear();
    passwordController.clear();


    final http.Response response = await http.post(
        Config.serverHostString + 'api/users/loginHashed',
        headers:{'Content-Type': 'application/json'},
        body: str
    );
    print('Auto login response code '  + response.statusCode.toString());
    print('Auto login response body '  + response.body.toString());
    // CHECK THE REPOSONE NUMBERS
    if ((response.statusCode >= 200)&&(response.statusCode <=299)) {

      final SharedPreferences prefs = await SharedPreferences.getInstance();

     // User temp = User.fromJson(jsonDecode(response.body));
      prefs.setString('email', email);
      prefs.setString('password', password);
      setState(() {
        emailShared = email;
        passwordShared = password;
        isLoggedIn = true;
      });
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserMainPage()));
      // return User.fromJson(jsonDecode(response.body));
      return 1;
    }
    else
      return 0;

    }


}