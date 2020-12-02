import 'package:fachowcy_app/src/customWidgets/CustomAppBar.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  @override
  _Notifications createState() => _Notifications();
}

class _Notifications extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=> Future.value(false),
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            CustomAppBar(),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 3),
                    ListTile(
                      title: Text('Tytuł Powiadomienia'),
                      subtitle: Text('Tekst Powiadomienia'),
                      isThreeLine: true,
                      leading: Icon(Icons.notifications_active),
                      // shape: ,
                    ),
                    Divider(height: 1)
                  ],
                );
              },
              childCount: 20,
            )),
          ],
        ),
      ),
    );
  }
}
