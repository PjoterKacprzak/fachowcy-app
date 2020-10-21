import 'dart:convert';

import 'package:fachowcy_app/Data/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'RegisterPage.dart';
class UserMainPage extends StatefulWidget {
  UserMainPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _UserMainPageState createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        //TODO: Wywalić go
        title: Text("Fachowcy"),
        backgroundColor: Colors.blue,
        brightness: Brightness.dark,
      ),
      body: Center(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1, // 20%
              child: Container(),
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



  Future getAllCards ()async {

    final http.Response response = await http.get(
        'http://10.0.2.2:8080/api/cards/getAll',
        headers:{'Content-Type': 'application/json'},
    );
    print(response.statusCode);
    // CHECK THE REPOSONE NUMBERS
    if ((response.statusCode >= 200)||(response.statusCode <=299)) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to find Card.');
    }
  }


}