import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdCardSmall extends StatelessWidget {

  String title;
  String text;

//  AdCardSmall() {
//    this.title = "title";
//    this.text = "text";
//  }

  AdCardSmall(String title, String text) {
    this.title = title;
    this.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox( //tymczasowe, na razie nie moge nic lepszego znaleść
          width: 160,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 4.0)),
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      height: 60,
                      width: 120,
                      color: Colors.black,
                      child: Center(
                        child: Text(
                          "Foto",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    text,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

}