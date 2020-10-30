import 'package:fachowcy_app/src/LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../UserProfile.dart';

class CustomAppBar extends StatelessWidget {
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('Fachowcy'),
      backgroundColor: Colors.blue,
      floating: true,
      pinned: false,
      snap: false,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.notifications,
            color: Colors.white,),
        ),
        IconButton(
          icon: Icon(
            Icons.message,
            color: Colors.white,),
        ),
        IconButton(
          icon: Icon(
            Icons.person,
            color: Colors.white,),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfile()));
          },
        ),
        IconButton(
          icon: Icon(
            Icons.logout,
            color: Colors.white,),
          onPressed: () {
            logout();

            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()));
          },
        )
      ],
    );
  }

  Future<Null> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', null);
    prefs.setString('password', null);
  }

}
