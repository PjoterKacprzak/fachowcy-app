import 'package:fachowcy_app/Config/Config.dart';
import 'package:fachowcy_app/Data/UserProfileFromAdData.dart';
import 'package:fachowcy_app/src/customWidgets/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'customWidgets/AdCardSmall.dart';

class ProfileFromAd extends StatelessWidget {

  int adNumber;
  static var profileData;
  static int index;

  ProfileFromAd(int id) {
    this.adNumber = id;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.blueGrey,
          child: CustomScrollView(
            slivers: <Widget>[
              CustomAppBar(),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 30),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network("https://loremflickr.com/200/200",
                              width: 120, height: 120, fit: BoxFit.contain),
                        ),
                        SizedBox(height: 16),
                        UserNameSection(profileData.name, profileData.lastName),
                        ContactSection(profileData.phoneNumber, profileData.email),
                        RatingSection(),
                        UserAd(),
                        CommentSection(),

                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //metoda fromJSON
  static Future<int> getProfileDataByAdId(int id) async {
    var UserXML = {};

    UserXML["serviceCardId"] = id;
    String serviceCardId = json.encode(UserXML);

    final http.Response response = await http.post(
      Config.serverHostString + '/api/service-card/findUserByServiceCardID',
      headers: {'Content-Type': 'application/json'},
      body: serviceCardId,
    );

    Map userProfileDataMap = jsonDecode(response.body);
    var userProfileData = UserProfileFromAdData.fromJson(userProfileDataMap);
    int indexx;

    for(int i = 0; i < userProfileData.serviceCardLists.length; i++) {
      if(userProfileData.serviceCardLists[i].serviceCardId == id) {
        indexx = i;
        break;
      }
    }

    // TODO: CHECK THE REPOSONE NUMBERS

    if ((response.statusCode >= 200) && (response.statusCode <= 299)) {

      profileData = userProfileData;
      index = indexx;
      print("User profile data from ad received from server");
      return response.statusCode;
    } else {
      throw new Exception('Failed to load profile data.');
    }
  }
  
}

class UserNameSection extends StatelessWidget {

  String name;
  String lastName;


  UserNameSection(String name, String lastName) {
    this.name = name;
    this.lastName = lastName;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          name + " " + lastName,
          style: new TextStyle(color: Colors.white, fontSize: 32),
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: (){
            print("Portfolio");
          },
          child: Text(
            "Skomentuj użytkownika",
            style: new TextStyle(color: Colors.green, fontSize: 20),
          ),
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: (){
            print("Portfolio");
          },
          child: Text(
            "Zobacz portfolio",
            style: new TextStyle(color: Colors.green, fontSize: 20),
          ),
        ),
      ],
    );
  }

}

class ContactSection extends StatelessWidget {

  String telephone;
  String email;

  ContactSection(String telephone, String email) {
    this.telephone = telephone;
    this.email = email;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 16),
        Text(
          "Kontakt",
          style: new TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(height: 8),
        Text(
          telephone,
          style: new TextStyle(color: Colors.white, fontSize: 24),
        ),
        SizedBox(height: 8),
        Text(
          email,
          style: new TextStyle(color: Colors.white, fontSize: 24),
        ),
      ],
    );
  }

}



class RatingSection extends StatelessWidget {

  String numberOfOrder = "5";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 16),
        Text(
          "Ocena",
          style: new TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(height: 8),
        Row( //TODO: wczytywać gwiazdki za pomocą oceny użytkownika
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.star_rate, color: Colors.white),
            Icon(Icons.star_rate, color: Colors.white),
            Icon(Icons.star_rate, color: Colors.white),
            Icon(Icons.star_rate, color: Colors.white),
            Icon(Icons.star_rate, color: Colors.white),
          ],
        ),
        SizedBox(height: 16),
        Text(
          "Ilość zrealizowanych zleceń",
          style: new TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(height: 8),
        Text(
          numberOfOrder,
          style: new TextStyle(color: Colors.white, fontSize: 24),
        ),
      ],
    );
  }

}

class CommentSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 16),
        Text(
          "Komentarze",
          style: new TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(height: 8),
        Text(
          "tutaj cos bedzie",
          style: new TextStyle(color: Colors.white, fontSize: 24),
        )
      ],
    );
  }

}

//TODO: Feature builder i ładowanie z bazy
class UserAd extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 32),
        Text(
          "Ogłoszenia użytkownika",
          style: new TextStyle(color: Colors.white, fontSize: 16),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 0.65, //TODO: zrobić to mądrzej
          ),
          itemBuilder: (BuildContext context, int index) {

            return AdCardSmall(false, "Title", "Text text text Text text text Text text text Text text text Text text text ", 0);
          },
        ),
      ],
    );
  }


}