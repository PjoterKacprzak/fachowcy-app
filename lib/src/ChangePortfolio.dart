import 'dart:io';
import 'package:fachowcy_app/Config/Config.dart';
import 'package:fachowcy_app/Data/Photos.dart';
import 'package:fachowcy_app/src/UserProfile.dart';
import 'package:fachowcy_app/src/customWidgets/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:async/async.dart';

import 'dart:convert';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePortfolio extends StatefulWidget {

  @override
  _ChangePortfolioState createState() => _ChangePortfolioState();
}

class _ChangePortfolioState extends State<ChangePortfolio> {

  File _portfolio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Container(
          margin: MediaQuery.of(context).orientation == Orientation.portrait ?
          const EdgeInsets.only(left: 40, right: 40, top: 120) :
          const EdgeInsets.only(left: 40, right: 40, top: 10),
          child: Column(
            children: <Widget> [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 240.0, height: 240.0,
                  child: GestureDetector(
                    onTap: _getPortfolio,
                    child: Container(
                      color: Colors.black12,
                      child: _portfolio == null
                          ? Icon(Icons.add)
                          : Image.file(_portfolio),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              MediaQuery.of(context).orientation == Orientation.portrait ?
              Column(
                children: <Widget> [
                  Builder(
                    builder: (context) => Center(
                      child: FlatButton(
                        color: Colors.green,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(16.0),
                        splashColor: Colors.greenAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        onPressed: () async {


//                      await(createUrlFromPhoto(
//                          _image, _image2, _image3, _image4));

                          if ( _portfolio != null) {
                            _showToastGood(context, "Udało się załadować portfolio");
                          } else {
                            _showToastWrong(context, "Upss.. coś poszło nie tak!");
                          }
                        },
                        child: Text(
                          "Załaduj portfolio",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Builder(
                    builder: (context) => Center(
                      child: FlatButton(
                        color: Colors.green,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(16.0),
                        splashColor: Colors.greenAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => UserProfile()));
                        },
                        child: Text(
                          "Wróć",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ):
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Builder(
                    builder: (context) => Center(
                      child: FlatButton(
                        color: Colors.green,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(16.0),
                        splashColor: Colors.greenAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        onPressed: () async {

//                      await(createUrlFromPhoto(
//                          _image, _image2, _image3, _image4));

                          if ( _portfolio != null) {
                            _showToastGood(context, "Udało się zmienić zdjęcie profilowe");
                          } else {
                            _showToastWrong(context, "Upss.. coś poszło nie tak!");
                          }
                        },
                        child: Text(
                          "Załaduj portfolio",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Builder(
                    builder: (context) => Center(
                      child: FlatButton(
                        color: Colors.green,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(16.0),
                        splashColor: Colors.greenAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => UserProfile()));
                        },
                        child: Text(
                          "Wróć",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getPortfolio() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _portfolio = image;
      print("GET camera: $_portfolio");
    });
  }

  void _showToastGood(BuildContext context, String text) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: new Text(text,
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
            label: 'Zamknij', onPressed: scaffold.hideCurrentSnackBar, textColor: Colors.white),
      ),
    );

  }
}