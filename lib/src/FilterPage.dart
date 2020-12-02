import 'dart:convert';

import 'package:fachowcy_app/Config/Config.dart';
import 'package:fachowcy_app/Data/ServiceCard.dart';
import 'package:fachowcy_app/Data/User.dart';
import 'package:fachowcy_app/src/FilteredAds.dart';
import 'package:fachowcy_app/src/LoginPage.dart';
import 'package:fachowcy_app/src/customWidgets/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'UserProfile.dart';

class FilterPage extends StatefulWidget {
  FilterPage({Key key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  bool isLoading = false;
  static List<ServiceCard> cardInfoData;
  String _priceMin = '0';
  String _priceMax;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> _category = [
    'Wybierz',
    'Malowanie',
    'Remont',
    'Elektryka',
    'Meble i zabudowa',
    'Ogrod',
    'Hydraulika',
  ];
  List<String> _localization = [
    'Wybierz',
    'Lodz',
    'Warszawa',
    'Wroclaw',
  ];
  String _currentLocalization = "Wybierz";
  String _currentCategory = 'Wybierz';
  double _rating = 3.0;
  int _type = 1;

  Widget DropdownCategories() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: PopupMenuButton(
        child: Container(
          // padding: EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              Expanded(
                flex: 9, child: Text('$_currentCategory',style: TextStyle(color: Colors.white, fontSize: 20),),
              ),
              Expanded(
                  flex: 1, child: Icon(Icons.keyboard_arrow_down,color: Colors.white,)
              ),
              // Align(alignment: Alignment.centerRight,child: ,)
            ],
          ),
        ),
        onSelected: (value) => setState(() => _currentCategory = value),
        color: HexColor('#40bb45'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        itemBuilder: (context) {
          return _category
              .map((value) => PopupMenuItem(
              value: value,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text('$value',style: TextStyle(color: Colors.white, fontSize: 16)),
              )))
              .toList();
        },
      ));
  }

  Widget DropdownLocalization() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: PopupMenuButton(
        child: Container(
          child: Row(
            children: [
              Expanded(
                flex: 9, child: Text('$_currentLocalization',style: TextStyle(color: Colors.white, fontSize: 20),),
              ),
              Expanded(
                flex: 1, child: Icon(Icons.keyboard_arrow_down,color: Colors.white,)
              ),
              // Align(alignment: Alignment.centerRight,child: ,)
            ],
          ),
        ),
        onSelected: (value) => setState(() => _currentLocalization = value),
        color: HexColor('#40bb45'),
        padding: EdgeInsets.only(top: 4.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        itemBuilder: (context) {
          return _localization
              .map((value) => PopupMenuItem(
              value: value,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text('$value',style: TextStyle(color: Colors.white, fontSize: 16)),
              )))
              .toList();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#2162f3'),
      body: CustomScrollView(
        slivers: <Widget>[
          CustomAppBar(),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1, // 20%
                      child: Container(),
                    ),
                    Expanded(
                      flex: 8, // 60%
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('Filtruj',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white)),
                          SizedBox(height: 25),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Kategoria',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white),
                                )
                              ]),

                          SizedBox(height: 5),
                          DropdownCategories(),
                          SizedBox(height: 25),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Lokalizacja',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white),
                                )
                              ]),
                          SizedBox(height: 5),
                          DropdownLocalization(),
                          SizedBox(height: 20),
                          Theme(
                            data:
                                ThemeData(unselectedWidgetColor: Colors.white),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Radio(
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        activeColor: Colors.white,
                                        value: 1,
                                        groupValue: _type,
                                        onChanged: (value) {
                                          // print(value);
                                          setState(() {
                                            _type = value;
                                          });
                                        },
                                      ),
                                      Text("Płatne",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25)),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Radio(
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        activeColor: Colors.white,
                                        value: 0,
                                        groupValue: _type,
                                        onChanged: (value) {
                                          // print(value);
                                          setState(() {
                                            _type = value;
                                          });
                                        },
                                      ),
                                      Text("Wymiana",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25)),
                                    ],
                                  ),
                                ]),
                          ),

                          SmoothStarRating(
                            rating: _rating,
                            isReadOnly: false,
                            size: 50,
                            allowHalfRating: true,
                            color: Colors.white,
                            borderColor: Colors.white,
                            filledIconData: Icons.star,
                            halfFilledIconData: Icons.star_half,
                            defaultIconData: Icons.star_border,
                            starCount: 5,
                            spacing: 2.0,
                            onRated: (value) {
                              _rating = value;
                              // print("rating value -> $_rating");
                            },
                          ),
                          SizedBox(height: 40),
                          FlatButton(
                            color: HexColor(Config.buttonColor),
                            textColor: Colors.white,
                            padding: EdgeInsets.all(16.0),
                            splashColor: Colors.greenAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            onPressed: () async {
                              if (!_formKey.currentState.validate()) {
                                return;
                              }
                              setState(() => isLoading = true);
                              print(_priceMin.isEmpty);
                              _formKey.currentState.save();
                              await searchForCards(
                                  _currentCategory,
                                  _currentLocalization,
                                  _type.toString(),
                                  _priceMin,
                                  _rating.toString());
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FilteredAds(cardInfoData)));
                            },
                            child: Text(
                              "Szukaj",
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1, // 20%
                      child: Container(),
                    )
                  ],
                ),
              ),
            )
          ]))
        ],
      ),
    );
  }

  Future<int> searchForCards(String category, String localization, String type,
      String priceMin, String rating) async {
    ServiceCard serviceCard = new ServiceCard();
    // var FilterJson = {};
    // FilterJson["category"] = category;
    // FilterJson["localization"] = localization;
    // FilterJson["type"] = type;
    // FilterJson["priceMin"] = priceMin;
    // FilterJson["rating"] = rating;
    // String str = json.encode(FilterJson);
    String _category;
    if (category == 'Wybierz')
      _category = 'null';
    else
      _category = category;

    String _localization;
    if (localization == 'Wybierz')
      _localization = 'null';
    else
      _localization = localization;

    print(Config.serverHostString +
        'api/service-card/filterCard?category=' +
        _category +
        '&location=' +
        _localization +
        '&service_type=' +
        _type.toString());
    print(Config.serverHostString +
        'api/service-card/filterCard?category=' +
        _category +
        '&location=' +
        _localization);
    // http://localhost:8080/api/service-card/filterCard?category=null&location=Wroclaw&price=12
    final http.Response response = await http.get(
      // Config.serverHostString + 'api/service-card/filterCard?category='+_category+'&location='+_localization,
      Config.serverHostString +
          'api/service-card/filterCard?category=' +
          _category +
          '&location=' +
          _localization +
          '&service_type=' +
          _type.toString(),
      headers: {'Content-Type': 'application/json'},
    );

    if ((response.statusCode >= 200) && (response.statusCode <= 299)) {
      cardInfoData = serviceCard.parseServiceCard(response.body);
      print("CardData received");
      print(cardInfoData);
      return response.statusCode;
    } else {
      throw Exception('Failed to find Card.');
    }
    //TODO: Dorobienie widoku Filtrowaynch wyników oraz to co w komentarzu zmienić na docelowy endpoint
    // final http.Response response = await http.post(
    //     Config.serverHostString + '/api/users/addUser',
    //     headers:{'Content-Type': 'application/json'},
    //     body: str
    // );
    // print(response.statusCode);
    // // CHECK THE REPOSONE NUMBERS
    // if ((response.statusCode >= 200)||(response.statusCode <=299)) {
    //   return response.statusCode;
    // } else if ((response.statusCode >= 400)||(response.statusCode <=499)) {
    //   return response.statusCode;
    // } else {
    //   throw Exception('Failed to create User.');
    // }
  }
}
