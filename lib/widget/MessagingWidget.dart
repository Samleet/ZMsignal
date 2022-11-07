import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MessagingWidget {
  static final FlutterLocalNotificationsPlugin
    flutterLocalNotification = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    InitializationSettings initializationSettings = 
    InitializationSettings(
      iOS: DarwinInitializationSettings(),
      android: AndroidInitializationSettings('@mipmap/ic_launcher')
    );
    await flutterLocalNotification.initialize(
      initializationSettings,

      // onDidReceiveNotificationResponse: (notification) {
      //   print(notification);
      // },

    );

    //onLaunch
    /**
     * When the app is completely closed (not in the background) 
     * and opened directly from the push notification
     */
    FirebaseMessaging.instance.getInitialMessage().then((event) {

      print('getInitialMessage data: ${event?.data}');

    });


    //onMessage
    /**
     * When the app is open and it receives a push notification
     */
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {

      print('onMessage data: ${message.data}');
      MessagingWidget.showNotification(message);

    });
    

    //onResume
    /**
     * When the app is in the background and is opened directly 
     * from the push notification.
     */
    FirebaseMessaging.onMessageOpenedApp.listen( (RemoteMessage 
    message) {

      print('onMessageOpenedApp data: ${message.data}');
      MessagingWidget.showNotification(message);

    });
  }

  static Future showNotification(RemoteMessage message) async {
    final NotificationDetails notification = NotificationDetails(
      android: AndroidNotificationDetails(
        "ZMstrategy",
        "signal",
        enableLights: true,
        enableVibration: true,
        priority: Priority.high,
        importance: Importance.max,
        largeIcon: DrawableResourceAndroidBitmap("ic_launcher"),
        styleInformation: MediaStyleInformation(
          htmlFormatContent: true,
          htmlFormatTitle: true,
        ),
        playSound: true,
      )
    );

    await flutterLocalNotification.show(
        message.data.hashCode,
        message.data['title'],
        message.data['body'],
        notification,
        // payload: message.data["message"]
    );
  }
  
  static Future<void> firebaseMessagingHandler(message) async {

    print("Handling a Background Message ${message.messageId}");
    MessagingWidget.showNotification(message);

  }

  static Future<void> subscribe (String signal) async {
    print("Subscribing to ${signal}...");
    await FirebaseMessaging.instance.subscribeToTopic (
      signal
    )
    .then((value) => {

      print("Successfully subscribed to this Topic:  ${signal}")

    });
  }

  static Future<void> unsubscribe(String signal) async {
    print("Unsubscribing from ${signal}...");
    await FirebaseMessaging.instance.unsubscribeFromTopic(
      signal
    )
    .then((value) => {

      print("Successfully detached from this Topic:  ${signal}")

    });
  }
}