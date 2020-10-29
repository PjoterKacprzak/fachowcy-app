import 'dart:convert';

import 'package:fachowcy_app/src/customWidgets/AdCardSmall.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'customWidgets/CustomAppBar.dart';
import 'customWidgets/CustomBottomNavigation.dart';


class UserProfile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
        body:  Container(
          color: Colors.blueGrey,
          child: CustomScrollView(
            slivers: <Widget>[
              CustomAppBar(),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child:Column(
                      children: <Widget>[
                        SizedBox(height: 30),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: 120,
                            height: 120,
                            color: Colors.grey,
                            child: Center(
                              child: Text(
                                "Foto",
                                style: new TextStyle(fontSize: 30),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        CustomLabels("Imię i nazwisko", "Loremiak Ipsumiak"),
                        CustomLabels("E-mail", "loremiak.ipsumiak@gmail.com"),
                        CustomLabels("Hasło", "***********"),
                        CustomLabels("Twoje ogłoszenia", ""),
                        Wrap(
                          spacing: 24,
                          runSpacing: 24,
                          children: [
                            AdCardSmall(true ,"Wiercenie", "Mogę zaproponować usługę wiercenia!"),
                            AdCardSmall(true ,"Koszenie", "Kosze trawę raz dwa trzy i jestem do usług"),
                            AdCardSmall(true ,"Spacer", "Jestem bogiem spacerów i chce cie wyprowadzić"),
                            AdCardSmall(true ,"Pływanie", "Personalny trening pływania dla osób w każdym wieku - dorośli oraz dzieci"),
                            AdCardSmall(true ,"Sprzątanie", "Sprzątam niczym Rozenek i możesz sprawdzić to robiąc test białej rekawiczki!!!"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
                ),
              )
            ],
          ),
        ),

        bottomNavigationBar: CustomBottomNavigation(),
      ),
    );
  }
}

class CustomLabels extends StatelessWidget {

  String name;
  String dataString;

  CustomLabels(String name, String dataString) {
    this.name = name;
    this.dataString = dataString;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 16),
          Center(
            child: Column(
              children: <Widget>[
                Text(
                  name,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  dataString,
                  style: const TextStyle(color: Colors.white, fontSize: 26),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}

