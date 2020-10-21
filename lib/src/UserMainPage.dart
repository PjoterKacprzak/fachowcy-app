import 'dart:convert';

import 'package:fachowcy_app/Data/ServiceCard.dart';
import 'package:fachowcy_app/Data/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'RegisterPage.dart';
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
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  Future<List<ServiceCard>> serviceCard;

  @override
  void initState() {
    serviceCard=getAllCards();
    print(serviceCard);
    super.initState();

  }

  @override
  Widget build(BuildContext context) {





    return MaterialApp(

      home: Scaffold(
        appBar: AppBar(
        ),
        body:  CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
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
                )
              ],
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Text("test "),
                  );
                },
                childCount: 50,
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
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
        ),
      ),
    );
  }



  Future<List<ServiceCard>> getAllCards ()async {

    ServiceCard serviceCard = new ServiceCard();

    final http.Response response = await http.get(
       //'http://10.0.2.2:8080/api/service-card/all',
       'https://fachowcy-server.herokuapp.com/api/service-card/all',
        headers:{'Content-Type': 'application/json'},
    );

    // CHECK THE REPOSONE NUMBERS

    //print(serviceCard.parseServiceCard(response.body));
    if ((response.statusCode >= 200)&&(response.statusCode <=299)) {
         print(serviceCard.parseServiceCard(response.body));
      return serviceCard.parseServiceCard(response.body);ServiceCard.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to find Card.');
    }
  }


}