import 'dart:convert';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



class Authentication
{
  final fbLogin = FacebookLogin();

  Future<Map<String,dynamic>> signInFB() async {
    final FacebookLoginResult result = await fbLogin.logIn(["email"]);
    final String token = result.accessToken.token;
    final response = await  http.get('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
    Map<String,dynamic> user = jsonDecode(response.body);



    return user;
  }
}