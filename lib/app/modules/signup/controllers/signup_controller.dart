import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:quopon/app/modules/forgot_password/views/mail_verification_code_view.dart';
import 'package:quopon/app/modules/signUpProcess/views/sign_up_process_view.dart';

import '../../../data/api.dart';
import '../../../data/base_client.dart';

class SignupController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final referralCodeController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  var isLoading = false.obs;

  Future<void> signup(String userType) async {

    if (emailController.text.trim().isEmpty) {
      SnackBar(content: Text('Please enter a valid email'),);
      return;
    }

    if (passwordController.text.trim().isEmpty || passwordController.text.length < 1) {
      SnackBar(content: Text('Password must be at least 7 characters'),);
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      SnackBar(content: Text('Passwords do not match'),);
      return;
    }

    try {
      isLoading.value = true;

      final body = {
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
        'referral_code': referralCodeController.text.trim(),
        'user_type': userType
      };

      final headers = {'Content-Type': 'application/json'};

      final response = await BaseClient.postRequest(
        api: Api.signup,
        body: jsonEncode(body),
        headers: headers,
      );

      // final result = await BaseClient.handleResponse(response);
      // debugPrint('Signup response: $result');
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Assuming the server responds with success on code 200 or 201
        final responseBody = jsonDecode(response.body);
        final accessToken = responseBody['access'];
        final refreshToken = responseBody['refresh'];
        print('1');

        print(':::::::::::::::responseBody:::::::::::::::::::::$responseBody');
        print(':::::::::::::::accessToken:::::::::::::::::::::$accessToken');
        print(':::::::::::::::refreshToken:::::::::::::::::::::$refreshToken');

        Get.snackbar('Success', 'Account created successfully!');
        //Get.off(() => VerifyOTPView());
        Get.to(MailVerificationCodeView(email: emailController.text.trim(), passwordForgot: false,));


        // SharedPreferences

        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setBool('isLoggedIn', true); // User is logged in

        // homeController.fetchProfileData();
        // homeController.checkVerified(email);

      } else {
        final responseBody = jsonDecode(response.body);
        Get.snackbar('Error', responseBody['message'] ?? 'Sign-up failed\nPlease Use Different Username');
      }
    } catch (e, stack) {
      debugPrint('Signup error: $e');
      debugPrint('Stack trace: $stack');
      SnackBar(content: Text(e.toString()),);
    } finally {
      isLoading.value = false;
    }
  }
}
