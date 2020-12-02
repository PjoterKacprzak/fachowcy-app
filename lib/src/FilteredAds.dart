import 'package:fachowcy_app/Config/Config.dart';
import 'package:fachowcy_app/Data/ServiceCard.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'customWidgets/AdCardSmall.dart';
import 'customWidgets/CustomAppBar.dart';

class FilteredAds extends StatelessWidget {
  List<ServiceCard> listOfCards;
  int numberOfCards;
  FilteredAds(List<ServiceCard> list) {
    this.listOfCards = new List();
    this.listOfCards = list;
    // this.numberOfCards = number;
  }

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
              child: listOfCards.length == 0
                  ? Container(
                      child: Center(
                          child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 20),
                        Text(
                          "Brak ogłoszeń",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        )
                      ],
                    )))
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: listOfCards.length,
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 2
                            : 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 0.58
                            : 0.76, //TODO: zrobić to mądrzej
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return AdCardSmall(
                          false,
                          listOfCards[index].title,
                          listOfCards[index].description,
                          listOfCards[index].serviceCardId,
                          listOfCards[index].photo,
                        );
                      },
                    ),
            )
          ]))
        ],
      ),
    );
  }
}
