import 'package:fachowcy_app/Config/Config.dart';
import 'package:fachowcy_app/src/UserProfile.dart';
import 'package:fachowcy_app/src/customWidgets/AdCardLarge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';

import '../EditServiceCard.dart';

class AdCardSmall extends StatelessWidget {

  String title;
  String text;
  String photo;
  bool isUserProfile;
  int userAdId;

  AdCardSmall(bool isUserProfile, String title, String text, int userAdId, String photo) {
    this.title = title;
    this.text = text;
    this.isUserProfile = isUserProfile;
    this.userAdId = userAdId;
    this.photo = photo;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width:  MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.width / 2.3 : MediaQuery.of(context).size.width / 3.3, //TODO: jakby coś się sypało na innych kształtach to tu
          child: Card(
            color: HexColor('#2162f3'), //TODO: Zmienić kolor i dopasować do tła reszty
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(width: 4, color: Colors.white),
            ),
            child: GestureDetector(
              onTap:() async{
                await AdCardLarge.getAdDataByAdId(userAdId);
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdCardLarge(userAdId)));
              },
              child: Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Center(),
                      SizedBox(height: 10,),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: photo == null ?
                          Container(color: Colors.grey, width: 120, height: 90, child: Center(child: Icon(Icons.no_photography, size: 32.0,),),) :
                          photo == "link_to_photo" ?
                          Container(color: Colors.grey, width: 120, height: 90, child: Center(child: Icon(Icons.no_photography, size: 32.0,),),) :
                          Image.network(photo, width: 120, height: 90, fit: BoxFit.contain)
                      ),
                      SizedBox(height: 10,),
                      Container(
                        margin: const EdgeInsets.only(left: 4, right: 4),
                        child: Text(
                          title + "\n\n",
                          style: const TextStyle(color: Colors.white, fontSize: 24),
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.only(left: 4, right: 4),
                        child: Text(
                          text + "\n\n",
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          overflow: TextOverflow.fade,
                        ),
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
                                color: Colors.white,
                                onPressed: () {Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => EditServiceCard(userAdId)));

//                                    Navigator.push(
//                                        context,
//                                        MaterialPageRoute(builder: (context) => UserProfile()));

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