import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import 'Utlities.dart';

class MJNotification {
  static late BuildContext context;
  setContext(BuildContext cont) {
    context = cont;
  }

  static listenMJNotification() {
    AwesomeNotifications()
        .actionStream
        .listen((ReceivedNotification receivedNotification) async {
      print(receivedNotification.body);
      await AwesomeNotifications().getGlobalBadgeCounter().then(
          (value) => AwesomeNotifications().setGlobalBadgeCounter(value - 1));
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => ));
    });
  }

  static notify(String title, body, channelKey) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: channelKey,
            title: title,
            autoDismissible: true,
            color: Colors.deepPurple,
            backgroundColor: Colors.white,
            body: body));
  }
}

// if (Utilities.notificationlist.isNotEmpty) {
      // MJNotification.notify("Alert!",
      //     "You have Some notifications ,go check them out!!", "basic_channel");}


Future<void> createNotification() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'basic_channel',
      title:
          '${Emojis.money_money_bag + Emojis.plant_cactus} Buy Plant Food!!!',
      body: 'Florist at 123 Main St. has 2 in stock',
      bigPicture: 'asset://assets/cctv.png',
      notificationLayout: NotificationLayout.BigPicture,
      )
    );
}