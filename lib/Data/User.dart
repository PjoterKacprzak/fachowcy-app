import 'dart:convert';



class User{

  final int userId;
  final String userName;
  final String userLastName;
  final String userPassword;
  final String userTelephone;
  final String userAdresse;

  User({this.userId, this.userName, this.userLastName, this.userPassword,
      this.userTelephone, this.userAdresse});

  factory User.fromJson(Map<String,dynamic>json){
    return User(
        userId: json['id'],
        userName:json['name'],
        userLastName:json['lastName'],
        userPassword:json['password'],
        userTelephone:json['telephone'],
        userAdresse:json['adresse']);


  }



}