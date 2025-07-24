import 'package:get/get.dart';

class OnboardingVendorController extends GetxController {
  var currentIndex = 0.obs; // Track the current slide index
  List<String> images = [
    'assets/images/Vendor/Onboarding/onboarding1.jpg',  // Replace with actual image paths
    'assets/images/Vendor/Onboarding/onboarding2.jpg',
    'assets/images/Vendor/Onboarding/onboarding3.jpg'
  ];

  List<String> titles = [
    'Grow Your Reach with Qoupon',
    'Track Performance & Drive Conversions',
    'Built with Local Vendors in Mind'
  ];

  List<String> descriptions = [
    'Join a platform built to help vendors attract new customers and boost repeat visits with targeted, redeemable deals.',
    'Access real-time insights, manage deal redemptions with QR codes, and connect directly with customers, everything from one simple dashboard.',
    'See how businesses like yours use Qoupon to fill slow hours, launch new items, and retain loyal customers.'
  ];

  // Auto slide update every 3 seconds
  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 3), () {
      updateSlide();
    });
  }

  void updateSlide() {
    if (currentIndex.value < images.length - 1) {
      currentIndex.value++;
    } else {
      currentIndex.value = 0; // Loop back to the first slide
    }
    // Repeat the update process every 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      updateSlide();
    });
  }
}
