import 'dart:io';
import 'package:fachowcy_app/Config/Config.dart';
import 'package:fachowcy_app/Data/Photos.dart';
import 'package:fachowcy_app/Data/ServiceCard.dart';
import 'package:fachowcy_app/src/HomePage.dart';
import 'package:fachowcy_app/src/UserProfile.dart';
import 'package:fachowcy_app/src/customWidgets/CustomAppBar.dart';
import 'package:fachowcy_app/src/customWidgets/Loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'UserMainPage.dart';

class EditServiceCard extends StatefulWidget {
  int serviceCardId;

  EditServiceCard(int serviceCardId) {
    this.serviceCardId = serviceCardId;
  }

  // static var photoURL;
  @override
  _EditServiceCardState createState() {
    return _EditServiceCardState(this.serviceCardId);
  }
}

class _EditServiceCardState extends State<EditServiceCard> {
  @override
  void initState() {
    _tempServiceCard = _asyncGetData();

    super.initState();

    print("Data  $_tempServiceCard");
  }

  Future<ServiceCard> _asyncGetData() async {
    return getServiceCardFromId(_serviceCardId);
  }

  Future<ServiceCard> _tempServiceCard;
  int _serviceCardId;
  String _price;
  String _exchangeDescription;
  bool isLoading = false;
  _EditServiceCardState(int serviceCardId) {
    this._serviceCardId = serviceCardId;
  }

  static var PHOTO_URL;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> _category = [
    'Malowanie',
    'Remont',
    'Elektryka',
    'Meble i zabudowa',
    'Ogrod',
    'Hydraulika',
    'Elektryka',
    'Hydraulika',
  ];
  List<String> _localization = [
    'Lodz',
    'Warszawa',
    'Wroclaw',
  ];
  String _currentLocalization = 'Wybierz';
  String _currentCategory = 'Wybierz';
  int _type = 0;
  String _title;
  String _description;
  String _estimatedTime;
  File _image;
  File _image2;
  File _image3;
  File _image4;

  Widget build(BuildContext context) {
    return FutureBuilder<ServiceCard>(
        future: _tempServiceCard, // function where you call your api
        builder: (BuildContext context, AsyncSnapshot<ServiceCard> snapshot) {
          // AsyncSnapshot<Your object type>
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loader();
          } else {
            if (snapshot.hasError)
              return Center(child: Text('Error: ${snapshot.error}'));
            else
              return Scaffold(
                backgroundColor: HexColor(Config.mainColor),
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
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('Edytuj ogłoszenie',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 30, color: Colors.white)),
                                    TextFormField(
                                      initialValue: snapshot.data.title,
                                      validator: (String value) {
                                        if (value.isEmpty)
                                          return 'Podaj tytuł ogłoszenia';
                                      },
                                      onSaved: (String value) {
                                        _title = value;
                                      },
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                      ),
                                      decoration: InputDecoration(
                                        labelText: 'Tytuł',
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                            width: 3.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                        height: 160,
                                        child: ListView(
                                            // This next line does the trick.
                                            scrollDirection: Axis.horizontal,
                                            children: <Widget>[
                                              Container(
                                                  width: 100.0,
                                                  child: GestureDetector(
                                                    onTap: _getImage1,
                                                    child: Container(
                                                      color: Colors.black12,
                                                      child: _image == null
                                                          ? Icon(Icons.add)
                                                          : Image.file(_image),
                                                    ),
                                                  )),
                                              SizedBox(width: 10),
                                              if(_image == null)
                                                SizedBox(width: 0)
                                              else
                                                Container(
                                                    width: 100.0,
                                                    child: GestureDetector(
                                                      onTap: _getImage2,
                                                      child: Container(
                                                        color: Colors.black12,
                                                        child: _image2 == null
                                                            ? Icon(Icons.add_a_photo)
                                                            : Image.file(_image2),
                                                      ),
                                                    )),
                                              SizedBox(width: 10),
                                              if(_image2 == null)
                                                SizedBox(width: 0)
                                              else
                                                Container(
                                                    width: 100.0,
                                                    child: GestureDetector(
                                                      onTap: _getImage3,
                                                      child: Container(
                                                        color: Colors.black12,
                                                        child: _image3 == null
                                                            ? Icon(Icons.add_a_photo)
                                                            : Image.file(_image3),
                                                      ),
                                                    )),
                                              SizedBox(width: 10),
                                              if(_image3 == null)
                                                SizedBox(width: 0)
                                              else
                                                Container(
                                                    width: 100.0,
                                                    child: GestureDetector(
                                                      onTap: _getImage4,
                                                      child: Container(
                                                        color: Colors.black12,
                                                        child: _image4 == null
                                                            ? Icon(Icons.add_a_photo)
                                                            : Image.file(_image4),
                                                      ),
                                                    )),
                                            ])),
                                    SizedBox(height: 10),
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Kategoria',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 25,
                                                color: Colors.white),
                                          )
                                        ]),
                                    DropdownCategories(),
                                    SizedBox(height: 25),
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Lokalizacja',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 25,
                                                color: Colors.white),
                                          )
                                        ]),
                                    DropdownLocalization(),
                                    SizedBox(height: 20),
                                    Theme(
                                      data: ThemeData(
                                          unselectedWidgetColor: Colors.white),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Radio(
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
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
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
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
                                    Container(
                                        child: _type == 1
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: TextFormField(
                                                      onSaved: (String value) {
                                                        _price = value;
                                                      },
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 25,
                                                      ),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Cena',
                                                        labelStyle: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      25.0),
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.white,
                                                            width: 3.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: TextFormField(
                                                      onSaved: (String value) {
                                                        _exchangeDescription =
                                                            value;
                                                      },
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 25,
                                                      ),
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            'Opis wymiany',
                                                        labelStyle: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      25.0),
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.white,
                                                            width: 3.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                    SizedBox(height: 10),
                                    TextFormField(
                                      initialValue: snapshot.data.estimatedTime,
                                      validator: (String value) {
                                        if (value.isEmpty)
                                          return 'Podaj oczekiwany termin wykonania';
                                      },
                                      onSaved: (String value) {
                                        _estimatedTime = value;
                                      },
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                      ),
                                      decoration: InputDecoration(
                                        labelText: 'Termin',
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                            width: 3.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    TextFormField(
                                      initialValue: snapshot.data.description,
                                      validator: (String value) {
                                        if (value.isEmpty)
                                          return 'Podaj opis ogłoszenia';
                                      },
                                      onSaved: (String value) {
                                        _description = value;
                                      },
                                      maxLength: 255,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                      ),
                                      decoration: InputDecoration(
                                        labelText: 'Opis',
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                        counterStyle:
                                            TextStyle(color: Colors.white),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                      maxLines: 6,
                                    ),
                                    SizedBox(height: 20),
                                    FlatButton(
                                      color: Colors.green,
                                      textColor: Colors.white,
                                      padding: EdgeInsets.all(16.0),
                                      splashColor: Colors.greenAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      onPressed: () async {
                                        if (!_formKey.currentState.validate()) {
                                          return;
                                        }
                                        setState(() => isLoading = true);
                                        _formKey.currentState.save();

                                        if (await (updatePost(
                                                _serviceCardId,
                                                _title,
                                                _currentCategory,
                                                _image,
                                                _image2,
                                                _image3,
                                                _image4,
                                                _type,
                                                _description,
                                                _currentLocalization,
                                                _estimatedTime,
                                                _price,
                                                _exchangeDescription)) ==
                                            200) {
                                          setState(() => isLoading = false);
                                          //_showToastGood(context);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage()));
                                        } else {
                                          setState(() => isLoading = false);
                                          // _showToastWrong(context,
                                          //  'Nie udało się dodać ogłoszenia!');
                                        }
                                        ;
                                      },
                                      child: Text(
                                        "Edytuj",
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
          } // snapshot.data  :- get your object which is pass from your downloadData() function
        });
  }

  Future<int> updatePost(
      int id,
      String title,
      String category,
      File photo,
      File photo2,
      File photo3,
      File photo4,
      int serviceType,
      String description,
      String location,
      String estimatedTime,
      String price,
      String exchangeDescription) async {
    print("PhotoFile $photo");
    var newPostJson = {};
    String base64Image1, base64Image2, base64Image3, base64Image4;
    newPostJson["serviceCardId"] = id;
    newPostJson["title"] = title;
    newPostJson["category"] = category;
    newPostJson["serviceType"] = serviceType;
    newPostJson["description"] = description;
    newPostJson["location"] = location;
    newPostJson["estimatedTime"] = estimatedTime;
    newPostJson["price"] = price;
    newPostJson["exchangeDescription"] = exchangeDescription;
    if (photo != null) {
      List<int> imageBytes = photo.readAsBytesSync();
      base64Image1 = base64.encode(imageBytes);
      newPostJson["photo"] = base64Image1;
      print("testing");
    }
    if (photo2 != null) {
      List<int> imageBytes2 = photo2.readAsBytesSync();
      base64Image2 = base64.encode(imageBytes2);
      newPostJson["serviceCardPhoto_2"] = base64Image2;
    }
    if (photo3 != null) {
      List<int> imageBytes3 = photo3.readAsBytesSync();
      base64Image3 = base64.encode(imageBytes3);
      newPostJson["serviceCardPhoto_3"] = base64Image3;
    }
    if (photo4 != null) {
      List<int> imageBytes4 = photo4.readAsBytesSync();
      base64Image4 = base64.encode(imageBytes4);
      newPostJson["serviceCardPhoto_4"] = base64Image4;
    }

    if (serviceType == 1) {
      newPostJson["exchangeDescription"] = null;
    } else {
      newPostJson["price"] = null;
    }

    String str = json.encode(newPostJson);
    print("Test $str");

    final http.Response responseSecond = await http.post(
        Config.serverHostString + '/api/service-card/updateCard',
        headers: {'Content-Type': 'application/json'},
        body: str);
    print(responseSecond.statusCode);
    // CHECK THE REPOSONE NUMBERS
    return responseSecond.statusCode;
  }

  void _showToastGood(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: const Text('Dodano ogłoszenie!',
            style: const TextStyle(fontSize: 20)),
        action: SnackBarAction(
            label: 'Zamknij',
            onPressed: scaffold.hideCurrentSnackBar,
            textColor: Colors.white),
      ),
    );
  }

  void _showToastWrong(BuildContext context, String message) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: new Text(message, style: const TextStyle(fontSize: 16)),
        action: SnackBarAction(
            label: 'Zamknij',
            onPressed: scaffold.hideCurrentSnackBar,
            textColor: Colors.white),
      ),
    );
  }

  Future<ServiceCard> getServiceCardFromId(int serviceCardId) async {
    var newPostJson = {};
    newPostJson["serviceCardId"] = serviceCardId;

    String str = json.encode(newPostJson);
    print(str);

    final http.Response responseSecond = await http.post(
        Config.serverHostString + '/api/service-card/getServiceCardById',
        headers: {'Content-Type': 'application/json'},
        body: str);
    return ServiceCard.fromJson(jsonDecode(responseSecond.body));
  }

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
          color:HexColor('#40bb45'),
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

  Future<void> _getImage1() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
      print("GET camera: $_image");
    });
  }

  Future<void> _getImage2() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image2 = image;
      print("GET camera: $_image2");
    });
  }

  Future<void> _getImage3() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image3 = image;
      print("GET camera: $_image3");
    });
  }

  Future<void> _getImage4() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image4 = image;
      print("GET camera: $_image4");
    });
  }
}
