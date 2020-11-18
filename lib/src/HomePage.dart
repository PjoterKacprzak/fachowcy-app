import 'dart:convert';
import 'package:fachowcy_app/Config/Config.dart';
import 'package:fachowcy_app/Data/ServiceCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'UserMainPage.dart';
import 'UserProfile.dart';
import 'customWidgets/AdCardSmall.dart';

class HomePage extends StatelessWidget {
  static var cardInfoData;

  static Future<int> getAllCards() async {
    ServiceCard serviceCard = new ServiceCard();

    final http.Response response = await http.get(
      Config.serverHostString + 'api/service-card/all',
      headers: {'Content-Type': 'application/json'},
    );

    if ((response.statusCode >= 200) && (response.statusCode <= 299)) {
      cardInfoData = serviceCard.parseServiceCard(response.body);
      print("CardData received");
      return response.statusCode;
    } else {
      throw Exception('Failed to find Card.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.blueAccent,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: Colors.blue,
                  floating: true,
                  pinned: false,
                  snap: false,
                  centerTitle: true,
                  title: TextButton(
                    child: Text('Fachowcy',
                        style: TextStyle(color: Colors.white, fontSize: 23)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserMainPage()));
                    },
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        var result = await UserProfile.getDataFromJson();
                        if (result ==
                            200) //TODO: zmienić żeby przechodziło bez http 200
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserProfile()));
                      },
                    ),
                  ],
                  bottom: TabBar(
                    tabs: <Widget>[
                      Tab(
                        text: "PŁATNE",
                      ),
                      Tab(
                        text: "WYMIANA",
                      )
                    ],
                  ),
                )
              ];
            },
            body: TabBarView(
              children: [
                //platne
                ServiceCardListPaid(),
                //wymiana
                ServiceCardListPaid(),
              ],
            ),
          ),
        ));
  }
}

class ServiceCardListPaid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: FutureBuilder(
          future: HomePage.getAllCards(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            int numberOfAds = 0;
            try{
              numberOfAds = HomePage.cardInfoData.length;
            }
            catch(Exception){
              print("Couldn't receive data");
            }
            if (numberOfAds == 0) {
              return Column(
                children: <Widget>[
                  Text(
                    "Brak ogłoszeń",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  SizedBox(height: 40),
                ],
              );
            }
            //sleep(const Duration(milliseconds: 100));
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text(
                    "Loading..",
                    style: new TextStyle(fontSize: 50),
                  ),
                ),
              );
            } else {
              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: numberOfAds,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 0.56, //TODO: zrobić to mądrzej
                ),
                itemBuilder: (BuildContext context, int index) {
                  return AdCardSmall(
                      false,
                      HomePage.cardInfoData[index].title,
                      HomePage.cardInfoData[index].description,
                      HomePage.cardInfoData[index].serviceCardId,
                      HomePage.cardInfoData[index].photo,
                  );
                },
              );
            }
          },
        ));
  }
}

