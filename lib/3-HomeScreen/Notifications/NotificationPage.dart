import 'package:flutter/material.dart';

import 'Notifications.dart';

class AwesomeNotificationPage extends StatefulWidget {
  const AwesomeNotificationPage({Key? key}) : super(key: key);

  @override
  State<AwesomeNotificationPage> createState() => _AwesomeNotificationPageState();
}

class _AwesomeNotificationPageState extends State<AwesomeNotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),

      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: (){
                //createNotification();
                MJNotification.notify("Alert!",
          "You have Some notifications ,go check them out!!", "basic_channel");
              },
              child: Text('Create Notification'),
            )
          )
        ],
      ),
    );
  }
}