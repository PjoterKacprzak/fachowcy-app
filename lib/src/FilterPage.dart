import 'dart:convert';

import 'package:fachowcy_app/Data/ServiceCard.dart';
import 'package:fachowcy_app/Data/User.dart';
import 'package:fachowcy_app/src/LoginPage.dart';
import 'package:fachowcy_app/src/customWidgets/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
class FilterPage extends StatefulWidget {
  FilterPage({Key key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}


class _FilterPageState extends State<FilterPage> {
var _category = ['Wykończenia', 'AGD', 'Stolarka', 'Elektryka','Malowanie'];
var _currentSelectedCategory = 'Wykończenia';
void _onDropItemSelected(String newSelectedCategory){
  setState(() {
    this._currentSelectedCategory = newSelectedCategory;
  });
}
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
                                'Filtruj',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 30, color: Colors.white)
                            ),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[Text(
                                'Kategoria',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 25, color: Colors.white),
                            )
                            ]
                            ),
                            DropdownButton<String>(
                              style: TextStyle(color: Colors.white, fontSize: 20),
                              dropdownColor: Colors.lightBlue,
                              icon: Icon(Icons.keyboard_arrow_down, color: Colors.white,),
                              isExpanded: true,
                              items: _category.map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem),
                                );
                              }).toList(),
                              onChanged: (String newSelectedCategory){
                                _onDropItemSelected(newSelectedCategory);
                              },
                              value: _currentSelectedCategory,
                            ),
                            SizedBox(height: 10),
                            TextFormField(

                              // controller: lastNameController,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Lokalizacja',
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
                            Row(
                            children: <Widget>[
                              Flexible(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                              decoration: InputDecoration(
                                labelText: '    Cena od',
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
                              ),
                              Flexible(
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                    ),
                                    decoration: InputDecoration(
                                      labelText: '    Cena do',
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
                              )
                            ]
                            ),
                            SizedBox(height: 10),
                            TextFormField( //TODO: Ocena jako gwiazdki, tak jak na mockup'ach, można użyć smooth_star_rating
                              //controller: telephoneController,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Ocena min',
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
                            SizedBox(height: 40),
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
            ]
          )
          )
        ],
      ),
    );
  }
}