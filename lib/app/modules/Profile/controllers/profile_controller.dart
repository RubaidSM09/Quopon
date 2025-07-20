import 'package:get/get.dart';

class ProfileController extends GetxController {
  // Observable for tracking selected index
  var selectedIndex = 4.obs;

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
}
