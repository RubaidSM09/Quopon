import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quopon/app/modules/signUpProcess/views/sign_up_process_view.dart';

import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../views/mail_verification_code_view.dart';

class ForgotPasswordController extends GetxController {
  // List of TextEditingControllers for OTP inputs
  final List<TextEditingController> controllers = List.generate(6, (_) => TextEditingController());

  // List of FocusNodes for each OTP input
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  // Reactive variable for loading state
  RxBool isLoading = false.obs;

  // Getter for joining the OTP code from all controllers
  String get code => controllers.map((controller) => controller.text).join();

  // Handles movement between text fields when a digit is entered
  void onDigitEntered(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  // Clears all OTP input fields and focuses on the first field
  void clearAll() {
    for (var c in controllers) {
      c.clear();
    }
    focusNodes.first.requestFocus();
  }

  // Sets the loading state (used for API calls)
  void setLoading(bool value) {
    isLoading.value = value;
  }

  Future<void> forgotPassword(String email) async {

    if (email.isEmpty) {
      // print('Please enter your email');
      SnackBar(content: Text('Please enter your email'),);
      return;
    }

    try {
      isLoading.value = true;

      final body = {
        'email':email,
      };

      final headers = {'Content-Type': 'application/json'};

      final response = await BaseClient.postRequest(
        api: Api.forgotPassword,
        body: jsonEncode(body),
        headers: headers,
      );

      // final result = await BaseClient.handleResponse(response);
      // debugPrint('Signup response: $result');
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Assuming the server responds with success on code 200 or 201
        final responseBody = jsonDecode(response.body);
        // final accessToken = responseBody['access'];
        // final refreshToken = responseBody['refresh'];
        // print('1');
        //
        // print(':::::::::::::::responseBody:::::::::::::::::::::$responseBody');
        // print(':::::::::::::::accessToken:::::::::::::::::::::$accessToken');
        // print(':::::::::::::::refreshToken:::::::::::::::::::::$refreshToken');

        Get.snackbar('Success', 'Account created successfully!');
        //Get.off(() => VerifyOTPView());
        Get.to(MailVerificationCodeView(email: email, passwordForgot: true,));


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

  Future<void> setNewPassword(String email, String newPassword, String confirmPassword) async {

    if (newPassword.isEmpty) {
      // print('Please enter your email');
      SnackBar(content: Text('Please enter your email'),);
      return;
    }

    if (newPassword.isEmpty || newPassword.length < 8) {
      SnackBar(content: Text('Password must be at least 7 characters'),);
      return;
    }

    if (newPassword != confirmPassword) {
      SnackBar(content: Text('Passwords do not match'),);
      return;
    }

    try {
      isLoading.value = true;

      final body = {
        'email':email,
        'password': newPassword,
      };

      final headers = {'Content-Type': 'application/json'};

      final response = await BaseClient.postRequest(
        api: Api.resetPassword,
        body: jsonEncode(body),
        headers: headers,
      );

      // final result = await BaseClient.handleResponse(response);
      // debugPrint('Signup response: $result');
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Assuming the server responds with success on code 200 or 201
        final responseBody = jsonDecode(response.body);
        // final accessToken = responseBody['access'];
        // final refreshToken = responseBody['refresh'];
        // print('1');
        //
        // print(':::::::::::::::responseBody:::::::::::::::::::::$responseBody');
        // print(':::::::::::::::accessToken:::::::::::::::::::::$accessToken');
        // print(':::::::::::::::refreshToken:::::::::::::::::::::$refreshToken');

        Get.snackbar('Success', 'Account created successfully!');
        //Get.off(() => VerifyOTPView());
        Get.to(SignUpProcessView());


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

  // Clean up controllers and focus nodes when the controller is disposed
  @override
  void onClose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.onClose();
  }
}
