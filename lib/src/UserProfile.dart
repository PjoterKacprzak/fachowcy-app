import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'customWidgets/CustomAppBar.dart';
import 'customWidgets/CustomBottomNavigation.dart';


class UserProfile extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
        appBar: AppBar(
        ),
        body:  CustomScrollView(
          slivers: <Widget>[
            CustomAppBar(),
            SliverList(
              delegate: SliverChildListDelegate([
                    Column(
                      children: <Widget>[
                        Text(
                          "Still preparing..",
                          style: TextStyle(color: Colors.red, fontSize: 50),
                        )
                      ],
                    )
                  ]
              ),
            )
          ],
        ),
        bottomNavigationBar: CustomBottomNavigation(),
      ),
    );
  }
}



