// lib/app/modules/Profile/controllers/profile_controller.dart
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../login/views/login_view.dart';
import '../../../data/api_client.dart'; // <-- add this

class ProfileController extends GetxController {
  // bottom-nav
  var selectedIndex = 4.obs;

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // ---------- Profile state ----------
  final isLoading = false.obs;
  final email = ''.obs;
  final fullName = ''.obs;
  final phoneNumber = ''.obs;
  final language = ''.obs;
  final profilePictureUrl = ''.obs; // server may return profile_picture_url
  final country = ''.obs;
  final city = ''.obs;
  final address = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile(); // load on enter
  }

  Future<void> fetchProfile() async {
    isLoading.value = true;
    try {
      final res = await ApiClient.get('/food/my-profile/');
      if (res.statusCode == 200) {
        final j = json.decode(res.body) as Map<String, dynamic>;

        // server may use either key; support both
        final pic = (j['profile_picture_url'] ?? j['profile_picture'] ?? '').toString();

        email.value        = (j['email'] ?? '').toString();
        fullName.value     = (j['full_name'] ?? '').toString();
        phoneNumber.value  = (j['phone_number'] ?? '').toString();
        language.value     = (j['language'] ?? '').toString();
        profilePictureUrl.value = pic;
        country.value      = (j['country'] ?? '').toString();
        city.value         = (j['city'] ?? '').toString();
        address.value      = (j['address'] ?? '').toString();
      } else {
        Get.snackbar('Error', 'Failed to load profile (${res.statusCode})');
      }
    } catch (e) {
      Get.snackbar('Network', 'Could not load profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // ---------- Bottom nav ----------
  void onItemTapped(int index) {
    selectedIndex.value = index;
    switch (index) {
      case 0: Get.toNamed('/home'); break;
      case 1: Get.toNamed('/deals'); break;
      case 2: Get.toNamed('/qrScanner'); break;
      case 3: Get.toNamed('/myDeals'); break;
      case 4: break;
    }
  }

  // ---------- Logout ----------
  Future<void> userLogout() async {
    try {
      await _storage.deleteAll();
      Get.snackbar('Success', 'Logged out successfully!');
      Get.offAll(() => const LoginView());
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while logging out. Please try again.');
    }
  }
}
