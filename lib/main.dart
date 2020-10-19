import 'dart:convert';

import 'package:fachowcy_app/src/LoginPage.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'Data/User.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FachOwcy',
      theme: ThemeData(

        primarySwatch: Colors.red,
      ),
      home: LoginPage(title: 'FachOwcy'),
    );
  }
}


