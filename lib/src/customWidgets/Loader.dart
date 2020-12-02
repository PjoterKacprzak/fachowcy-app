import 'package:fachowcy_app/Config/Config.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Loader extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: HexColor(Config.mainColor),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                    valueColor:
                    new AlwaysStoppedAnimation<Color>(Colors.white)),
                SizedBox(height: 8),
                Text(
                  "Fachowcy",
                  style: new TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
        );
  }

}