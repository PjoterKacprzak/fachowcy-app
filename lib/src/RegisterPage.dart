import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:fachowcy_app/Config/Config.dart';
import 'package:fachowcy_app/Data/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginPage.dart';

//TODO: -Krystian musiałem dać to jako globalną bo stworzyłeś nową klasę dla Widgetu górnego, ta nowa klasa jest potrzebna? nie moze być jako zwykly Widget? bo uzywanie globalnej to sredni pomysl
enum WhoUsing { user, specialist }
WhoUsing _character = WhoUsing.user;

class NameValidator {
  static String validate(String value) {
    Pattern pattern = r'[A-Za-z]\w{0,40}';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value.length > 40)
      return 'Błedny format';
    else
      return null;
  }
}

class LastNameValidator {
  static String validate(String value) {
    {
      Pattern pattern = r'[A-Za-z]+';
      RegExp regex = new RegExp(pattern);
      if (!regex.hasMatch(value) || value.length > 40)
        return 'Błedny format';
      else
        return null;
    }
  }
}

class TelephoneValidator {
  static String validate(String value) {
    Pattern pattern = r'(^(?:[+0]9)?[0-9]{9,12}$)';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Błedny format';
    else
      return null;
  }
}

class PasswordValidator {
  static String validate(String value) {
    Pattern pattern = r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Błedny format';
    else
      return null;
  }
}

class RegisterPage extends StatelessWidget {
  TextEditingController nameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPassowrdController = new TextEditingController();
  TextEditingController adresseController = new TextEditingController();
  TextEditingController telephoneController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String _email, _password, _name, _lastName, _telephone, _confirmPassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: HexColor(Config.mainColor),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.only(left: 40, right: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30),
                  MyStatefulWidget(),
                  TextFormField(
                    inputFormatters: [
                      new WhitelistingTextInputFormatter(RegExp("[a-zA-Z ']")),
                    ],
                    validator: NameValidator.validate,
                    onSaved: (name) => _name = name,
                    //: nameController,
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
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    inputFormatters: [
                      new WhitelistingTextInputFormatter(RegExp("[a-zA-Z ']")),
                    ],
                    validator: LastNameValidator.validate,
                    onSaved: (lastName) => _lastName = lastName,

                    // controller: lastNameController,
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
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    //controller:emailController,
                    validator: (email) => EmailValidator.validate(email)
                        ? null
                        : "Invalid email address",
                    onSaved: (email) => _email = email,
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
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    validator: TelephoneValidator.validate,
                    onSaved: (telephone) => _telephone = telephone,
                    //controller: telephoneController,
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
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    validator: PasswordValidator.validate,
                    onSaved: (password) => _password = password,
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
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: confirmPassowrdController,
                    validator: (confirmPassword) {
                      Pattern pattern =
                          r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$';
                      RegExp regex = new RegExp(pattern);
                      if (!regex.hasMatch(confirmPassword))
                        return 'Błedny format';
                      else
                        return null;
                    },
                    onSaved: (confirmPassword) =>
                        _confirmPassword = confirmPassword,
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
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Builder(
                    builder: (context) => Center(
                      child: FlatButton(
                        color: HexColor(Config.buttonColor),
                        textColor: Colors.white,
                        padding: EdgeInsets.all(16.0),
                        splashColor: Colors.greenAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            {
                              if (passwordController.text !=
                                  confirmPassowrdController.text) {
                                print(passwordController);
                                print(confirmPassowrdController);
                                _showToastWrong(context, 'Hasła są różne!');
                                print("Hasła są różne");
                              } else {
                                _formKey.currentState.save();

                                if (await createUser(
                                        _name,
                                        _email,
                                        _lastName,
                                        _telephone,
                                        adresseController.text,
                                        _password,
                                        _character) ==
                                    200) {
                                  _showToastGood(context);
                                } else {
                                  _showToastWrong(
                                      context, 'Podany email jest w użyciu!');
                                }

//                            Navigator.pop(
//                                context,
//                                MaterialPageRoute(
//                                    builder: (context) => LoginPage()));
                              }
                            }
                          }
                        },
                        child: Text(
                          "Zarejestruj się",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  FlatButton(
                    color: HexColor(Config.buttonColor),
                    textColor: Colors.white,
                    padding: EdgeInsets.all(16.0),
                    splashColor: Colors.greenAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    onPressed: () {
                      Navigator.pop(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text(
                      "Wróć",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ));
  }

  void _showToastGood(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: HexColor(Config.buttonColor),
        content: const Text('Użytkownik zarejestrowany!',
            style: const TextStyle(fontSize: 20)),
        action: SnackBarAction(
            label: 'Zamknij',
            onPressed: scaffold.hideCurrentSnackBar,
            textColor: Colors.white),
      ),
    );
  }

  void _showToastWrong(BuildContext context, String message) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent,
        content: new Text(message, style: const TextStyle(fontSize: 16)),
        action: SnackBarAction(
            label: 'Zamknij',
            onPressed: scaffold.hideCurrentSnackBar,
            textColor: Colors.white),
      ),
    );
  }

  Future<int> createUser(String name, String email, String lastName,
      String telephone, String adresse, String password, WhoUsing role) async {
    var actualDate = new DateTime.now();
    print(actualDate);
    var dateFormatter = new DateFormat.yMd().add_jm();
    String formattedDate = dateFormatter.format(actualDate);
    String whoIs;
    if (role == WhoUsing.user) {
      whoIs = "user";
    } else {
      whoIs = "specialist";
    }

    var UserXML = {};
    UserXML["name"] = name;
    UserXML["lastName"] = lastName;
    UserXML["password"] = password;
    UserXML["phoneNumber"] = telephone;
    UserXML["adresse"] = adresse;
    UserXML["email"] = email;
    UserXML["rate"] = 0;
    UserXML["createdAt"] = formattedDate;
    UserXML["role"] = whoIs;
    String str = json.encode(UserXML);
    print(str);

    final http.Response response = await http.post(
        Config.serverHostString + '/api/users/addUser',
        headers: {'Content-Type': 'application/json'},
        body: str);
    print(response.statusCode);
    // CHECK THE REPOSONE NUMBERS
    if ((response.statusCode >= 200) || (response.statusCode <= 299)) {
      return response.statusCode;
    } else if ((response.statusCode >= 400) || (response.statusCode <= 499)) {
      return response.statusCode;
    } else {
      throw Exception('Failed to create User.');
    }
  }

  Future<int> createUserFacebook(String name, String email, String lastName,
      String telephone, String adresse, String password, WhoUsing role) async {
    var actualDate = new DateTime.now();
    print(actualDate);
    var dateFormatter = new DateFormat.yMd().add_jm();
    String formattedDate = dateFormatter.format(actualDate);
    String whoIs;
    if (role == WhoUsing.user) {
      whoIs = "user";
    } else {
      whoIs = "specialist";
    }

    var UserXML = {};
    UserXML["name"] = name;
    UserXML["lastName"] = lastName;
    UserXML["password"] = password;
    UserXML["phoneNumber"] = telephone;
    UserXML["adresse"] = adresse;
    UserXML["email"] = email;
    UserXML["rate"] = 0;
    UserXML["createdAt"] = formattedDate;
    UserXML["role"] = whoIs;
    String str = json.encode(UserXML);
    print(str);

    final http.Response response = await http.post(
        Config.serverHostString + '/api/users/addUser',
        headers: {'Content-Type': 'application/json'},
        body: str);

    Map<String, dynamic> result = jsonDecode(response.body);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', result.values.elementAt(2));
    print(result.values.elementAt(2));

    print(response.statusCode);
    // CHECK THE REPOSONE NUMBERS
    if ((response.statusCode >= 200) || (response.statusCode <= 299)) {
      return response.statusCode;
    } else if ((response.statusCode >= 400) || (response.statusCode <= 499)) {
      return response.statusCode;
    } else {
      throw Exception('Failed to create User.');
    }
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Theme(
              data: ThemeData(unselectedWidgetColor: Colors.white),
              child: Radio(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor: Colors.white,
                value: WhoUsing.user,
                groupValue: _character,
                onChanged: (WhoUsing value) {
                  setState(() {
                    _character = value;
                    print(value);
                  });
                },
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: const Text('Użytkownik',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20, color: Colors.white)),
          ),
          Expanded(
            flex: 1,
            child: Theme(
              data: ThemeData(unselectedWidgetColor: Colors.white),
              child: Radio(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor: Colors.white,
                value: WhoUsing.specialist,
                groupValue: _character,
                onChanged: (WhoUsing value) {
                  setState(() {
                    _character = value;
                    print(value);
                  });
                },
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: const Text('Fachowiec',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
