
import 'dart:io';
import 'package:fachowcy_app/Config/Config.dart';
import 'package:fachowcy_app/src/customWidgets/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:async/async.dart';

import 'dart:convert';
class PostNewAd extends StatefulWidget {
  @override
  _PostNewAdState createState() => _PostNewAdState();
}

class _PostNewAdState extends State<PostNewAd> {
  File _image;
  File _image2;
  File _image3;
  File _image4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: CustomScrollView(
        slivers: <Widget>[
          CustomAppBar(),
          SliverList(delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.all(24),
                  child: Form(
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
                            children: <Widget> [
                              Text(
                                  'Dodaj ogłoszenie',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 30, color: Colors.white)
                              ),
                              TextFormField(
                                //: nameController,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                                decoration: InputDecoration(
                                  labelText: '    Tytuł',
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
                              // ClipRRect(
                              //   borderRadius: BorderRadius.circular(40.0),
                              //   child: Container(
                              //     margin: const EdgeInsets.all(8),
                              //     height: 156,
                              //     width: 256,
                              //     color: Colors.grey,
                              //     child: Center(
                              //       child: Text(
                              //         "Foto+",
                              //         style: const TextStyle(color: Colors.white),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    _showPicker(context);
                                  },
                                  child: CircleAvatar(
                                    radius: 55,
                                    backgroundColor: Color(0xffFDCF09),
                                    child: _image != null
                                        ? ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
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
                                          borderRadius: BorderRadius.circular(50)),
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
                              SizedBox(height: 10),
                              TextFormField(

                                // controller: lastNameController,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                                decoration: InputDecoration(
                                  labelText: '    Kategoria',
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
                              SizedBox(height: 5),
                              TextFormField(
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                                decoration: InputDecoration(
                                  labelText: '    Lokalizacja',
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
                              SizedBox(height: 5),
                              TextFormField(
                                //controller: telephoneController,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: '    Cena',
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
                              SizedBox(height: 20),
                              TextFormField(
                                //controller: telephoneController,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                                decoration: InputDecoration(
                                  labelText: '    Opis',
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
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
                                  createUrlFromPhoto(_image,_image2,_image3,_image4);
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
              ]
          )
          )
        ],
      ),
    );
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera);


    setState(() {
      _image = image;
      _image2 = image;
      _image3 = image;
      _image4 = image;

    });
  }

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery);

    setState(() {
      //TODO:wykasować

      _image = image;
      _image2 = image;
      _image3 = image;
      _image4 = image;

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
        }
    );
  }


  Future<String>createUrlFromPhoto(File file,File file2,File file3,File file4)async
  {

    print(file2);


    var UserXML = {};
    UserXML["photo1"] = '';
    UserXML["photo2"] = '';
    UserXML["photo3"] = '';
    UserXML["photo4"] = '';


    String base64Image1,base64Image2,base64Image3,base64Image4;
    if(file!=null)
      {
        List<int> imageBytes =  file.readAsBytesSync();
        base64Image1 = base64.encode(imageBytes);
        UserXML["photo1"] = base64Image1;
        print("TEST1");


       // encodedPhotos.add(base64Image1);
      } if(file2!=null)
        {
          List<int> imageBytes2 =  file2.readAsBytesSync();
         base64Image2 = base64.encode(imageBytes2);
          UserXML["photo2"] = base64Image2;
          print("TEST2");
       //   encodedPhotos.add(base64Image2);
        } if(file3!=null)
        {
          List<int> imageBytes3 =  file3.readAsBytesSync();
          base64Image3 = base64.encode(imageBytes3);
          UserXML["photo3"] = base64Image3;
         // encodedPhotos.add(base64Image3);
        } if(file4!=null)
        {
          List<int> imageBytes4 =  file4.readAsBytesSync();
          base64Image4 = base64.encode(imageBytes4);
          UserXML["photo4"] = base64Image4;
          //encodedPhotos.add(base64Image4);
        }

    String str = json.encode(UserXML);
    print(str);



    final http.Response response = await http.post(
        Config.serverHostString + '/api/service-card/addPhotoToCloudinary',
          headers:{'Content-Type': 'application/json'},
          body: str


       // body: encodedPhotos
    );
        print(response.body);
    return response.body;
  }
}