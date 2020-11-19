import 'dart:convert';
import 'dart:io';

import 'package:fachowcy_app/Config/Config.dart';
import 'package:fachowcy_app/Data/UserProfileData.dart';
import 'package:fachowcy_app/src/ChangePasswordFromUserProfile.dart';
import 'package:fachowcy_app/src/customWidgets/AdCardSmall.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginPage.dart';
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
                            child: userData.profilePhoto == null ?
                            Container(color: Colors.grey, width: 120, height: 120, child: Center(child: Icon(Icons.no_photography, size: 32.0,),),) :
                            userData.profilePhoto == "profile_photo" ?
                            Container(color: Colors.grey, width: 120, height: 120, child: Center(child: Icon(Icons.no_photography, size: 32.0,),),) :
                            Image.network(userData.profilePhoto, width: 120, height: 120, fit: BoxFit.contain)
                        ),
                        SizedBox(height: 16),
                        Portfolio(),
                        SizedBox(height: 8),
                        Logout(),
                        SizedBox(height: 16),
                        CustomLabels("Imię i nazwisko", userData.name + " " + userData.lastName),
                        CustomLabels("E-mail", userData.email),
                        CustomLabels("Data utworzenia", userData.createdAt),
                        PasswordEdit(),
                        SizedBox(height: 16),
                        CustomLabels("Twoje ogłoszenia", ""),
                        UserAdSection(userData),
                        SizedBox(height: 16),
                        CustomLabels("Historia ogłoszeń", ""),
                        UserHistorySection(userData),
                      ],
                    ),
                  ),
                ],
                ),
              )
            ],
          ),
        ),

        //bottomNavigationBar: CustomBottomNavigation(),
      ),
    );
  }

  static Future<int> getDataFromJson() async {
    var UserXML = {};
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    UserXML["email"] = prefs.getString('email'); //TODO: Zmienić na inne maile
    String email = json.encode(UserXML);

    final http.Response response = await http.post(
      Config.serverHostString + '/api/users/profile-info',
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
    UserXML["serviceCardId"] = id;
    String cardId = json.encode(UserXML);

    final http.Response response = await http.post(
      Config.serverHostString +  '/api/service-card/deactivate',
      headers:{'Content-Type': 'application/json'},
      body: cardId,
    );


    // TODO: CHECK THE REPOSONE NUMBERS

    if ((response.statusCode >= 200)&&(response.statusCode <=299)) {

      print("User ad with ID: " + id.toString() + " deleted.");
      return response.statusCode;
    } else {
      throw new Exception("Failed to delete user ad with ID: " + id.toString()+ ".");
    }
  }
}

class PasswordEdit extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 16),
        Center(
          child: Column(
            children: <Widget>[
              Text(
                "Hasło",
                style: const TextStyle(color: Colors.white, fontSize: 18),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4),
              GestureDetector(
                onTap: (){
                  print("Edited");

                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChangePasswordFromUserProfile()));
                },
                child: Text(
                  "Zmień hasło",
                  style: const TextStyle(color: Colors.green, fontSize: 24),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}

class UserAdSection extends StatelessWidget {

  var userData;


  UserAdSection(var userData) {
    this.userData = userData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserProfile.getDataFromJson(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        int numberOfAds = 0;
        int myIndex = 0;
        for(int i = 0; i < userData.serviceCardLists.length; i++) {
          if(userData.serviceCardLists[i].active == true) {
            numberOfAds++;
          }
        }

        if(numberOfAds == 0) {
          return Column(
            children: <Widget>[
              Text(
                "Nie masz aktywynych ogłoszeń",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              SizedBox(height: 40),
            ],
          );
        }
        //print("Liczba aktywnych ogłoszeń: " + numberOfAds.toString());
        //sleep(const Duration(milliseconds: 100));
        if(snapshot.data == null) {
          return Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)),
                  SizedBox(height: 8),
                  Text(
                    "Loading, please wait..",
                    style: new TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
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
              childAspectRatio: 0.52, //TODO: zrobić to mądrzej
            ),
            itemBuilder: (BuildContext context, int index) {
              bool flag = true;
              while(flag) {
                if(userData.serviceCardLists[myIndex].active == false) {
                  //print("Ogłoszenie nieaktywne ID: " + userData.serviceCardLists[myIndex].serviceCardId.toString());
                  if(myIndex <= userData.serviceCardLists.length) {
                    myIndex++;
                  }
                } else {
                  flag = false;
                }
              }

//                                  print("\nIndex: " + index.toString());
//                                  print("My index: " + myIndex.toString());
//                                  print("Number of ads: " + numberOfAds.toString());
//                                  print("AdCardSmall title: " + userData.serviceCardLists[myIndex].title);
//                                  print("AdCardSmall desc: " + userData.serviceCardLists[myIndex].description);

              if(myIndex <= userData.serviceCardLists.length) {
                myIndex++;
              }

              return AdCardSmall(true, userData.serviceCardLists[myIndex-1].title, userData.serviceCardLists[myIndex-1].description, userData.serviceCardLists[myIndex-1].serviceCardId, userData.serviceCardLists[myIndex-1].photo);
            },
          );
        }
      },
    );
  }

}

class UserHistorySection extends StatelessWidget {

  var userData;

  UserHistorySection(var userData) {
    this.userData = userData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserProfile.getDataFromJson(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        int numberOfAds = 0;
        int myIndex = 0;
        for(int i = 0; i < userData.serviceCardLists.length; i++) {
          if(userData.serviceCardLists[i].active == false) {
            numberOfAds++;
          }
        }

        if(numberOfAds == 0) {
          return Column(
            children: <Widget>[
              Text(
                "Nie masz usuniętych ogłoszeń",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              SizedBox(height: 40),
            ],
          );
        }
        //sleep(const Duration(milliseconds: 100));
        if(snapshot.data == null) {
          return Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)),
                  SizedBox(height: 8),
                  Text(
                    "Loading, please wait..",
                    style: new TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
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
              bool flag = true;
              while(flag) {
                if(userData.serviceCardLists[myIndex].active == true) {
                  if(myIndex <= userData.serviceCardLists.length) {
                    myIndex++;
                  }
                } else {
                  flag = false;
                }
              }
              if(myIndex <= userData.serviceCardLists.length) {
                myIndex++;
              }
              return AdCardSmall(false, userData.serviceCardLists[myIndex-1].title, userData.serviceCardLists[myIndex-1].description, userData.serviceCardLists[myIndex-1].serviceCardId, userData.serviceCardLists[myIndex-1].photo);
            },
          );
        }
      },
    );
  }

}

class Portfolio extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap:(){
          print("Portfolio");

//          Navigator.push(
//              context,
//              MaterialPageRoute(builder: (context) => LoginPage()));
        },
        child: Text(
          "Dodaj portfolio",
          style: const TextStyle(color: Colors.green, fontSize: 24),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

}



class Logout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap:(){
          print("Logout");
          logout();
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()));
        },
        child: Text(
          "Wyloguj",
          style: const TextStyle(color: Colors.green, fontSize: 24),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );

//    return Container(
//      child: Align(
//        alignment: Alignment.topRight,
//        child: IconButton(
//          icon: Icon(
//            Icons.logout,
//            color: Colors.white,),
//          onPressed: () {
//            logout();
//
//            Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => LoginPage()));
//          },
//        ),
//      ),
//    );
  }

  Future<Null> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', null);
    prefs.setString('password', null);
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