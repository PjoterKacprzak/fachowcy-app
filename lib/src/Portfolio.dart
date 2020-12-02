import 'package:fachowcy_app/Config/Config.dart';
import 'package:fachowcy_app/src/ProfileFromComment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Portfolio extends StatelessWidget {
  String portfolioString;
  int userId;

  Portfolio(String portfolioString, int userId) {
    this.portfolioString = portfolioString;
    this.userId = userId;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: HexColor(Config.mainColor),
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                portfolioString == null
                    ? Column(
                        children: <Widget>[
                          Text(
                            "Brak portfolio",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                decoration: TextDecoration.none),
                          ),
                          SizedBox(height: 8),
                          ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                color: Colors.grey,
                                width: 120,
                                height: 120,
                                child: Center(
                                  child: Icon(
                                    Icons.no_photography,
                                    size: 32.0,
                                  ),
                                ),
                              )),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(portfolioString),
                      ),
                SizedBox(height: 16),
                FlatButton(
                  color: HexColor(Config.buttonColor),
                  textColor: Colors.white,
                  padding: EdgeInsets.all(16.0),
                  splashColor: Colors.greenAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
//                    Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => ProfileFromComment(userId)));
                  },
                  child: Text(
                    "Wróć",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
