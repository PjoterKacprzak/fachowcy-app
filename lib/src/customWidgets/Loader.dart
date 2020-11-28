import 'package:flutter/material.dart';

class Loader extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.blue,
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
                  style: new TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        );
  }

}