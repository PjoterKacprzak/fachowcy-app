import 'package:fachowcy_app/Config/Config.dart';
import 'package:fachowcy_app/Data/ServiceCard.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'customWidgets/AdCardSmall.dart';
import 'customWidgets/CustomAppBar.dart';
import 'customWidgets/Loader.dart';

class FavoriteAds extends StatelessWidget {

  static var cardInfoData;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: HexColor(Config.backgroundColor),
      body: CustomScrollView(
        slivers: <Widget>[
          CustomAppBar(),
          SliverList(
              delegate: SliverChildListDelegate([
              Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: FutureBuilder(
                future: getFavoriteCards(),
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
                          "Brak ulubionych ogłoszeń",
                          style: TextStyle(color: HexColor(Config.mainColor), fontSize: 24),
                        ),
                        SizedBox(height: 40),
                      ],
                    );
                  }
                  //sleep(const Duration(milliseconds: 100));
                  if (snapshot.data == null) {
                    return Container(
                      height: 500,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircularProgressIndicator(
                                  valueColor:
                                  new AlwaysStoppedAnimation<Color>(Colors.white)),
                              SizedBox(height: 8),
                              Text(
                                "Fachowcy",
                                style: new TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                        )
                    );
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
              ))
              ]))
        ],
      ),
    );
  }

  static Future<int> getFavoriteCards() async {
    ServiceCard serviceCard = new ServiceCard();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    print(Config.serverHostString +
        'api/favorite-service/findByEmail?email='+email);
    final http.Response response = await http.get(
      Config.serverHostString +
          'api/favorite-service/findByEmail?email='+email,
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