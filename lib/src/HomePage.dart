import 'dart:convert';
import 'package:fachowcy_app/Config/Config.dart';
import 'package:fachowcy_app/Data/ServiceCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'UserMainPage.dart';
import 'UserProfile.dart';
import 'customWidgets/AdCardSmall.dart';
import 'customWidgets/Loader.dart';
import 'package:hexcolor/hexcolor.dart';

class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: HexColor(Config.backgroundColor),
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: HexColor('#2162f3'),
                  //HexColor('#de9d0c')
                  floating: false,
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
                    indicatorColor: HexColor('#40bb45'),
                    labelColor: HexColor('#40bb45'),
                    unselectedLabelColor: Colors.white,
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 4.0,color: HexColor('#40bb45')),
                    ),

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
                ServiceCardListExchange(),
              ],
            ),
          ),
        ));
  }
}

class ServiceCardListPaid extends StatelessWidget {
  static var cardInfoData;

  static Future<int> getAllCardsPaid() async {
    ServiceCard serviceCard = new ServiceCard();

    final http.Response response = await http.get(
      Config.serverHostString + 'api/service-card/filterCardByServiceType?service_type=1',
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
    return Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: FutureBuilder(
          future: getAllCardsPaid(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            int numberOfAds = 0;
            try {
              numberOfAds = cardInfoData.length;
            } catch (Exception) {
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
              return Loader();
            } else {
              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: numberOfAds,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 2
                          : 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 0.58
                          : 0.76, //TODO: zrobić to mądrzej
                ),
                itemBuilder: (BuildContext context, int index) {
                  return AdCardSmall(
                    false,
                    cardInfoData[index].title,
                    cardInfoData[index].description,
                    cardInfoData[index].serviceCardId,
                    cardInfoData[index].photo,
                  );
                },
              );
            }
          },
        ));
  }
}

class ServiceCardListExchange extends StatelessWidget {
  static var cardInfoData;


  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: FutureBuilder(
          future: getAllCardsExchange(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            int numberOfAds = 0;
            try {
              numberOfAds = cardInfoData.length;
            } catch (Exception) {
              print("Couldn't receive data");
            }
            if (numberOfAds == 0) {
              return Column(
                children: <Widget>[
                  SizedBox(height: 40),
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
              return Loader();
            } else {
              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: numberOfAds,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? 2
                      : 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? 0.58
                      : 0.76, //TODO: zrobić to mądrzej
                ),
                itemBuilder: (BuildContext context, int index) {
                  return AdCardSmall(
                    false,
                    cardInfoData[index].title,
                    cardInfoData[index].description,
                    cardInfoData[index].serviceCardId,
                    cardInfoData[index].photo,
                  );
                },
              );
            }
          },
        ));
  }
  static Future<int> getAllCardsExchange() async {
    ServiceCard serviceCard = new ServiceCard();

    final http.Response response = await http.get(
      Config.serverHostString + 'api/service-card/filterCardByServiceType?service_type=0',
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
}