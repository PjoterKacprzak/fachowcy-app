import 'package:fachowcy_app/src/LoginPage.dart';
import 'package:fachowcy_app/src/UserMainPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../UserProfile.dart';
import '';

class CustomAppBar extends StatelessWidget {


  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.blue,
      leading: IconButton(
        icon: Icon(Icons.chevron_left), onPressed: () {  },
      ),
      floating: true,
      pinned: false,
      snap: false,
      centerTitle: true,
      title: TextButton(
          child: Text('Fachowcy', style: TextStyle(color: Colors.white, fontSize: 23)),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserMainPage()));
          },
        ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.person,
            color: Colors.white,),
          onPressed: ()async {
            //var result = await UserProfile.getDataFromJson();
            //if(result==200) //TODO: zmienić żeby przechodziło bez http 200
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfile()));

          },
//          onPressed: () {
//            Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => UserProfile()));
//          },
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
