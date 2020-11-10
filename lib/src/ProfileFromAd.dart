import 'package:fachowcy_app/src/customWidgets/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'customWidgets/AdCardSmall.dart';

class ProfileFromAd extends StatelessWidget {



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
                          child: Image.network("https://loremflickr.com/200/200",
                              width: 120, height: 120, fit: BoxFit.contain),
                        ),
                        SizedBox(height: 16),
                        UserNameSection(),
                        ContactSection(),
                        RatingSection(),
                        UserAd(),
                        CommentSection(),

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
  
}

class UserNameSection extends StatelessWidget {

  String name = "Loremiak";
  String lastName = "Ipsumiak";

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

  String rating = "5";
  String telephone = "123123123";
  String email = "loremiak@gmail.com";

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

  String rating = "5";

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
        Row( //TODO: wczytywać gwiazdki za pomocą oceny użytkownika
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.star_rate, color: Colors.white),
            Icon(Icons.star_rate, color: Colors.white),
            Icon(Icons.star_rate, color: Colors.white),
            Icon(Icons.star_rate, color: Colors.white),
            Icon(Icons.star_rate, color: Colors.white),
          ],
        ),
        SizedBox(height: 16),
        Text(
          "Ilość zrealizowanych zleceń",
          style: new TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(height: 8),
        Text(
          rating,
          style: new TextStyle(color: Colors.white, fontSize: 24),
        ),
      ],
    );
  }

}

class CommentSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 16),
        Text(
          "Komentarze",
          style: new TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(height: 8),
        Text(
          "tutaj cos bedzie",
          style: new TextStyle(color: Colors.white, fontSize: 24),
        )
      ],
    );
  }

}

//TODO: Feature builder i ładowanie z bazy
class UserAd extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 32),
        Text(
          "Ogłoszenia użytkownika",
          style: new TextStyle(color: Colors.white, fontSize: 16),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 0.65, //TODO: zrobić to mądrzej
          ),
          itemBuilder: (BuildContext context, int index) {

            return AdCardSmall(false, "Title", "Text text text Text text text Text text text Text text text Text text text ", 0);
          },
        ),
      ],
    );
  }


}