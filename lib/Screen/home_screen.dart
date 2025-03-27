import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'Services/notification_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.foregroundMessage();
    // notificationServices.getDeviceToken();
    notificationServices.getDeviceToken().then((token) {
      if (token != null) {
        print("Device Token: $token");
        // You can send this token to your server here
      }
      FirebaseMessaging.instance.getInitialMessage().then((message) {
        if (message != null) {
          print("App opened from terminated state: ${message.notification?.title}");
          print("App opened from terminated state: ${message.notification?.body}");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Push Notification"),
        backgroundColor: Colors.green,
      ),
    );
  }
}
