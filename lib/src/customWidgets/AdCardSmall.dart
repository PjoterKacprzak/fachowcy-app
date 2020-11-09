import 'package:fachowcy_app/src/UserProfile.dart';
import 'package:fachowcy_app/src/customWidgets/AdCardLarge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdCardSmall extends StatelessWidget {

  String title;
  String text;
  bool isUserProfile;
  int userAdId;

  AdCardSmall(bool isUserProfile, String title, String text, int userAdId) {
    this.title = title;
    this.text = text;
    this.isUserProfile = isUserProfile;
    this.userAdId = userAdId;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width / 2.3, //TODO: jakby coś się sypało na innych kształtach to tu
          child: Card(
            color: Colors.blueGrey, //TODO: Zmienić kolor i dopasować do tła reszty
            elevation: 4.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(width: 2, color: Colors.white),
            ),
            child: GestureDetector(
              onTap:() async{
                await AdCardLarge.getAdDataByAdId(userAdId);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdCardLarge()));
                },
              child: Container(
                //color: Colors.blueGrey,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Center(),
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
                        title + "\n\n",
                        style: const TextStyle(color: Colors.white, fontSize: 24),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow.fade,
                      ),
                      SizedBox(height: 10),
                      Text(
                        text + "\n\n",
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
                                onPressed: ()async {
                                  var result = await UserProfile.deleteUserCard(userAdId);
                                  await UserProfile.getDataFromJson();
                                  if(result==200) //TODO: zmienić żeby przechodziło bez http 200
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => UserProfile()));

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
        ),
      ],
    );
  }

}