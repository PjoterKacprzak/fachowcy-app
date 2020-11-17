import 'package:fachowcy_app/Config/Config.dart';
import 'package:fachowcy_app/Data/AdData.dart';
import 'package:fachowcy_app/src/UserProfile.dart';
import 'package:fachowcy_app/src/customWidgets/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../ProfileFromAd.dart';
import 'AdCardSmall.dart';

class AdCardLarge extends StatelessWidget {

  int id;

  AdCardLarge(int id) {
    this.id = id;
  }

  static var adData;
  static int index;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      SizedBox(height: 20),
                      Card(
                        color: Colors.blueGrey, //TODO: Zmienić kolor i dopasować do tła reszty
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(width: 4, color: Colors.white),
                        ),
                        child: Container(
                          //decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 4.0)),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 16),
                              HorizontalFotoSection(),
                              Container(
                                margin: const EdgeInsets.all(12),
                                child: Column(
                                  children: <Widget>[
                                    TextSection(adData.serviceCardLists[index].title, adData.serviceCardLists[index].estimatedTime, adData.serviceCardLists[index].description),
                                    SizedBox(height: 16),
                                    UserProfileShort(adData.name , adData.lastName ,"https://www.fillmurray.com/80/80", id),
                                    SizedBox(height: 16),
                                    LocalizationSection(adData.serviceCardLists[index].location, adData.phoneNumber),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 16),
                          Text("Podobne ogłoszenia", style: new TextStyle(color: Colors.white, fontSize: 24)),
                          SimilarAds(),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }


  static Future<int> getAdDataByAdId(int id) async {
    var UserXML = {};

    UserXML["serviceCardId"] = id;
    String serviceCardId = json.encode(UserXML);

    final http.Response response = await http.post(
      Config.serverHostString + '/api/service-card/findbyID',
      headers: {'Content-Type': 'application/json'},
      body: serviceCardId,
    );

    Map cardDataMap = jsonDecode(response.body);
    var cardData = AdData.fromJson(cardDataMap);
    int indexx;

    for(int i = 0; i < cardData.serviceCardLists.length; i++) {
      if(cardData.serviceCardLists[i].serviceCardId == id) {
        indexx = i;
        break;
      }
    }

    // TODO: CHECK THE REPOSONE NUMBERS

    if ((response.statusCode >= 200) && (response.statusCode <= 299)) {

      adData = cardData;
      index = indexx;
      print("Ad data received from server");
      return response.statusCode;
    } else {
      throw new Exception('Failed to load ad data.');
    }
  }
}

//TODO: rozszerzyć to do FutureBuildera
class SimilarAds extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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

        return AdCardSmall(false, "Title", "Text text text Text text text Text text text Text text text Text text text ", 0, "link_to_photo");
      },
    );
  }

}

class TextSection extends StatelessWidget {

  String title;
  String estimatedTime;
  String text;

  TextSection(String title, String estimatedTime, String text) {
    this.title = title;
    this.estimatedTime = estimatedTime;
    this.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 32),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 16),
        Row(
          children: <Widget>[
            Icon(Icons.timer, color: Colors.green),
            SizedBox(width: 8),
            Text(
              estimatedTime,
              style: new TextStyle(color: Colors.white, fontSize: 24),
            ),

          ],
        ),
        SizedBox(height: 16),
        Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          maxLines: 8,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

}

class LocalizationSection extends StatelessWidget {

  String location;
  String phone;

  LocalizationSection(String location, String phone) {
    this.location = location;
    this.phone = phone;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.location_on, color: Colors.white),
            SizedBox(width: 8),
            Text(
              location,
              style: new TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: <Widget>[
            Icon(Icons.phone, color: Colors.white),
            SizedBox(width: 8),
            Text(
              phone,
              style: new TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }

}

class UserProfileShort extends StatelessWidget {

  String name;
  String lastName;
  String photoLink;
  int id;

  UserProfileShort(String name, String lastName, String photoLink, int id) {
    this.name = name;
    this.lastName = lastName;
    this.photoLink = photoLink;
    this.id = id;
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        await ProfileFromAd.getProfileDataByAdId(id);

        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileFromAd(id)));
      },
      child: Row(
        children: <Widget>[
          Icon(Icons.person, color: Colors.white),
          SizedBox(width: 8),
          Column(
            children: <Widget>[
              Text(
                name,
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              Text(
                lastName,
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ],
          ),
          SizedBox(width: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(photoLink,
                width: 60, height: 60, fit: BoxFit.contain),
          ),

        ],
      ),
    );
  }

}

class HorizontalFotoSection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[

              Container(
                color: Colors.red, // Yellow
                height: 200.0,
                width: 200.0,
              ),

              Image.network('https://www.fillmurray.com//300/200',
                  width: 300, height: 200, fit: BoxFit.contain),

              Image.network('https://www.fillmurray.com//640/360',
                  width: 200, fit: BoxFit.contain),

              Container(
                color: Colors.pink, // Yellow
                height: 200.0,
                width: 200.0,
              ),

              Image.network('https://www.fillmurray.com//300/200',
                  width: 300, height: 200, fit: BoxFit.contain),

              Container(
                color: Colors.green, // Yellow
                height: 200.0,
                width: 200.0,
              ),

              Image.network('https://www.fillmurray.com//500/200',
                  width: 300, height: 200, fit: BoxFit.contain),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

}