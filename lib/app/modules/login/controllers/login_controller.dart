// lib/app/modules/login/controllers/login_controller.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:quopon/app/modules/landing/views/landing_vendor_view.dart';
import 'package:quopon/app/modules/landing/views/landing_view.dart';
import 'package:quopon/app/services/fcmServices.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import 'package:quopon/app/services/social_auth_service.dart';

class LoginController extends GetxController {
  var isPasswordVisible = false.obs;
  var isLoading = false.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _storage = const FlutterSecureStorage();
  final _social = SocialAuthService();

  Future<void> storeTokens(String access, String refresh, int userId) async {
    await _storage.write(key: 'access_token', value: access);
    await _storage.write(key: 'refresh_token', value: refresh);
    await _storage.write(key: 'user_id', value: userId.toString());
  }

  void togglePasswordVisibility() => isPasswordVisible.toggle();

  // ✅ ONE method that covers both Sign In & Sign Up via your /auth/social-signin/
  Future<void> socialSignIn({
    required String userType, // 'user' | 'vendor'
    required String provider, // 'Google' | 'Apple'
  }) async {
    try {
      isLoading.value = true;
      print('Rubaid2');

      final id = provider == 'Google'
          ? await _social.google()
          : await _social.apple();

      print(id);

      final payload = {
        'email': id,
        'user_type': userType,
        'auth_provider': provider,
        // 'id_token': id.idToken, // (optional if you add server verification)
      };

      final res = await BaseClient.postRequest(
        api: Api.socialSignin,
        body: jsonEncode(payload),
        headers: {'Content-Type': 'application/json'},
      );

      if (res.statusCode >= 200 && res.statusCode < 300) {
        final data = jsonDecode(res.body);
        final access = data['token']?['access'] ?? data['access'];
        final refresh = data['token']?['refresh'] ?? data['refresh'];
        final uid = int.tryParse('${data['user']?['id'] ?? data['id']}') ?? 0;
        final type = data['user']?['user_type'] ?? data['user_type'] ?? userType;

        await storeTokens(access, refresh, uid);

        final fcm = FCMService();
        await fcm.setFCMToken();

        Get.snackbar('Success', 'Signed in with $provider');

        if (type == 'vendor') {
          Get.offAll(() => const LandingVendorView());
        } else {
          Get.offAll(() => const LandingView());
        }
      } else {
        String msg = 'Social sign-in failed';
        try { msg = (jsonDecode(res.body)['message'] ?? msg).toString(); } catch (_) {}
        Get.snackbar('Error', msg);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // (your existing email/password login remains unchanged)
  Future<void> userLogin() async {
    if (emailController.text.trim().isEmpty) {
      Get.snackbar('Invalid', 'Please enter a valid email');
      return;
    }
    if (passwordController.text.trim().isEmpty) {
      Get.snackbar('Invalid', 'Password must not be empty');
      return;
    }
    try {
      isLoading.value = true;
      final body = {
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
      };
      final response = await BaseClient.postRequest(
        api: Api.login,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        final accessToken = responseBody['access'];
        final refreshToken = responseBody['refresh'];
        final userId = responseBody['id'];
        final userType = responseBody['user_type'];

        await storeTokens(accessToken, refreshToken, userId);

        final fcmService = FCMService();
        await fcmService.setFCMToken();

        Get.snackbar('Success', 'Logged in successfully!');
        if (userType == 'vendor') {
          Get.offAll(() => const LandingVendorView());
        } else {
          Get.offAll(() => const LandingView());
        }
      } else {
        final responseBody = jsonDecode(response.body);
        Get.snackbar('Login failed', responseBody['message'] ?? 'Please use correct email and password');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
