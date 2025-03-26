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
    // notificationServices.isTokenRefresh();
    notificationServices.firebaseInit();
    notificationServices.foregroundMessage();
    notificationServices.getDeviceToken().then((value) {
      if (value != null) {
        print("Device Token: $value");
      } else {
        print("Failed to retrieve device token.");
      }
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
