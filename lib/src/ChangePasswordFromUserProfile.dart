import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:fachowcy_app/Config/Config.dart';
import 'package:fachowcy_app/Data/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'UserProfile.dart';


class PasswordValidator{
  static String validate(String value){
    Pattern pattern =
        r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Błedny format';
    else
      return null;
  }
}


class ChangePasswordFromUserProfile extends StatelessWidget {

  String userEmail;
  String userNewPassword;

  ChangePasswordFromUserProfile(String userEmail) {
    this.userEmail = userEmail;
  }

  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPassowrdController = new TextEditingController();


  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String _password,_confirmPassword= "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.blue,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.only(left: 40, right: 40, top: 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  SizedBox(height: 30),
                  TextFormField(
                    controller: passwordController,
                    validator:PasswordValidator.validate,
                    onSaved: (password)=> _password = password,
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
                  SizedBox(height: 10),
                  TextFormField(
                    controller: confirmPassowrdController,
                    validator: (confirmPassword){
                      Pattern pattern =
                          r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$';
                      RegExp regex = new RegExp(pattern);
                      if (!regex.hasMatch(confirmPassword))
                        return 'Błedny format';
                      else
                        return null;
                    },
                    onSaved: (confirmPassword)=> _confirmPassword = confirmPassword,
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
                      labelText: 'Powtórz hasło',
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
                        color: Colors.green,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(16.0),
                        splashColor: Colors.greenAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        onPressed: () {

                          if(_formKey.currentState.validate()){
                            {
                              if (passwordController.text !=
                                  confirmPassowrdController.text) {
                                _showToastWrong(context);
                                print("Passwords are different");
                              }
                              else {
                                _formKey.currentState.save();

                                changePassword(userEmail, _password);
                                _showToastGood(context);

//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (context) => UserProfile()));
                              }
                            }
                          }},

                        child: Text(
                          "Zmień hasło",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 16),
                  FlatButton(
                    color: Colors.green,
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
            ),
          ),
        ));
  }

  void _showToastGood(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: const Text('Hasło zostało zmienione!', style: const TextStyle(fontSize: 20)),
        action: SnackBarAction(
            label: 'Zamknij', onPressed: scaffold.hideCurrentSnackBar, textColor: Colors.white),
      ),
    );

  }

  void _showToastWrong(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: const Text('Hasła są różne!', style: const TextStyle(fontSize: 20)),
        action: SnackBarAction(
            label: 'Zamknij', onPressed: scaffold.hideCurrentSnackBar, textColor: Colors.white),
      ),
    );

  }

  static Future<int> changePassword(String email, String newPassword) async {
    var UserXML = {};
    UserXML["email"] = email;
    UserXML["password"] = newPassword;
    String newPasswordBody = json.encode(UserXML);

    final http.Response response = await http.post(
      Config.serverHostString +  '/api/users/update-password',
      headers:{'Content-Type': 'application/json'},
      body: newPasswordBody,
    );


    // TODO: CHECK THE REPOSONE NUMBERS

    if ((response.statusCode >= 200)&&(response.statusCode <=299)) {

      print("Password changed for user with email: " + email + ".");
      return response.statusCode;
    } else {
      throw new Exception("Failed to change password for user with email " + email + ".");
    }
  }

}