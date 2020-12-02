import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:fachowcy_app/Config/Config.dart';
import 'package:fachowcy_app/Data/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'UserProfile.dart';

class PasswordValidator {
  static String validate(String value) {
    Pattern pattern = r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Błedny format';
    else
      return null;
  }
}

class ChangePasswordFromUserProfile extends StatelessWidget {
//  String userEmail;
//  String userOldPassword;

//  ChangePasswordFromUserProfile(String userEmail) {
//    this.userEmail = userEmail;
//    print(userEmail);
//  }

  TextEditingController oldPasswordController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPassowrdController = new TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String _password, _confirmPassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: HexColor(Config.mainColor),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              margin: MediaQuery.of(context).orientation == Orientation.portrait
                  ? const EdgeInsets.only(left: 40, right: 40, top: 120)
                  : const EdgeInsets.only(left: 40, right: 40, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30),
                  TextFormField(
                    controller: oldPasswordController,
                    validator: PasswordValidator.validate,
                    onSaved: (password) => _password = password,
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
                      labelText: 'Stare hasło',
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
                  SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    validator: PasswordValidator.validate,
                    onSaved: (password) => _password = password,
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
                      labelText: 'Nowe hasło',
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
                  SizedBox(height: 10),
                  TextFormField(
                    controller: confirmPassowrdController,
                    validator: (confirmPassword) {
                      Pattern pattern =
                          r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$';
                      RegExp regex = new RegExp(pattern);
                      if (!regex.hasMatch(confirmPassword))
                        return 'Błedny format';
                      else
                        return null;
                    },
                    onSaved: (confirmPassword) =>
                        _confirmPassword = confirmPassword,
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
                      labelText: 'Powtórz nowe hasło',
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
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? Column(
                          children: <Widget>[
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
                                  onPressed: () async {
                                    final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    final String userEmail =
                                        prefs.getString('email');

                                    if (_formKey.currentState.validate()) {
                                      {
                                        if (await checkOldPassword(userEmail,
                                                oldPasswordController.text) ==
                                            1) {
                                          _showToastWrong(context,
                                              'Stare hasło jest nieprawidłowe!');
                                          print("Old password is wrong");
                                        } else if (passwordController.text !=
                                            confirmPassowrdController.text) {
                                          _showToastWrong(
                                              context, 'Hasła są różne!');
                                          print("Passwords are different");
                                        } else {
                                          _formKey.currentState.save();

                                          changePassword(userEmail, _password);
                                          _showToastGood(context,
                                              'Hasło zostało zmienione!');

//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (context) => UserProfile()));
                                        }
                                      }
                                    }
                                  },
                                  child: Text(
                                    "Zmień hasło",
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            FlatButton(
                              color: HexColor(Config.buttonColor),
                              textColor: Colors.white,
                              padding: EdgeInsets.all(16.0),
                              splashColor: Colors.greenAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              onPressed: () {
                                Navigator.pop(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserProfile()));
                              },
                              child: Text(
                                "Wróć",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
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
                                  onPressed: () async {
                                    final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    final String userEmail =
                                        prefs.getString('email');

                                    if (_formKey.currentState.validate()) {
                                      {
                                        if (await checkOldPassword(userEmail,
                                                oldPasswordController.text) ==
                                            1) {
                                          _showToastWrong(context,
                                              'Stare hasło jest nieprawidłowe!');
                                          print("Old password is wrong");
                                        } else if (passwordController.text !=
                                            confirmPassowrdController.text) {
                                          _showToastWrong(
                                              context, 'Hasła są różne!');
                                          print("Passwords are different");
                                        } else {
                                          _formKey.currentState.save();

                                          changePassword(userEmail, _password);
                                          _showToastGood(context,
                                              'Hasło zostało zmienione!');

//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (context) => UserProfile()));
                                        }
                                      }
                                    }
                                  },
                                  child: Text(
                                    "Zmień hasło",
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            FlatButton(
                              color: HexColor(Config.buttonColor),
                              textColor: Colors.white,
                              padding: EdgeInsets.all(16.0),
                              splashColor: Colors.greenAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              onPressed: () {
                                Navigator.pop(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserProfile()));
                              },
                              child: Text(
                                "Wróć",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ));
  }

  void _showToastGood(BuildContext context, String message) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: HexColor(Config.buttonColor),
        content: new Text(message, style: const TextStyle(fontSize: 20)),
        action: SnackBarAction(
            label: 'Zamknij',
            onPressed: scaffold.hideCurrentSnackBar,
            textColor: Colors.white),
      ),
    );
  }

  void _showToastWrong(BuildContext context, String message) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent,
        content: new Text(message, style: const TextStyle(fontSize: 20)),
        action: SnackBarAction(
            label: 'Zamknij',
            onPressed: scaffold.hideCurrentSnackBar,
            textColor: Colors.white),
      ),
    );
  }

  Future<int> checkOldPassword(String email, String password) async {
    var UserXML = {};
    UserXML["name"] = '';
    UserXML["lastName"] = '';
    UserXML["password"] = password;
    UserXML["telephone"] = '';
    UserXML["adresse"] = '';
    UserXML["email"] = email;
    String str = json.encode(UserXML);

    final http.Response response = await http.post(
        Config.serverHostString + '/api/users/login',
        headers: {'Content-Type': 'application/json'},
        body: str);

    // CHECK THE REPOSONE NUMBERS
    if ((response.statusCode >= 200) && (response.statusCode <= 299)) {
      print(123);
      print(response.statusCode);
      return 0;
    } else
      return 1;
  }

  static Future<int> changePassword(String email, String newPassword) async {
    var UserXML = {};
    UserXML["email"] = email;
    UserXML["password"] = newPassword;
    String newPasswordBody = json.encode(UserXML);

    final http.Response response = await http.post(
      Config.serverHostString + '/api/users/update-password',
      headers: {'Content-Type': 'application/json'},
      body: newPasswordBody,
    );

    // TODO: CHECK THE REPOSONE NUMBERS

    if ((response.statusCode >= 200) && (response.statusCode <= 299)) {
      print("Password changed for user with email: " + email + ".");
      return response.statusCode;
    } else {
      throw new Exception(
          "Failed to change password for user with email " + email + ".");
    }
  }
}
