import 'dart:io';
import 'package:fachowcy_app/Config/Config.dart';
import 'package:fachowcy_app/Data/Photos.dart';
import 'package:fachowcy_app/src/customWidgets/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:async/async.dart';

import 'dart:convert';

class PostNewAd extends StatefulWidget {
  // static var photoURL;
  @override
  _PostNewAdState createState() => _PostNewAdState();
}

class _PostNewAdState extends State<PostNewAd> {
  String _priceMin;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> _category = [
    'Wykończenia',
    'AGD',
    'Stolarka',
    'Elektryka',
    'Malowanie'
  ];
  List<String> _localization = [
    'Lodz',
    'Wraszawa',
    'Poznan',
    'Lodz-Centrum',
    'Zgierz'
  ];
  String _currentLocalization = "Lodz";
  String _currentCategory = 'Wykończenia';
  int _type = 1;
  String _title;
  String _description;
  String _estimatedTime;

  Widget DropdownCategories() {
    return DropdownButton<String>(
      style: TextStyle(color: Colors.white, fontSize: 20),
      dropdownColor: Colors.lightBlue,
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: Colors.white,
      ),
      isExpanded: true,
      items: _category.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String newValue) {
        setState(() {
          _currentCategory = newValue;
        });
        // print(_currentCategory);
      },
      value: _currentCategory,
    );
  }

  Widget DropdownLocalization() {
    return DropdownButton<String>(
      style: TextStyle(color: Colors.white, fontSize: 20),
      dropdownColor: Colors.lightBlue,
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: Colors.white,
      ),
      isExpanded: true,
      items: _localization.map((String valueLocalization) {
        return DropdownMenuItem<String>(
          value: valueLocalization,
          child: Text(valueLocalization),
        );
      }).toList(),
      onChanged: (String newLocalization) {
        setState(() {
          _currentLocalization = newLocalization;
        });
        // print(_currentLocalization);
      },
      value: _currentLocalization,
    );
  }

  File _image;
  File _image2;
  File _image3;
  File _image4;
  File _tempImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
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
                          Text('Dodaj ogłoszenie',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white)),
                          TextFormField(
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
                                borderRadius: BorderRadius.circular(25.0),
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
                                    onTap: () {
                                      _showPicker(context,_image);
                                      print("test wyśietlania");
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
                                ),
                                SizedBox(width: 10),
                                // Container(
                                //   width: 100.0,
                                //   child: GestureDetector(
                                //     onTap: () {
                                //       _showPicker(context, _image2);
                                //       setState(() {
                                //         _image2 = _tempImage;
                                //         _tempImage = null;
                                //       });
                                //     },
                                //     child: CircleAvatar(
                                //       radius: 55,
                                //       backgroundColor: Color(0xffFDCF09),
                                //       child: _image2 != null
                                //           ? ClipRRect(
                                //               borderRadius:
                                //                   BorderRadius.circular(50),
                                //               child: Image.file(
                                //                 _image2,
                                //                 width: 100,
                                //                 height: 100,
                                //                 fit: BoxFit.fitHeight,
                                //               ),
                                //             )
                                //           : Container(
                                //               decoration: BoxDecoration(
                                //                   color: Colors.grey[200],
                                //                   borderRadius:
                                //                       BorderRadius.circular(
                                //                           50)),
                                //               width: 100,
                                //               height: 100,
                                //               child: Icon(
                                //                 Icons.camera_alt,
                                //                 color: Colors.grey[800],
                                //               ),
                                //             ),
                                //     ),
                                //   ),
                                // ),
                                SizedBox(width: 10),
                                // Container(
                                //   width: 100.0,
                                //   child: GestureDetector(
                                //     onTap: () {
                                //       _showPicker(context, _image3);
                                //       // setState(() {
                                //       //   _image3 = _tempImage;
                                //       //   _tempImage = null;
                                //       // });
                                //     },
                                //     child: CircleAvatar(
                                //       radius: 55,
                                //       backgroundColor: Color(0xffFDCF09),
                                //       child: _image3 != null
                                //           ? ClipRRect(
                                //               borderRadius:
                                //                   BorderRadius.circular(50),
                                //               child: Image.file(
                                //                 _image3,
                                //                 width: 100,
                                //                 height: 100,
                                //                 fit: BoxFit.fitHeight,
                                //               ),
                                //             )
                                //           : Container(
                                //               decoration: BoxDecoration(
                                //                   color: Colors.grey[200],
                                //                   borderRadius:
                                //                       BorderRadius.circular(
                                //                           50)),
                                //               width: 100,
                                //               height: 100,
                                //               child: Icon(
                                //                 Icons.camera_alt,
                                //                 color: Colors.grey[800],
                                //               ),
                                //             ),
                                //     ),
                                //   ),
                                // ),
                                SizedBox(width: 10),
                                // Container(
                                //   width: 100.0,
                                //   child: GestureDetector(
                                //     onTap: () {
                                //       _showPicker(context, _image4);
                                //     },
                                //     child: CircleAvatar(
                                //       radius: 55,
                                //       backgroundColor: Color(0xffFDCF09),
                                //       child: _image4 != null
                                //           ? ClipRRect(
                                //               borderRadius:
                                //                   BorderRadius.circular(50),
                                //               child: Image.file(
                                //                 _image4,
                                //                 width: 100,
                                //                 height: 100,
                                //                 fit: BoxFit.fitHeight,
                                //               ),
                                //             )
                                //           : Container(
                                //               decoration: BoxDecoration(
                                //                   color: Colors.grey[200],
                                //                   borderRadius:
                                //                       BorderRadius.circular(
                                //                           50)),
                                //               width: 100,
                                //               height: 100,
                                //               child: Icon(
                                //                 Icons.camera_alt,
                                //                 color: Colors.grey[800],
                                //               ),
                                //             ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
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
                                        value: 0,
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
                                        value: 1,
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
                              child: (_type == 0)
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Flexible(
                                          child: TextFormField(
                                            onSaved: (String value) {
                                              _priceMin = value;
                                            },
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                            ),
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              labelText: 'Cena',
                                              labelStyle: TextStyle(
                                                color: Colors.white,
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 3.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Flexible(
                                        //   child: TextFormField(
                                        //     onSaved: (String value){
                                        //       _priceMax = value;
                                        //     },
                                        //     // ignore: missing_return
                                        //     validator: (String value){
                                        //       if(int.tryParse(_priceMax) < int.tryParse(_priceMin))
                                        //         return 'Cena od powinna być mniejsza niż do';
                                        //     },
                                        //     keyboardType: TextInputType.number,
                                        //     style: TextStyle(
                                        //       color: Colors.white,
                                        //       fontSize: 25,
                                        //     ),
                                        //     decoration: InputDecoration(
                                        //       labelText: 'Cena do',
                                        //       labelStyle: TextStyle(
                                        //         color: Colors.white,
                                        //       ),
                                        //       focusedBorder:
                                        //           UnderlineInputBorder(
                                        //         borderSide: BorderSide(
                                        //           color: Colors.white,
                                        //         ),
                                        //       ),
                                        //       enabledBorder:
                                        //           UnderlineInputBorder(
                                        //         borderRadius:
                                        //             BorderRadius.circular(25.0),
                                        //         borderSide: BorderSide(
                                        //           color: Colors.white,
                                        //           width: 3.0,
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    )
                                  : SizedBox(height: 10)),
                          SizedBox(height: 10),
                          TextFormField(
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
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 3.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
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
                              counterStyle: TextStyle(color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
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
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            onPressed: () {
                              if (!_formKey.currentState.validate()) {
                                return;
                              }
                              _formKey.currentState.save();
                              print(_title);
                              print(_currentCategory);
                              print(_type.toString());
                              print(_description);
                              print(_currentLocalization);
                              print(_estimatedTime);
                              createUrlFromPhoto(
                                  _image, _image2, _image3, _image4);

                              },
                            child: Text(
                              "Dodaj",
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

  _imgFromCamera(File filename) async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      filename = image;
      print("imgFromCamera: $filename");
    });

  }

  _imgFromGallery(File filename) async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      //TODO:wykasować
      filename = image;
    });
  }

  void _showPicker(context,File filename) {
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
                        _imgFromGallery(filename);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera(filename);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<String> createUrlFromPhoto(
      File file, File file2, File file3, File file4) async {
    print(file2);

    var UserXML = {};
    UserXML["photo1"] = '';
    UserXML["photo2"] = '';
    UserXML["photo3"] = '';
    UserXML["photo4"] = '';

    String base64Image1, base64Image2, base64Image3, base64Image4;
    if (file != null) {
      List<int> imageBytes = file.readAsBytesSync();
      base64Image1 = base64.encode(imageBytes);
      UserXML["photo1"] = base64Image1;
      print("TEST1");

      // encodedPhotos.add(base64Image1);
    }
    if (file2 != null) {
      List<int> imageBytes2 = file2.readAsBytesSync();
      base64Image2 = base64.encode(imageBytes2);
      UserXML["photo2"] = base64Image2;
      print("TEST2");
      //   encodedPhotos.add(base64Image2);
    }
    if (file3 != null) {
      List<int> imageBytes3 = file3.readAsBytesSync();
      base64Image3 = base64.encode(imageBytes3);
      UserXML["photo3"] = base64Image3;
      // encodedPhotos.add(base64Image3);
    }
    if (file4 != null) {
      List<int> imageBytes4 = file4.readAsBytesSync();
      base64Image4 = base64.encode(imageBytes4);
      UserXML["photo4"] = base64Image4;
      //encodedPhotos.add(base64Image4);
    }

    String str = json.encode(UserXML);
    print(str);

    final http.Response response = await http.post(
        Config.serverHostString + '/api/service-card/addPhotoToCloudinary',
        headers: {'Content-Type': 'application/json'},
        body: str

        // body: encodedPhotos
        );
    print(response.body);

    Map photosMap = jsonDecode(response.body);
    var photosURL = Photos.fromJson(photosMap);
    print(photosURL.photo1);

    craeteNewPost(_title,_currentCategory,photosURL.photo1,photosURL.photo2,photosURL.photo3,photosURL.photo4,_type.toString(),_description,_currentLocalization,_estimatedTime);

    return response.body;
  }

  Future<int> craeteNewPost (String title,String category,String photo,String photo2,String photo3,String photo4,String serviceType,String description,String location,String estimatedTime) async{
    var NewPostJson = {};
    NewPostJson["title"] = title;
    NewPostJson["category"] = category;
    NewPostJson["photo"] = photo;
    NewPostJson["serviceCardPhoto_2"] = photo2;
    NewPostJson["serviceCardPhoto_3"] = photo3;
    NewPostJson["serviceCardPhoto_4"] = photo4;
    NewPostJson["serviceType"] = serviceType;
    NewPostJson["description"] = description;
    NewPostJson["location"] = location;
    NewPostJson["estimatedTime"] = estimatedTime;
    String str = json.encode(NewPostJson);
    print(str);
    //TODO: Zrobienie POSTA na serwer ale o co chodzi z tym emialem
    // final http.Response responseSecond = await http.post(
    //     Config.serverHostString + '/api/service-card/addServiceCard',
    //     headers:{'Content-Type': 'application/json'},
    //     body: str
    // );
    // print(responseSecond.statusCode);
    // // CHECK THE REPOSONE NUMBERS
    // if ((responseSecond.statusCode >= 200)||(responseSecond.statusCode <=299)) {
    //   return responseSecond.statusCode;
    // } else if ((responseSecond.statusCode >= 400)||(responseSecond.statusCode <=499)) {
    //   return responseSecond.statusCode;
    // } else {
    //   throw Exception('Failed to create User.');
    // }
  }
}
