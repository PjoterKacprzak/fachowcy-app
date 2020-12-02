import 'dart:convert';

import 'package:fachowcy_app/Config/Authentication.dart';
import 'package:fachowcy_app/Config/Config.dart';
import 'package:fachowcy_app/Data/User.dart';
import 'package:fachowcy_app/src/customWidgets/Loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:hexcolor/hexcolor.dart';
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
  bool isLoading = false;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool isLoggedIn = false;
  String emailShared = '';
  String passwordShared = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Loader() : Scaffold(
      backgroundColor: HexColor(Config.mainColor),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 40, right: 40),
          child: Column(
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
              Builder(
                builder: (context) => Center(
                  child: FlatButton(
                    color: HexColor(Config.buttonColor),
                    textColor: Colors.white,
                    padding: EdgeInsets.all(16.0),
                    splashColor: Colors.greenAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    onPressed: ()async {
                      // setState(() => isLoading = true);
                      var result = await login(emailController.text,passwordController.text);
                      if(result==200) {
                        // setState(() => isLoading = false);
                        await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UserMainPage()));
                      } else {
                        // setState(() => isLoading = false);
                        _showToastWrong(context, 'Coś poszło nie tak!');
                      }
                    },
                    child: Text(
                      "Zaloguj się",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              FlatButton(
                color: HexColor(Config.buttonColor),
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
              SizedBox(height: 8),
              SignInButton(
                  Buttons.Facebook,
                  text: "Zaloguj przez Facebook",
                  padding: EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),

                  onPressed: () async{
                    Authentication auth = Authentication();
                    var resultFacebook = await auth.signInFB();
                    print(resultFacebook);

                    if(resultFacebook!=null)
                    {
                      RegisterPage().createUserFacebook(resultFacebook.values.elementAt(1), resultFacebook.values.elementAt(3), resultFacebook.values.elementAt(2),
                          '', '', resultFacebook.values.elementAt(3)+resultFacebook.values.elementAt(4),WhoUsing.user);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UserMainPage()));
                    }

                    // .whenComplete((onComplete) {
                    //   Navigator.of(context}.push(MaterialPageRoute(builder: (context)=>HomePage()));},
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showToastWrong(BuildContext context, String message) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent,
        content: new Text(message , style: const TextStyle(fontSize: 16)),
        action: SnackBarAction(
            label: 'Zamknij', onPressed: scaffold.hideCurrentSnackBar, textColor: Colors.white),
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
        Config.serverHostString + '/api/users/login',
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
        isLoggedIn = false;
        // isLoading = false;
      });

      return response.statusCode;
      // return User.fromJson(jsonDecode(response.body));
    }
    return response.statusCode;
  }




}