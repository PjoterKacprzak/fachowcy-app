import 'dart:io';
import 'package:fachowcy_app/Config/Config.dart';
import 'package:fachowcy_app/Data/Photos.dart';
import 'package:fachowcy_app/src/UserProfile.dart';
import 'package:fachowcy_app/src/customWidgets/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:async/async.dart';

import 'dart:convert';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeUserProfilePhoto extends StatefulWidget {
  @override
  _ChangeUserProfilePhotoState createState() => _ChangeUserProfilePhotoState();
}

class _ChangeUserProfilePhotoState extends State<ChangeUserProfilePhoto> {
  File _image;
  static var photoUrl;
  static int status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(Config.mainColor),
      body: SafeArea(
        child: Container(
          margin: MediaQuery.of(context).orientation == Orientation.portrait
              ? const EdgeInsets.only(left: 40, right: 40, top: 120)
              : const EdgeInsets.only(left: 40, right: 40, top: 10),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 240.0,
                  height: 240.0,
                  child: GestureDetector(
                    onTap: _getImage,
                    child: Container(
                      color: Colors.black12,
                      child:
                          _image == null ? Icon(Icons.add) : Image.file(_image),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? Column(
                      children: <Widget>[
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
                                await (createUrlFromPhoto(_image));
                                await (changeUserProfilePhoto(photoUrl.photo1));

                                if (status == 200) {
                                  _showToastGood(context,
                                      "Udało się zmienić zdjęcie profilowe");
                                } else {
                                  _showToastWrong(
                                      context, "Upss.. coś poszło nie tak!");
                                }
                              },
                              child: Text(
                                "Zmień zdjęcie profilowe",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
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
                                var result =
                                    await UserProfile.getDataFromJson();
                                if (result == 200)
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UserProfile()));
                              },
                              child: Text(
                                "Wróć",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
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
                                await (createUrlFromPhoto(_image));
                                await (changeUserProfilePhoto(photoUrl.photo1));

                                if (status == 200) {
                                  _showToastGood(context,
                                      "Udało się zmienić zdjęcie profilowe");
                                } else {
                                  _showToastWrong(
                                      context, "Upss.. coś poszło nie tak!");
                                }
                              },
                              child: Text(
                                "Zmień zdjęcie profilowe",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
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
                                var result =
                                    await UserProfile.getDataFromJson();
                                if (result == 200)
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UserProfile()));
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

  Future<void> changeUserProfilePhoto(String photo) async {
    var newPostJson = {};

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');

    newPostJson["email"] = email;
    newPostJson["profilePhoto"] = photo;
    String profilePhoto = json.encode(newPostJson);

    final http.Response response = await http.post(
        Config.serverHostString + '/api/users/updateProfilePhoto',
        headers: {'Content-Type': 'application/json'},
        body: profilePhoto);

    print("Kod z change photo: " + response.statusCode.toString());
    status = response.statusCode;
  }

  Future<String> createUrlFromPhoto(File file) async {
    var UserXML = {};
    UserXML["photo1"] = '';
    UserXML["photo2"] = '';
    UserXML["photo3"] = '';
    UserXML["photo4"] = '';

    String base64Image1;

    if (file != null) {
      List<int> imageBytes = file.readAsBytesSync();
      base64Image1 = base64.encode(imageBytes);
      UserXML["photo1"] = base64Image1;
    }

    String photo = json.encode(UserXML);

    final http.Response response = await http.post(
        Config.serverHostString + '/api/service-card/addPhotoToCloudinary',
        headers: {'Content-Type': 'application/json'},
        body: photo);

    print(response.body);

    Map photosMap = jsonDecode(response.body);
    photoUrl = Photos.fromJson(photosMap);
    return response.body;
  }

  Future<void> _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      print("GET camera: $_image");
    });
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
}
