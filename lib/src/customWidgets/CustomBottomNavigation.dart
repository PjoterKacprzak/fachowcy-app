import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../UserProfile.dart';

class CustomBottomNavigation extends StatelessWidget {
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
            backgroundColor: Colors.black
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'search',
            backgroundColor: Colors.black
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'add',
            backgroundColor: Colors.black
        ),
      ],
    );
  }
}
