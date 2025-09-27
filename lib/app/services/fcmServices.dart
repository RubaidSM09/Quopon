import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:quopon/app/data/api_client.dart';

class FCMService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Singleton pattern to ensure a single instance of the service
  static final FCMService _instance = FCMService._internal();
  factory FCMService() => _instance;
  FCMService._internal();

  // Method to fetch the FCM token
  Future<String?> setFCMToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        await _sendTokenToServer(token);
        print('----🏷️🏷️🏷️🏷️🏷️-->>>>>>>>>>>>> FCM Token: $token'); // Debug log
      }
    } catch (e) {
      print('Error fetching FCM token: $e');
      return null;
    }
    return null;
  }

  Future<void> _sendTokenToServer(String token) async {

    try {
      final body = {
        "registration_id": token,
        "type": "android"
      };
      await ApiClient.post(
        '/notifications/device/register/',
        body,
      );

    } catch (e) {
      print('Sign-in error: $e');
    }
  }

  // Method to Unregister
  Future<String?> removeFCMToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        await _removeTokenFromServer(token);
      }
    } catch (e) {
      print('Error fetching FCM token: $e');
      return null;
    }
    return null;
  }

  Future<void> _removeTokenFromServer(String token) async {

    try {
      final body = {
        "registration_id": token,
      };
      await ApiClient.post(
        '/notifications/device/unregister/',
        body,
      );

    } catch (e) {
      print('Sign-in error: $e');
    }
  }
}