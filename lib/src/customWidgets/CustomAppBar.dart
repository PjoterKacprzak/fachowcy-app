import 'package:fachowcy_app/src/LoginPage.dart';
import 'package:fachowcy_app/src/UserMainPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../UserProfile.dart';
import '';

class CustomAppBar extends StatelessWidget {


  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: HexColor('#2162f3'),
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
            var result = await UserProfile.getDataFromJson();
            if(result==200) //TODO: zmienić żeby przechodziło bez http 200
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfile()));

          },
        ),
      ],
    );
  }

}
