import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Services/get_firebae_server_key.dart';
import 'Services/notification_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationServices notificationServices = NotificationServices();
  String? deviceToken;

  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.foregroundMessage();
    notificationServices.setupBackgroundMessage(context);
    notificationServices.isTokenRefresh();

    // Get and store device token
    notificationServices.getDeviceToken().then((token) {
      setState(() {
        deviceToken = token;
      });
      if (token != null) {
        print("Device Token: $token");
      }
    });
  }

  Future<void> sendPushNotification() async {
    if (deviceToken == null) {
      print("Device token not available");
      return;
    }

    try {
      // First get an access token
      final accessToken = await GetServerKey().getServerKeyToken();
      print("AccessToken=> $accessToken");
      final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/v1/projects/pushnotification-38002/messages:send'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          'message': {
            'token': deviceToken,
            'notification': {
              'title': 'Flutter Notification',
              'body': 'Hello from Flutter!',
            },
            'data' : {
              'type': 'msg',
              'id': '123456',
            },
            // 'android': {
            //   'notification': {
            //     'click_action': 'FLUTTER_NOTIFICATION_CLICK', // Android specific
            //   }
            // },
            // 'apns': {
            //   'payload': {
            //     'aps': {
            //       'category': 'FLUTTER_NOTIFICATION_CLICK', // iOS specific
            //     }
            //   }
            // }
          },
        }),
      );
      print('Response: ${response.statusCode} - ${response.body}');
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Push Notification"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: sendPushNotification,
              child: const Text("Send Notification"),
            ),
          ],
        ),
      ),
    );
  }
}
