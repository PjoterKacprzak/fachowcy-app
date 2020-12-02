import 'dart:convert';
import 'package:fachowcy_app/Config/Config.dart';
import 'package:fachowcy_app/Data/ServiceCard.dart';
import 'package:fachowcy_app/src/NotificationPage.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'FavoriteAds.dart';
import 'HomePage.dart';
import 'FilterPage.dart';
import 'PostNewAd.dart';

class UserMainPage extends StatefulWidget {
  UserMainPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _UserMainPageState createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  int _selectedIndex = 0;

  static var data;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // body: Center(child: _widgetOptions.elementAt(_selectedIndex),),
        body: [HomePage(), FilterPage(), PostNewAd(), NotificationPage(), FavoriteAds()]
            .elementAt(_selectedIndex),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0)
            )
          ),
          child: BottomNavigationBar(
            unselectedItemColor: HexColor('#8a8a8a'),
            selectedItemColor:  HexColor('#40bb45'),
            backgroundColor: HexColor(Config.backgroundColor),
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Ogłoszenia',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Filtruj',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline),
                label: 'Dodaj',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Notyfikacje',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Ulubione',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
