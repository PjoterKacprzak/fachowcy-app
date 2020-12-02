import 'dart:io';
import 'dart:convert';
import 'package:fachowcy_app/Config/Config.dart';
import 'package:fachowcy_app/src/HomePage.dart';
import 'package:fachowcy_app/src/UserProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'ProfileFromAd.dart';
import 'ProfileFromComment.dart';
import 'UserMainPage.dart';

class AddComment extends StatefulWidget {
  String email;
  String name;
  String lastName;
  int id;

  AddComment(String email, int id) {
    this.email = email;
    this.name = name;
    this.lastName = lastName;
    this.id = id;
  }

  @override
  _AddCommentState createState() {
    return _AddCommentState(this.email, this.id);
  }
}

class _AddCommentState extends State<AddComment> {
  _AddCommentState(String email, int id) {
    _email = email;
    _id = id;
  }

  String _email;
  int _id;
  File _image;
  double _rating = 3.0;
  static int responseCode;
  TextEditingController commentController = new TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor(Config.mainColor),
        body: Container(
          margin: MediaQuery.of(context).orientation == Orientation.portrait
              ? const EdgeInsets.only(left: 40, right: 40)
              : const EdgeInsets.only(left: 40, right: 40),
          child: Center(
            child: MediaQuery.of(context).orientation == Orientation.portrait
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 32),
                      TextFormField(
                        controller: commentController,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.comment,
                            color: Colors.white,
                          ),
                          labelText: 'Oceń użytkownika!',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(24.0),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 3.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      SmoothStarRating(
                        rating: _rating,
                        isReadOnly: false,
                        size: 40,
                        allowHalfRating: true,
                        color: Colors.white,
                        borderColor: Colors.white,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,
                        starCount: 5,
                        spacing: 0.5,
                        onRated: (value) {
                          _rating = value;
                          // print("rating value -> $_rating");
                        },
                      ),
                      SizedBox(height: 32),
                      Builder(
                        builder: (context) => Center(
                          child: FlatButton(
                            color: HexColor(Config.buttonColor),
                            textColor: Colors.white,
                            padding: EdgeInsets.all(16.0),
                            splashColor: Colors.greenAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            onPressed: () async {
                              await sendComment(_email, commentController.text,
                                  _image, _rating);
                              print(responseCode);
                              if (responseCode == 200) {
                                Future.delayed(const Duration(seconds: 2), () => "2");
                                _showToastGood(context, "Dodano komentarz!");
                              } else {
                                _showToastWrong(
                                    context, "Ups.. coś poszło nie tak.");
                              }
                            },
                            child: Text(
                              "Skomentuj",
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      FlatButton(
                        color: HexColor(Config.buttonColor),
                        textColor: Colors.white,
                        padding: EdgeInsets.all(16.0),
                        splashColor: Colors.greenAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => UserMainPage()));
                        },
                        child: Text(
                          "Wróć",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ],
                  )
                : SingleChildScrollView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TextFormField(
                                controller: commentController,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.comment,
                                    color: Colors.white,
                                  ),
                                  labelText: 'Oceń użytkownika!',
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 3.0,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              SmoothStarRating(
                                rating: _rating,
                                isReadOnly: false,
                                size: 40,
                                allowHalfRating: true,
                                color: Colors.white,
                                borderColor: Colors.white,
                                filledIconData: Icons.star,
                                halfFilledIconData: Icons.star_half,
                                defaultIconData: Icons.star_border,
                                starCount: 5,
                                spacing: 0.5,
                                onRated: (value) {
                                  _rating = value;
                                  // print("rating value -> $_rating");
                                },
                              ),
                              SizedBox(height: 16),
                              Builder(
                                builder: (context) => Center(
                                  child: FlatButton(
                                    color: HexColor(Config.buttonColor),
                                    textColor: Colors.white,
                                    padding: EdgeInsets.all(16.0),
                                    splashColor: Colors.greenAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    onPressed: () async {
                                      await sendComment(
                                          _email,
                                          commentController.text,
                                          _image,
                                          _rating);
                                      print(responseCode);
                                      if (responseCode == 200) {
                                        _showToastGood(
                                            context, "Dodano komentarz!");
                                      } else {
                                        _showToastWrong(context,
                                            "Ups.. coś poszło nie tak.");
                                      }
                                    },
                                    child: Text(
                                      "Skomentuj",
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              FlatButton(
                                color: HexColor(Config.buttonColor),
                                textColor: Colors.white,
                                padding: EdgeInsets.all(16.0),
                                splashColor: Colors.greenAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => UserMainPage()));
                                },
                                child: Text(
                                  "Wróć",
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 32),
                        Expanded(
                          flex: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: 160.0,
                              height: 160.0,
                              child: GestureDetector(
                                onTap: () {
                                  _showPicker(context);
                                },
                                child: Container(
                                  color: Colors.black12,
                                  child: _image == null
                                      ? Icon(Icons.add)
                                      : Image.file(_image),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ));
  }

  void _showToastGood(BuildContext context, String text) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: HexColor(Config.buttonColor),
        content: new Text(text, style: const TextStyle(fontSize: 20)),
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
        backgroundColor: Colors.redAccent,
        content: new Text(message, style: const TextStyle(fontSize: 16)),
        action: SnackBarAction(
            label: 'Zamknij',
            onPressed: scaffold.hideCurrentSnackBar,
            textColor: Colors.white),
      ),
    );
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      //TODO:wykasować
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> sendComment(
      String email, String comment, File file, double rating) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final ownerEmail = prefs.getString('email');

    var newCommentJson = {};
    newCommentJson["rate"] = rating;
    newCommentJson["description"] = comment;
    String commentJson = json.encode(newCommentJson);
    print(commentJson);

    var UserXML = {};

    UserXML["email"] = email;
    String userEmail = json.encode(UserXML);

    print(userEmail);
    final http.Response response = await http.post(
      Config.serverHostString +
          "/api/comment/add?myEmail=" +
          ownerEmail +
          "&email=" +
          email,
      headers: {'Content-Type': 'application/json'},
      body: commentJson,
    );

    print(response.statusCode);
    responseCode = response.statusCode;
  }
}
