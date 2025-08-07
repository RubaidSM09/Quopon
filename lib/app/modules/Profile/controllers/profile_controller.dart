import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../login/views/login_view.dart';

class ProfileController extends GetxController {
  // Observable for tracking selected index
  var selectedIndex = 4.obs;

  final FlutterSecureStorage _storage = FlutterSecureStorage();

  // Method for handling Bottom Navigation bar item taps
  void onItemTapped(int index) {
    selectedIndex.value = index;

    // Navigate based on selected index
    switch (index) {
      case 0:
      // Navigate to Home view
        Get.toNamed('/home'); // Replace with actual navigation
        break;
      case 1:
      // Navigate to Deals view
        Get.toNamed('/deals'); // Replace with actual navigation
        break;
      case 2:
      // Navigate to QR Scanner view
        Get.toNamed('/qrScanner'); // Replace with actual navigation
        break;
      case 3:
      // Navigate to My Deals view
        Get.toNamed('/myDeals'); // Replace with actual navigation
        break;
      case 4:
      // Stay on Profile view
        break;
    }
  }

  Future<void> userLogout() async {
    try {
      await FlutterSecureStorage().deleteAll();
      await _storage.delete(key: 'access_token');
      await _storage.delete(key: 'refresh_token');

      Get.snackbar('Success', 'Logged out successfully!');

      Get.offAll(() => LoginView());
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while logging out. Please try again.');
    }
  }
}
