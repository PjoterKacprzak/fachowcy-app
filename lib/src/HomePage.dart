import 'dart:convert';

import 'package:fachowcy_app/Data/ServiceCard.dart';
import 'package:fachowcy_app/Data/User.dart';
import 'package:fachowcy_app/src/LoginPage.dart';
import 'package:fachowcy_app/src/customWidgets/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'customWidgets/AdCardSmall.dart';


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width*0.5,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(),
                                padding: EdgeInsets.all(16.0),
                                color: Colors.lightBlue,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                onPressed: (){},
                                child: Text('PŁATNE', style: TextStyle(fontSize: 20)),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width*0.5,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(),
                                padding: EdgeInsets.all(16.0),
                                color: Colors.lightBlue,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                onPressed: (){},
                                child: Text('WYMIANA', style: TextStyle(fontSize: 20)),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 24,
                  runSpacing: 24,
                  children: [
                    AdCardSmall(false, "Title", "xxx"),
                    AdCardSmall(false, "Title", "xxx"),
                    AdCardSmall(false, "Title", "xxx"),
                    AdCardSmall(false, "Title", "xxx"),
                    AdCardSmall(false, "Title", "xxx"),
                    AdCardSmall(false, "Title", "xxx"),
                    AdCardSmall(false, "Title", "xxx"),
                    AdCardSmall(false, "Title", "xxx"),
                    AdCardSmall(false, "Title", "xxx"),
                    AdCardSmall(false, "Title", "xxx"),
                    AdCardSmall(false, "Title", "xxx"),
                    AdCardSmall(false, "Title", "xxx"),
                    AdCardSmall(false, "Title", "xxx"),
                    AdCardSmall(false, "Title", "xxx"),

                  ],
                ),
                SizedBox(height: 10)
              ]
            )
          )
        ],
      ),
    );
  }
}