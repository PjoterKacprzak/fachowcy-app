import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdCardSmall extends StatelessWidget {

  String title;
  String text;
  bool isUserProfile;

//  AdCardSmall() {
//    this.title = "title";
//    this.text = "text";
//  }

  AdCardSmall(bool isUserProfile, String title, String text) {
    this.title = title;
    this.text = text;
    this.isUserProfile = isUserProfile;
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
            child: GestureDetector(
              onTap:(){
                print("Ad pressed");
              },
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
                      maxLines: 3,
                      overflow: TextOverflow.fade,
                    ),
                    SizedBox(height: 10),
                    Visibility(
//                       maintainSize: true,
//                       maintainAnimation: true,
//                       maintainState: true,
                       visible: isUserProfile,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Container(

                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              icon: new Icon(Icons.edit),
                              color: Colors.grey,
                              onPressed: () {
                                print("Edited!");
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              icon: new Icon(Icons.delete),
                              color: Colors.white,
                              onPressed: () {
                                print("Deleted!");
                              },
                            ),
                          ),


                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

}