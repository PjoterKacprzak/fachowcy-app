import 'package:fachowcy_app/Config/Config.dart';
import 'package:fachowcy_app/Data/UserCommentingData.dart';
import 'package:fachowcy_app/Data/UserProfileFromAdData.dart';
import 'package:fachowcy_app/src/customWidgets/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'customWidgets/AdCardSmall.dart';

class ProfileFromAd extends StatelessWidget {

  int adNumber;
  static var profileData;
  static int index;
  static double overallRating = 0;
  static int numberOfRatings = 0;

  ProfileFromAd(int id) {
    this.adNumber = id;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.blueGrey,
          child: CustomScrollView(
            slivers: <Widget>[
              CustomAppBar(),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 30),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: profileData.profilePhoto == null ?
                            Container(color: Colors.grey, width: 120, height: 120, child: Center(child: Icon(Icons.no_photography, size: 32.0,),),) :
                            profileData.profilePhoto == "profile_photo" ?
                            Container(color: Colors.grey, width: 120, height: 120, child: Center(child: Icon(Icons.no_photography, size: 32.0,),),) :
                            Image.network(profileData.profilePhoto, width: 120, height: 120, fit: BoxFit.contain)
                        ),
                        SizedBox(height: 16),
                        UserNameSection(profileData.name, profileData.lastName),
                        ContactSection(profileData.phoneNumber, profileData.email),
                        RatingSection(profileData.rate),
                        UserAds(profileData, adNumber),
                        CommentSection(profileData, adNumber),

                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<int> getProfileDataByAdId(int id) async {
    var UserXML = {};

    UserXML["serviceCardId"] = id;
    String serviceCardId = json.encode(UserXML);

    final http.Response response = await http.post(
      Config.serverHostString + '/api/service-card/findUserByServiceCardID',
      headers: {'Content-Type': 'application/json'},
      body: serviceCardId,
    );

    Map userProfileDataMap = jsonDecode(response.body);
    var userProfileData = UserProfileFromAdData.fromJson(userProfileDataMap);
    int indexx;

    for(int i = 0; i < userProfileData.serviceCardLists.length; i++) {
      if(userProfileData.serviceCardLists[i].serviceCardId == id) {
        indexx = i;
        break;
      }
    }

    // TODO: CHECK THE REPOSONE NUMBERS

    if ((response.statusCode >= 200) && (response.statusCode <= 299)) {

      profileData = userProfileData;
      index = indexx;
      print("User profile data from ad received from server");
      return response.statusCode;
    } else {
      throw new Exception('Failed to load profile data after ad.');
    }
  }

}

class UserNameSection extends StatelessWidget {

  String name;
  String lastName;


  UserNameSection(String name, String lastName) {
    this.name = name;
    this.lastName = lastName;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          name + " " + lastName,
          style: new TextStyle(color: Colors.white, fontSize: 32),
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: (){
            print("Portfolio");
          },
          child: Text(
            "Skomentuj użytkownika",
            style: new TextStyle(color: Colors.green, fontSize: 20),
          ),
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: (){
            print("Portfolio");
          },
          child: Text(
            "Zobacz portfolio",
            style: new TextStyle(color: Colors.green, fontSize: 20),
          ),
        ),
      ],
    );
  }

}

class ContactSection extends StatelessWidget {

  String telephone;
  String email;

  ContactSection(String telephone, String email) {
    this.telephone = telephone;
    this.email = email;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 16),
        Text(
          "Kontakt",
          style: new TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(height: 8),
        Text(
          telephone,
          style: new TextStyle(color: Colors.white, fontSize: 24),
        ),
        SizedBox(height: 8),
        Text(
          email,
          style: new TextStyle(color: Colors.white, fontSize: 24),
        ),
      ],
    );
  }

}



class RatingSection extends StatelessWidget {

 double rate;

 RatingSection(double rate) {
   this.rate = rate;
 }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 16),
        Text(
          "Ocena",
          style: new TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(height: 8),
        rate == null ?
        Text(
          "Nie ma jeszcze żadnej oceny",
          style: new TextStyle(color: Colors.white, fontSize: 24),) :
        StarDisplay(value: rate),
      ],
    );
  }

}

class StarDisplay extends StatelessWidget {
  final double value;
  const StarDisplay({Key key, this.value = 0})
      : assert(value != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        print(index);
        return Icon(
          index < value - 0.75 ? Icons.star :
          0.75 > value - index && value - index > 0.25 ? Icons.star_half :
          Icons.star_border,
          color: Colors.white, size: 40,);
      }),
    );
  }
}

class UserAds extends StatelessWidget {

  var userData;
  int id;


  UserAds(var userData, int id) {
    this.userData = userData;
    this.id = id;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 32),
        Text(
          "Ogłoszenia użytkownika",
          style: new TextStyle(color: Colors.white, fontSize: 16),
        ),
        FutureBuilder(
          future: ProfileFromAd.getProfileDataByAdId(id),
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
                  crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: MediaQuery.of(context).orientation == Orientation.portrait ? 0.58 : 0.76, //TODO: zrobić to mądrzej
                ),
                itemBuilder: (BuildContext context, int index) {

                  bool flag = true;
                  while(flag) {
                    if(userData.serviceCardLists[myIndex].active == false) {

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
        ),
      ],
    );
  }
}

class CommentSection extends StatelessWidget {

  var userData;
  int id;
  static var userCommentingData;

  CommentSection(var userData, int id) {
    this.userData = userData;
    this.id = id;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 16),
        Text(
          "Komentarze",
          style: new TextStyle(color: Colors.white, fontSize: 16),
        ),
        FutureBuilder(
          future: ProfileFromAd.getProfileDataByAdId(id),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            int numberOfAds = userData.userCommentList.length;

            if(numberOfAds == 0) {
              return Column(
                children: <Widget>[
                  SizedBox(height: 8,),
                  Text(
                    "Nie ma jeszcze żadnych komentarzy!",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                ],
              );
            }
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
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: numberOfAds,
                itemBuilder: (BuildContext context, int index) {

                  //getUserCommentingData(userData.userCommentList[index].userCommentingId);
                  return ListTile(
                    title: userData.userCommentList[index].name == null ?
                    Text(
                      "ID komentującego usera:" + userData.userCommentList[index].userCommentingId.toString(),
                      style: new TextStyle(color: Colors.green, fontSize: 20),) :
                    Text(
                      userData.userCommentList[index].name + " " + userData.userCommentList[index].lastName,
                      style: new TextStyle(color: Colors.green, fontSize: 20),),
                    subtitle: Text(
                      userData.userCommentList[index].rate.toString() + "\n" + userData.userCommentList[index].description,
                      style: new TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    isThreeLine: true,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child:  userData.userCommentList[index].profilePhoto == null ?
                      Container(color: Colors.grey, width: 60, height: 60, child: Center(child: Icon(Icons.no_photography, size: 32.0,),),) :
                      userData.userCommentList[index].profilePhoto == "profile_photo" ?
                      Container(color: Colors.grey, width: 60, height: 60, child: Center(child: Icon(Icons.no_photography, size: 32.0,),),) :
                      Image.network(userData.userCommentList[index].profilePhoto, width: 60, height: 60, fit: BoxFit.contain)
                    ),
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }

//  static Future<int> getUserCommentingData(int id) async {
//
//    final response = await http.get(Config.serverHostString + "/api/users/findbyID?id=" + id.toString());
//
//    Map userDataCommentMap = jsonDecode(response.body);
//    var userDataComment = UserCommentingData.fromJson(userDataCommentMap);
//
//    // TODO: CHECK THE REPOSONE NUMBERS
//
//    if ((response.statusCode >= 200) && (response.statusCode <= 299)) {
//
//      userCommentingData = userDataComment;
//      print("User commenting data received.");
//      return response.statusCode;
//    } else {
//      print("coś nie pykło");
//      throw new Exception('Failed to load user commenting data.');
//    }
//  }

}