import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        )
      ],
    );
  }
}
