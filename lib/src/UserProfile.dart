import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class UserProfile extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      //resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
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


}
