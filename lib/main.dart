
import 'package:fachowcy_app/src/AutoLogin.dart';

import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // Comment for test



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FachOwcy',
      theme: ThemeData(

        primarySwatch: Colors.red,
      ),
      home: AutoLogin(title: 'FachOwcy'),
    );
  }
}


