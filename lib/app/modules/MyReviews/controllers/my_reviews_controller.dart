// lib/app/modules/MyReviews/controllers/my_reviews_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../data/api_client.dart';

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

class ReviewItem {
  final int id;
  final int menuItem;
  final int rating;
  final String comment;
  final DateTime createdAt;

  ReviewItem({
    required this.id,
    required this.menuItem,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory ReviewItem.fromJson(Map<String, dynamic> j) => ReviewItem(
    id: j['id'] as int,
    menuItem: j['menu_item'] as int,
    rating: j['rating'] as int,
    comment: (j['comment'] ?? '').toString(),
    createdAt: DateTime.tryParse((j['created_at'] ?? '').toString()) ??
        DateTime.now(),
  );
}

class MyReviewsController extends GetxController {
  final isLoading = false.obs;
  final reviews = <ReviewItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyReviews();
  }

  Future<void> fetchMyReviews() async {
    isLoading.value = true;
    try {
      final res = await ApiClient.get('/discover/my-reviews/');
      if (res.statusCode == 200) {
        final list = (json.decode(res.body) as List)
            .map((e) => ReviewItem.fromJson(e as Map<String, dynamic>))
            .toList();
        reviews.assignAll(list);
      } else {
        Get.snackbar('Error', 'Failed to load reviews (${res.statusCode})');
      }
    } catch (e) {
      Get.snackbar('Network', 'Could not load reviews: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// “2 days”, “3 h”, etc. — compact for your card
  String timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inDays >= 1) return '${diff.inDays} days';
    if (diff.inHours >= 1) return '${diff.inHours} h';
    if (diff.inMinutes >= 1) return '${diff.inMinutes} min';
    return DateFormat('MMM d').format(dt);
  }
}
