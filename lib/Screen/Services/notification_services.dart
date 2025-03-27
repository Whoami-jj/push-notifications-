import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  FirebaseMessaging firebaseMessage = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


  Future foregroundMessage() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true
    );
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await firebaseMessage.requestPermission(alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User Granted Permission");
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print("User Granted Provisional Permission");
    } else {
      print("User Denied Permission");
    }
  }

  Future<String?> getDeviceToken() async {
    try {
      String? token = await firebaseMessage.getToken();
      return token;
    } catch (e) {
      print("Error fetching device token: $e");
      return null;
    }
  }

  void isTokenRefresh() async {
    firebaseMessage.onTokenRefresh.listen((event) {
      event.toString();
      print("refresh");
    });
  }

  void initLocalNotification(RemoteMessage message, BuildContext context) async {
    var androidInitializationSettings = AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosInitializationSettings = DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(
        initializationSetting, onDidReceiveNotificationResponse: (payload) {

    });
  }

  // void firebaseInit(BuildContext context) {  ///Physical device
  // // void firebaseInit() {
  //   FirebaseMessaging.onMessage.listen((message) {
  //
  //     if (kDebugMode){
  //       print("title: ${message.notification!.title}");
  //       print("body: ${message.notification!.body}");
  //     }
  //     /// Physical device
  //     if (Platform.isAndroid) {
  //       initLocalNotification(message, context);
  //       showNotifications(message);
  //     }
  //     ///
  //
  //     // showNotifications(message);
  //   });
  // }

  // void firebaseInit(BuildContext context) {
  //   FirebaseMessaging.onMessage.listen((message) {
  //     if (kDebugMode) {
  //       print("Message received: ${message.notification?.title}");
  //     }
  //
  //     // Only show local notification if it's a data message
  //     if (Platform.isAndroid) {
  //       initLocalNotification(message, context);
  //       showNotifications(message);
  //     }
  //   });
  // }
  // Future<void> showNotifications(RemoteMessage message) async {
  //   AndroidNotificationChannel channel = AndroidNotificationChannel(
  //       Random.secure().nextInt(1000).toString(), "High Importance Notifications", importance: Importance.max);
  //   AndroidNotificationDetails androidNotificationDetails =
  //   AndroidNotificationDetails(channel.id.toString(), channel.name.toString(),
  //       channelDescription: "your channel description", importance:Importance.high,
  //       priority: Priority.high, ticker: "ticker");
  //   DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(presentAlert: true,
  //       presentBadge: true, presentSound: true);
  //   NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails, iOS: darwinNotificationDetails);
  //
  //   Future.delayed(Duration.zero, () {
  //     flutterLocalNotificationsPlugin.show(
  //         0, message.notification!.title, message.notification!.body, notificationDetails
  //       // notificationDetails
  //     );
  //   });
  // }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        print("Foreground Message: ${message.notification?.title}");
      }

      // Always show notification in foreground with popup
      if (Platform.isAndroid) {
        showNotifications(
            title: message.notification?.title,
            body: message.notification?.body,
            showPopup: true
        );
      }
    });
  }

  Future<void> showNotifications({
    String? title,
    String? body,
    bool showPopup = false
  }) async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel',
        "High Importance Notifications",
        importance: Importance.max
    );

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: "your channel description",
      importance: Importance.max,
      priority: Priority.high,
      ticker: "ticker",
      playSound: true,
      enableVibration: true,
      visibility: NotificationVisibility.public,
      fullScreenIntent: showPopup, // Control popup behavior
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }
}