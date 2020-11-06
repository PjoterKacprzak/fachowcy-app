import 'package:fachowcy_app/src/UserProfile.dart';
import 'package:fachowcy_app/src/customWidgets/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../ProfileFromAd.dart';
import 'AdCardSmall.dart';

class AdCardLarge extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      SizedBox(height: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 4.0)),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 16),
                              HorizontalFotoSection(),
                              Container(
                                margin: const EdgeInsets.all(8),
                                child: Column(
                                  children: <Widget>[
                                    TextSection(),
                                    SizedBox(height: 16),
                                    UserProfileShort(),
                                    SizedBox(height: 16),
                                    LocalizationSection(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 16),
                          Text("Podobne ogłoszenia", style: new TextStyle(color: Colors.white, fontSize: 24)),
                          SimilarAds(),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

}

//TODO: rozszerzyć to do FutureBuildera
class SimilarAds extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
    );
  }

}

class TextSection extends StatelessWidget {

  String title = "Tytuł";
  String estimatedTime = "2 dni";
  String text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur quis pellentesque ligula. Fusce egestas ligula ultrices, sagittis felis vitae, cursus dui. Mauris in lorem vel felis blandit facilisis. In sagittis urna vitae vulputate scelerisque. Pellentesque posuere odio sollicitudin lorem iaculis, vel egestas massa accumsan. Sed feugiat in sem id aliquet. Vestibulum varius vel augue vitae efficitur.";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 32),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 16),
        Row(
          children: <Widget>[
            Icon(Icons.timer, color: Colors.green),
            SizedBox(width: 8),
            Text(
              estimatedTime,
              style: new TextStyle(color: Colors.white, fontSize: 24),
            ),

          ],
        ),
        SizedBox(height: 16),
        Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          maxLines: 8,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

}

class LocalizationSection extends StatelessWidget {

  String location = "Loremowo";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.location_on, color: Colors.white),
            SizedBox(width: 8),
            Text(
              location,
              style: new TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap:(){
            print("Message");

//            Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => AdCardLarge()));
          },
          child: Row(
            children: <Widget>[
              Icon(Icons.email, color: Colors.green),
              SizedBox(width: 8),
              Text(
                "Napisz wiadomość",
                style: new TextStyle(color: Colors.green, fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }

}

class UserProfileShort extends StatelessWidget {

  String name = "Loremiak";
  String lastName = "Ipsumiak";
  String photoLink = "https://loremflickr.com/80/80";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print("Profile");

        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileFromAd()));
      },
      child: Row(
        children: <Widget>[
          Icon(Icons.person, color: Colors.white),
          SizedBox(width: 8),
          Column(
            children: <Widget>[
              Text(
                name,
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              Text(
                lastName,
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ],
          ),
          SizedBox(width: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(photoLink,
                width: 60, height: 60, fit: BoxFit.contain),
          ),

        ],
      ),
    );
  }

}

class HorizontalFotoSection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[

              Container(
                color: Colors.red, // Yellow
                height: 200.0,
                width: 200.0,
              ),

              Image.network('https://loremflickr.com/300/200',
                  width: 300, height: 200, fit: BoxFit.contain),

              Image.network('https://loremflickr.com/640/360',
                  width: 200, fit: BoxFit.contain),

              Container(
                color: Colors.pink, // Yellow
                height: 200.0,
                width: 200.0,
              ),

              Image.network('https://loremflickr.com/300/200',
                  width: 300, height: 200, fit: BoxFit.contain),

              Container(
                color: Colors.green, // Yellow
                height: 200.0,
                width: 200.0,
              ),

              Image.network('https://loremflickr.com/500/200',
                  width: 300, height: 200, fit: BoxFit.contain),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

}