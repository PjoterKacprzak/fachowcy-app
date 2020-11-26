
import 'dart:io';
import 'dart:convert';
import 'package:fachowcy_app/Config/Config.dart';
import 'package:fachowcy_app/src/UserProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


class AddComment extends StatefulWidget {


   String email;
   String name;
   String lastName;

  AddComment(String email) {
    this.email = email;
    this.name = name;
    this.lastName = lastName;

  }

  @override
  _AddCommentState createState()
   {
     return _AddCommentState(this.email);
   }
}


class _AddCommentState extends State<AddComment> {

_AddCommentState(String email)
{
  _email = email;
}

  String _email;
  File _image;
  double _rating =3.0;
  TextEditingController commentController = new TextEditingController();

  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.blue,
      body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                GestureDetector(
                  onTap: () {
                    _showPicker(context);

                  },
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Color(0xffFDCF09),
                    child: _image != null
                        ? ClipRRect(
                      borderRadius:
                      BorderRadius.circular(50),
                      child: Image.file(
                        _image,
                        width: 100,
                        height: 100,
                        fit: BoxFit.fitHeight,
                      ),
                    )
                        : Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius:
                          BorderRadius.circular(
                              50)),
                      width: 100,
                      height: 100,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),

                ),
                TextFormField(
                  controller: commentController,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.comment,
                      color: Colors.white,
                    ),
                    labelText: 'Ocen użytkownika !',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 3.0,
                      ),
                    ),
                  ),
                ),
                 Padding(
                  padding: EdgeInsets.all(16.0),

                ),
                SmoothStarRating(
                  rating: _rating,
                  isReadOnly: false,
                  size: 50,
                  allowHalfRating: true,
                  color: Colors.orange,
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
                Padding(
                  padding: EdgeInsets.all(20.0),

                ),
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black)),
                  color: Colors.blueGrey,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  onPressed: () {
                    sendComment(_email, commentController.text, _image, _rating);
                  },
                  child: Text(
                    "Zatwierdź".toUpperCase(),
                    style: TextStyle(
                      fontSize:17.0,
                    ),
                  ),
                ),
              ],
            ),
          )

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




  Future<void>sendComment(String email,String comment,File file,double rating)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final ownerEmail  = prefs.getString('email');

    var newCommentJson ={};
    newCommentJson["rate"] = rating;
    newCommentJson["description"] = comment;
    String commentJson = json.encode(newCommentJson);
    print(commentJson);

    var UserXML = {};

    UserXML["email"] = email;
    String userEmail = json.encode(UserXML);

    print(userEmail);
    final http.Response response = await http.post(
      Config.serverHostString + "/api/comment/add?myEmail=" + ownerEmail +"&email="+email,
      headers: {'Content-Type': 'application/json'},
      body: commentJson,
    );
   //  int commentedUserId =int.parse(response.body);
   //  String commentingUserName;
   //  String commentingUserLastName;
   //  String commentingUserPhoto;
   //
   //
   //
   //
   //  UserXML["email"] = ownerEmail;
   //
   //  String ownerEmailJson = json.encode(UserXML);
   //  final http.Response response2 = await http.post(
   //    Config.serverHostString + '/api/users//getNameAndLastName',
   //    headers: {'Content-Type': 'application/json'},
   //    body: ownerEmailJson,
   //  );
   //  String stringToParse = response2.body;
   // List<String>nameAndLastName =  stringToParse.split("|");
   //
   // commentingUserName=nameAndLastName[0];
   // commentingUserLastName=nameAndLastName[1];
   // commentingUserPhoto=nameAndLastName[2];
   //


    //
    // final http.Response response3 = await http.post(
    //   Config.serverHostString + '/api/users/newUserComment',
    //   headers: {'Content-Type': 'application/json'},
    //   body: commentJson,
    // );


  }
}


