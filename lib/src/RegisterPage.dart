import 'dart:convert';

import 'package:fachowcy_app/Data/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'LoginPage.dart';

class RegisterPage extends StatelessWidget {
  TextEditingController nameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPassowrdController = new TextEditingController();
  TextEditingController adresseController = new TextEditingController();
  TextEditingController telephoneController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        //TODO: Wywalić go
        title: Text("Fachowcy"),
        backgroundColor: Colors.blue,
        brightness: Brightness.dark,
      ),
      body: Center(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1, // 20%
              child: Container(),
            ),
            Expanded(
              flex: 8, // 60%
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  TextFormField(
                    controller: nameController,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      labelText: 'Imię',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 3.0,
                          //TODO: ewentualnie to OutlineInputBorder
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10), //TODO: coś z tym zrobić
                  TextFormField(
                    controller: lastNameController,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      labelText: 'Nazwisko',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 3.0,
                          //TODO: ewentualnie to OutlineInputBorder
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10), //TODO: coś z tym zrobić
                  TextFormField(
                    controller:emailController,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.mail,
                        color: Colors.white,
                      ),
                      labelText: 'E-mail',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 3.0,
                          //TODO: ewentualnie to OutlineInputBorder
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10), //TODO: coś z tym zrobić
                  TextFormField(
                    controller: telephoneController,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      labelText: 'Telefon',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 3.0,
                          //TODO: ewentualnie to OutlineInputBorder
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10), //TODO: coś z tym zrobić
                  TextFormField(
                    controller: adresseController,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      labelText: 'Adres',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 3.0,
                          //TODO: ewentualnie to OutlineInputBorder
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10), //TODO: coś z tym zrobić
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: Colors.white,
                      ),
                      labelText: 'Hasło',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 3.0,
                          //TODO: ewentualnie to OutlineInputBorder
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10), //TODO: coś z tym zrobić
                  TextFormField(
                    controller: confirmPassowrdController,
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: Colors.white,
                      ),
                      labelText: 'Powtórz hasło',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 3.0,
                          //TODO: ewentualnie to OutlineInputBorder
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20), //TODO: coś z tym zrobić
                  FlatButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(16.0),
                    splashColor: Colors.greenAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    onPressed: () {
                      print(nameController.text);
                      print(lastNameController.text);
                      print(telephoneController.text);
                      print(adresseController.text);
                      createUser(nameController.text,emailController.text,lastNameController.text,
                          telephoneController.text, adresseController.text, passwordController.text);

                      Navigator.pop(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text(
                      "Zarejestruj się",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1, // 20%
              child: Container(),
            )
          ],
        ),
      ),
    );
  }

Future<User> createUser (String name,String email,String lastName,String telephone,
    String adresse,String password)async {
  var UserXML = {};
 // UserXML["id"] = 4444;
  UserXML["name"] = name;
  UserXML["lastName"] = lastName;
  UserXML["password"] = password;
  UserXML["telephone"] = telephone;
  UserXML["adresse"] = adresse;
  UserXML["email"] = email;
  String str = json.encode(UserXML);
  print(str);

  final http.Response response = await http.post(
    'http://10.0.2.2:8080/api/users/addUser',
    headers:{'Content-Type': 'application/json'},
    body: str
  );
  print(response.statusCode);
  // CHECK THE REPOSONE NUMBERS
  if ((response.statusCode >= 200)||(response.statusCode <=299)) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create album.');
  }
}

}