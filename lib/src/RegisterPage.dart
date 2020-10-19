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
    appBar: AppBar(
      title: Text("Register Page"),
    ),
    body: Center(
      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: nameController,
            obscureText: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name',
            ),
          ),
          TextField(
            controller: lastNameController,
            obscureText: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Last Name',
            ),
          ),
          TextField(
            controller:emailController,
            obscureText: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'E-mail',
            ),
          ),
          TextField(
            controller: telephoneController,
            obscureText: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Telephone',
            ),
          ),
          TextField(
            controller: adresseController,
            obscureText: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Adresse',
            ),
          ),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),
          TextField(
            controller: confirmPassowrdController,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Confirm Password',
            ),
          ),

          FlatButton(
            color: Colors.blue,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(8.0),
            splashColor: Colors.blueAccent,
            onPressed: () {
              print(nameController.text);
              print(lastNameController.text);
              print(telephoneController.text);
              print(adresseController.text);
              createUser(nameController.text, lastNameController.text,
                  telephoneController.text, adresseController.text, passwordController.text);

              Navigator.pop(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Text(
              "Register",
              style: TextStyle(fontSize: 20.0),
            ),
          ),

        ],
      ),
      ),

  );

}

Future<User> createUser (String name,String lastName,String telephone,
    String adresse,String password)async {
  var UserXML = {};
 // UserXML["id"] = 4444;
  UserXML["name"] = name;
  UserXML["lastName"] = lastName;
  UserXML["password"] = password;
  UserXML["telephone"] = telephone;
  UserXML["adresse"] = adresse;
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