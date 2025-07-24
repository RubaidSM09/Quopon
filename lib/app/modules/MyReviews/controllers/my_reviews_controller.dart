import 'package:get/get.dart';

class Review {
  final String review;
  final String reviewer;
  final String time;

  const Review({
    required this.review,
    required this.reviewer,
    required this.time,
  });
}

class VendorFeedback {
  final String image;
  final String title;
  final String feedback;
  final String time;

  const VendorFeedback({
    required this.image,
    required this.title,
    required this.feedback,
    required this.time,
  });
}

class MyReviewsController extends GetxController {
  //TODO: Implement MyReviewsController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
