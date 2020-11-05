import 'dart:convert';

import 'package:fachowcy_app/Data/ServiceCard.dart';
import 'package:fachowcy_app/Data/User.dart';
import 'package:fachowcy_app/src/LoginPage.dart';
import 'package:fachowcy_app/src/customWidgets/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PostNewAd extends StatelessWidget {

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
                              ClipRRect(
                                borderRadius: BorderRadius.circular(40.0),
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  height: 156,
                                  width: 256,
                                  color: Colors.grey,
                                  child: Center(
                                    child: Text(
                                      "Foto+",
                                      style: const TextStyle(color: Colors.white),
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
}