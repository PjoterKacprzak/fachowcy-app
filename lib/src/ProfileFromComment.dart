import 'package:fachowcy_app/Config/Config.dart';
import 'package:fachowcy_app/Data/UserCommentingData.dart';
import 'package:fachowcy_app/Data/UserProfileFromAdData.dart';
import 'package:fachowcy_app/src/customWidgets/CustomAppBar.dart';
import 'package:fachowcy_app/src/AddComment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'Portfolio.dart';
import 'ProfileFromComment.dart';
import 'customWidgets/AdCardSmall.dart';

class ProfileFromComment extends StatefulWidget {
  @override
  _ProfileFromCommentState createState() => _ProfileFromCommentState();

  static int userId;
  int adNumber;
  static var profileData;
  static int index;
  static double overallRating = 0;
  static int numberOfRatings = 0;

  ProfileFromComment(int id) {
    this.adNumber = id;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: HexColor(Config.mainColor),
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
                            child: profileData.profilePhoto == null
                                ? Container(
                                    color: Colors.grey,
                                    width: 120,
                                    height: 120,
                                    child: Center(
                                      child: Icon(
                                        Icons.no_photography,
                                        size: 32.0,
                                      ),
                                    ),
                                  )
                                : profileData.profilePhoto == "profile_photo"
                                    ? Container(
                                        color: Colors.grey,
                                        width: 120,
                                        height: 120,
                                        child: Center(
                                          child: Icon(
                                            Icons.no_photography,
                                            size: 32.0,
                                          ),
                                        ),
                                      )
                                    : Image.network(profileData.profilePhoto,
                                        width: 120,
                                        height: 120,
                                        fit: BoxFit.contain)),
                        SizedBox(height: 16),
                        UserNameSection(
                            profileData.name,
                            profileData.lastName,
                            profileData.id,
                            profileData.id,
                            profileData.portfolio),
                        ContactSection(
                            profileData.phoneNumber, profileData.email),
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

  static Future<int> getProfileDataById(int id) async {
    final response = await http.get(
      Config.serverHostString + '/api/users/findbyID?id=' + id.toString(),
    );

    Map userProfileDataMap = jsonDecode(response.body);

    var userProfileData = UserProfileFromAdData.fromJson(userProfileDataMap);

    // TODO: CHECK THE REPOSONE NUMBERS

    if ((response.statusCode >= 200) && (response.statusCode <= 299)) {
      profileData = userProfileData;
      print("User profile data from comment received from server");
      return response.statusCode;
    } else {
      throw new Exception('Failed to load profile data after comment.');
    }
  }
}

class _ProfileFromCommentState extends State<ProfileFromComment> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.blue,
          child: CustomScrollView(
            slivers: <Widget>[
              CustomAppBar(),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 30),
                          MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? Column(
                                  children: <Widget>[
                                    ClipRRect(borderRadius: BorderRadius.circular(20),
                                        child: ProfileFromComment.profileData.profilePhoto == null
                                            ? Container(color: Colors.grey, width: 120, height: 120,
                                                child: Center(child: Icon(Icons.no_photography, size: 32.0,),
                                                ),
                                              )
                                            : ProfileFromComment.profileData.profilePhoto == "profile_photo"
                                                ? Container(color: Colors.grey, width: 120, height: 120,
                                                    child: Center(child: Icon(Icons.no_photography, size: 32.0,),),
                                                  )
                                                : Image.network(ProfileFromComment.profileData.profilePhoto, width: 120, height: 120, fit: BoxFit.contain)),
                                    SizedBox(height: 16),
                                    UserNameSection(ProfileFromComment.profileData.name, ProfileFromComment.profileData.lastName, ProfileFromComment.profileData.email, ProfileFromComment.profileData.userId, ProfileFromComment.profileData.portfolio),
                                    ContactSection(ProfileFromComment.profileData.phoneNumber, ProfileFromComment.profileData.email),
                                    RatingSection(ProfileFromComment.profileData.rate),
                                    UserAds(ProfileFromComment.profileData, widget.adNumber),
                                    CommentSection(ProfileFromComment.profileData, widget.adNumber),
                                  ],
                                )
                              : Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: ProfileFromComment
                                                            .profileData
                                                            .profilePhoto ==
                                                        null
                                                    ? Container(
                                                        color: Colors.grey,
                                                        width: 120,
                                                        height: 120,
                                                        child: Center(
                                                          child: Icon(
                                                            Icons
                                                                .no_photography,
                                                            size: 32.0,
                                                          ),
                                                        ),
                                                      )
                                                    : ProfileFromComment
                                                                .profileData
                                                                .profilePhoto ==
                                                            "profile_photo"
                                                        ? Container(
                                                            color: Colors.grey,
                                                            width: 120,
                                                            height: 120,
                                                            child: Center(
                                                              child: Icon(
                                                                Icons
                                                                    .no_photography,
                                                                size: 32.0,
                                                              ),
                                                            ),
                                                          )
                                                        : Image.network(
                                                            ProfileFromComment
                                                                .profileData
                                                                .profilePhoto,
                                                            width: 120,
                                                            height: 120,
                                                            fit: BoxFit
                                                                .contain)),
                                            SizedBox(height: 16),
                                            UserNameSection(
                                                ProfileFromComment
                                                    .profileData.name,
                                                ProfileFromComment
                                                    .profileData.lastName,
                                                ProfileFromComment
                                                    .profileData.email,
                                                ProfileFromComment
                                                    .profileData.userId,
                                                ProfileFromComment
                                                    .profileData.portfolio),
                                          ],
                                        ),
                                        SizedBox(width: 64),
                                        Column(
                                          children: <Widget>[
                                            ContactSection(
                                                ProfileFromComment
                                                    .profileData.phoneNumber,
                                                ProfileFromComment
                                                    .profileData.email),
                                            RatingSection(ProfileFromComment
                                                .profileData.rate),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        UserAds(ProfileFromComment.profileData,
                                            widget.adNumber),
                                        CommentSection(
                                            ProfileFromComment.profileData,
                                            widget.adNumber),
                                      ],
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserNameSection extends StatelessWidget {
  String name;
  String lastName;
  String email;
  int id;
  String portfolio;

  UserNameSection(
      String name, String lastName, String email, int id, String portfolio) {
    this.name = name;
    this.lastName = lastName;
    this.email = email;
    this.id = id;
    this.portfolio = portfolio;
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
        FlatButton(
          color: HexColor(Config.buttonColor),
          textColor: Colors.white,
          padding: EdgeInsets.all(12.0),
          splashColor: Colors.greenAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          onPressed: () {
            print("email : $email");

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddComment(email, id)));
          },
          child: Text(
            "Wystaw komentarz",
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        SizedBox(height: 8),
        FlatButton(
          color: HexColor(Config.buttonColor),
          textColor: Colors.white,
          padding: EdgeInsets.all(12.0),
          splashColor: Colors.greenAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          onPressed: () {
            print("Portfolio");

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Portfolio(portfolio, id)));
          },
          child: Text(
            "Zobacz portfolio",
            style: TextStyle(fontSize: 20.0),
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
        rate == null
            ? Text(
                "Nie ma jeszcze żadnej oceny",
                style: new TextStyle(color: Colors.white, fontSize: 24),
              )
            : StarDisplay(value: rate),
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
        return Icon(
          index < value - 0.75
              ? Icons.star
              : 0.75 > value - index && value - index > 0.25
                  ? Icons.star_half
                  : Icons.star_border,
          color: Colors.white,
          size: 40,
        );
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
          future: ProfileFromComment.getProfileDataById(id),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            int numberOfAds = 0;
            int myIndex = 0;
            for (int i = 0; i < userData.serviceCardLists.length; i++) {
              if (userData.serviceCardLists[i].active == true) {
                numberOfAds++;
              }
            }

            if (numberOfAds == 0) {
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
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.white)),
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
                padding: new EdgeInsets.only(top: 16),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: numberOfAds,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 2
                          : 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 0.58
                          : 0.76, //TODO: zrobić to mądrzej
                ),
                itemBuilder: (BuildContext context, int index) {
                  bool flag = true;
                  while (flag) {
                    if (userData.serviceCardLists[myIndex].active == false) {
                      if (myIndex <= userData.serviceCardLists.length) {
                        myIndex++;
                      }
                    } else {
                      flag = false;
                    }
                  }

                  if (myIndex <= userData.serviceCardLists.length) {
                    myIndex++;
                  }

                  return AdCardSmall(
                      false,
                      userData.serviceCardLists[myIndex - 1].title,
                      userData.serviceCardLists[myIndex - 1].description,
                      userData.serviceCardLists[myIndex - 1].serviceCardId,
                      userData.serviceCardLists[myIndex - 1].photo);
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
        SizedBox(height: 40),
        Text(
          "Komentarze",
          style: new TextStyle(color: Colors.white, fontSize: 16),
        ),
        FutureBuilder(
          future: ProfileFromComment.getProfileDataById(id),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            int numberOfAds = userData.userCommentList.length;

            if (numberOfAds == 0) {
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Nie ma jeszcze żadnych komentarzy!",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                ],
              );
            }
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.white)),
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
                padding: new EdgeInsets.all(0),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: numberOfAds,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () async {
                      await ProfileFromComment.getProfileDataById(
                          userData.userCommentList[index].userCommentingId);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileFromComment(userData
                                  .userCommentList[index].userCommentingId)));
                    },
                    child: ListTile(
                      title: userData.userCommentList[index].name == null
                          ? Text(
                              "ID komentującego usera:" +
                                  userData
                                      .userCommentList[index].userCommentingId
                                      .toString(),
                              style: new TextStyle(
                                  color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          : Text(
                              userData.userCommentList[index].name +
                                  " " +
                                  userData.userCommentList[index].lastName,
                              style: new TextStyle(
                                  color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                      subtitle: Text(
                        userData.userCommentList[index].rate.toString() +
                            "\n" +
                            userData.userCommentList[index].description,
                        style: new TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      isThreeLine: true,
                      leading: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: userData.userCommentList[index].profilePhoto ==
                                  null
                              ? Container(
                                  color: Colors.grey,
                                  width: 60,
                                  height: 60,
                                  child: Center(
                                    child: Icon(
                                      Icons.no_photography,
                                      size: 32.0,
                                    ),
                                  ),
                                )
                              : userData.userCommentList[index].profilePhoto ==
                                      "profile_photo"
                                  ? Container(
                                      color: Colors.grey,
                                      width: 60,
                                      height: 60,
                                      child: Center(
                                        child: Icon(
                                          Icons.no_photography,
                                          size: 32.0,
                                        ),
                                      ),
                                    )
                                  : Image.network(
                                      userData
                                          .userCommentList[index].profilePhoto,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.contain)),
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
}
