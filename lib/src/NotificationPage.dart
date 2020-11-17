import 'package:fachowcy_app/src/customWidgets/CustomAppBar.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget{
  @override
  _Notifications createState() => _Notifications();

}
class _Notifications extends State<NotificationPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
      child: Text("Powiadomienia"),
    )
    );
  }

}