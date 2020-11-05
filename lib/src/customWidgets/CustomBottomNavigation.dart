import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../UserProfile.dart';

class CustomBottomNavigation extends StatefulWidget {
  CustomBottomNavigation({Key key}) : super(key:key);
  @override
  CustomBottomNavigationState createState()=>CustomBottomNavigationState();
}
class CustomBottomNavigationState extends State<CustomBottomNavigation>{
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Center( child: Text('Home', textAlign: TextAlign.center)
    ),
    Text(
      'Filter'
    ),
    Text(
      'Add'
    ),
  ];
  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

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
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
