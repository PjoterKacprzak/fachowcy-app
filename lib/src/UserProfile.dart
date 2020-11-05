import 'dart:convert';

import 'package:fachowcy_app/Data/UserProfileData.dart';
import 'package:fachowcy_app/src/customWidgets/AdCardSmall.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'customWidgets/CustomAppBar.dart';
import 'customWidgets/CustomBottomNavigation.dart';

import 'package:http/http.dart' as http;


class UserProfile extends StatelessWidget {

  static var userData;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
        body:  Container(
          color: Colors.blueGrey,
          child: CustomScrollView(
            slivers: <Widget>[
              CustomAppBar(),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child:Column(
                      children: <Widget>[
                        SizedBox(height: 30),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: 120,
                            height: 120,
                            color: Colors.grey,
                            child: Center(
                              child: Text(
                                "Foto",
                                style: new TextStyle(fontSize: 30),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        CustomLabels("Imię i nazwisko", userData.name + " " + userData.lastName),
                        CustomLabels("E-mail", userData.email),
                        CustomLabels("Data utworzenia", userData.createdAt),
                        CustomLabels("Hasło", "***********"), //TODO: jakos to rozwiązać
                        CustomLabels("Twoje ogłoszenia", ""),

                            FutureBuilder(
                              future: getDataFromJson(),
                              builder: (BuildContext context, AsyncSnapshot snapshot) {
                                int numberOfAds = 0;
                                for(int i = 0; i < userData.serviceCardLists.length; i++) {
                                  if(userData.serviceCardLists[i].active == true) {
                                    numberOfAds++;
                                  }
                                }
                                //print(numberOfAds);
                                if(snapshot.data == null) {
                                  return Container(
                                    child: Center(
                                      child: Text(
                                          "Loading..",
                                        style: new TextStyle(fontSize: 50),
                                      ),
                                    ),
                                  );
                                } else {
                                  return GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: numberOfAds,
                                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 5,
                                        childAspectRatio: 0.58, //TODO: zrobić to mądrzej
                                    ),
                                    itemBuilder: (BuildContext context, int index) {
                                      while(!userData.serviceCardLists[index].active) {
                                        index++;
                                      }
                                      return AdCardSmall(true, userData.serviceCardLists[index].title, userData.serviceCardLists[index].description);
                                    },
                                  );
                                }
                              },
                            ),
//                            AdCardSmall(true , userData.serviceCardLists[0].title, userData.serviceCardLists[0].description),
//                            AdCardSmall(true , userData.serviceCardLists[1].title, userData.serviceCardLists[1].description),
//                            AdCardSmall(true , userData.serviceCardLists[2].title, userData.serviceCardLists[2].description),


                      ],
                    ),
                  ),
                ],
                ),
              )
            ],
          ),
        ),

        // bottomNavigationBar: CustomBottomNavigation(),
      ),
    );
  }

  static Future<int> getDataFromJson() async {
    var UserXML = {};
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    UserXML["email"] = prefs.getString('email'); //TODO: Zmienić na inne maile
    String email = json.encode(UserXML);

    final http.Response response = await http.post(
      'http://10.0.2.2:8080/api/users/profile-info',
      headers:{'Content-Type': 'application/json'},
      body: email,
    );

    Map userProfileDataMap = jsonDecode(response.body);
    var userProfileData = UserProfileData.fromJson(userProfileDataMap);

    // TODO: CHECK THE REPOSONE NUMBERS

    if ((response.statusCode >= 200)&&(response.statusCode <=299)) {
      userData = userProfileData;
      //print(userData.serviceCardLists[2].serviceCardId);

      print("User profile data received from server");
      return response.statusCode;
    } else {
      throw new Exception('Failed to load profile data.');
    }
  }

  static Future<int> deleteUserCard(int id) async {
    var UserXML = {};
    UserXML["serviceCardId"] = id; //TODO: tutaj serviceCardId czy service-card-id (JSON - BAZA)
    String cardId = json.encode(UserXML);

    final http.Response response = await http.post(
      'http://10.0.2.2:8080/api/service-card/deactivate',
      headers:{'Content-Type': 'application/json'},
      body: cardId,
    );

    // TODO: CHECK THE REPOSONE NUMBERS
    if ((response.statusCode >= 200)&&(response.statusCode <=299)) {

      print("User ad with ID: " + id.toString() + "deleted."); //TODO: user ad with id "xxx" and title "xxx" deleted
      return response.statusCode;
    } else {
      throw new Exception("Failed to delete user ad with ID: " + id.toString() + ".");
    }
  }
}


class CustomLabels extends StatelessWidget {

  String name;
  String dataString;

  CustomLabels(String name, String dataString) {
    this.name = name;
    this.dataString = dataString;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 16),
          Center(
            child: Column(
              children: <Widget>[
                Text(
                  name,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  dataString,
                  style: const TextStyle(color: Colors.white, fontSize: 26),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}

