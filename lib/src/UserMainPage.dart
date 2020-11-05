import 'dart:convert';

import 'package:fachowcy_app/Config/Config.dart';
import 'package:fachowcy_app/Data/ServiceCard.dart';
import 'package:fachowcy_app/Data/User.dart';
import 'package:fachowcy_app/src/LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'HomePage.dart';
import 'FilterPage.dart';
import 'PostNewAd.dart';
import 'customWidgets/CustomAppBar.dart';
import 'customWidgets/CustomBottomNavigation.dart';
import 'RegisterPage.dart';
import 'UserProfile.dart';

class UserMainPage extends StatefulWidget {
  UserMainPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _UserMainPageState createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    FilterPage(),
    PostNewAd(),
    Text('Tu będą wiadomości', style: TextStyle(fontSize: 30)),
    Text('Tu będą powiadomienia',style: TextStyle(fontSize: 30))
  ];
  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  Future<List<ServiceCard>> serviceCard;

  @override
  void initState() {
    serviceCard=getAllCards();
   // print(serviceCard);
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        home :Scaffold(
          body: Center(child: _widgetOptions.elementAt(_selectedIndex),),
          bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Ogłoszenia',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Filtruj',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline),
                label: 'Dodaj',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: 'Wiadomości',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Powiadomienia',
              backgroundColor: Colors.blue,
            ),

          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }



  Future<List<ServiceCard>> getAllCards ()async {

    ServiceCard serviceCard = new ServiceCard();

    final http.Response response = await http.get(
        Config.serverHostString + 'api/service-card/all',
        headers:{'Content-Type': 'application/json'},
    );

    // CHECK THE REPOSONE NUMBERS

    //print(serviceCard.parseServiceCard(response.body));
    if ((response.statusCode >= 200)&&(response.statusCode <=299)) {
        // print(serviceCard.parseServiceCard(response.body));
      return serviceCard.parseServiceCard(response.body);ServiceCard.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to find Card.');
    }
  }


}