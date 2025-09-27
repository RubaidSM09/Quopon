import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:quopon/app/modules/landing/views/landing_vendor_view.dart';
import 'package:quopon/app/modules/landing/views/landing_view.dart';
import 'package:quopon/app/services/fcmServices.dart';

import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../../Review/views/review_view.dart';
import '../views/login_view.dart';

class LoginController extends GetxController {
  var isPasswordVisible = false.obs;
  var isLoading = false.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FlutterSecureStorage _storage = FlutterSecureStorage(); // For secure storage

  // Store tokens securely
  Future<void> storeTokens(String accessToken, String refreshToken, int userId) async {
    await _storage.write(key: 'access_token', value: accessToken);
    await _storage.write(key: 'refresh_token', value: refreshToken);
    await _storage.write(key: 'user_id', value: userId.toString());
  }

  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }

  Future<void> userLogin() async {
    if (emailController.text.trim().isEmpty) {
      SnackBar(
          content: Text('Please enter a valid email'),
      );
      return;
    }
    if (passwordController.text.trim().isEmpty ||
        passwordController.text.length < 1) {
      SnackBar(
          content: Text('Password must be at least 7 characters'),
      );
      return;
    }

    try {
      isLoading.value = true;

      var body = {
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
      };

      var headers = {
        'Content-Type': 'application/json',
      };

      final response = await BaseClient.postRequest(
        api: Api.login,
        body: jsonEncode(body),
        headers: headers,
      );

      //final result = await BaseClient.handleResponse(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Assuming the server responds with success on code 200 or 201
        final responseBody = jsonDecode(response.body);
        final accessToken = responseBody['access'];
        final refreshToken = responseBody['refresh'];
        final userId = responseBody['id'];
        final userType = responseBody['user_type'];

        // Store the tokens securely
        await storeTokens(accessToken, refreshToken, userId);

        print(':::::::::::::::responseBody:::::::::::::::::::::$responseBody');
        print(':::::::::::::::accessToken:::::::::::::::::::::$accessToken');
        print(':::::::::::::::refreshToken:::::::::::::::::::::$refreshToken');

        final FCMService fcmService = FCMService();
        await fcmService.setFCMToken();

        Get.snackbar('Success', 'Logged in successfully!');

        //Get.off(() => VerifyOTPView());


        // SharedPreferences

        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setBool('isLoggedIn', true); // User is logged in

        // Get.offAll(() => DashboardView());

        // homeController.fetchProfileData();
        // homeController.checkVerified(username);

        if (userType == 'vendor') {
          Get.to(LandingVendorView());
        } else {
          Get.to(LandingView());
          Get.dialog(ReviewView(menuItemId: 1));
        }
      } else {
        final responseBody = jsonDecode(response.body);
        Get.snackbar('Login failed', responseBody['message'] ?? 'Please use Correct UserName and Password');
      }
    } catch (e) {
      print(e);
      SnackBar(
        content: Text(e.toString()),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
