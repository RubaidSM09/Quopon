// lib/app/modules/Review/controllers/review_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:quopon/app/data/api_client.dart';

class ReviewController extends GetxController {
  /// holds the current star rating (1..5)
  final rating = 0.obs;

  /// simple loading flag for submit btn
  final isSubmitting = false.obs;

  /// Call this to send the review
  Future<bool> submitReview({
    required int menuItemId,
    required int rating,
    required String comment,
  }) async {
    if (rating <= 0) {
      Get.snackbar('Rating required', 'Please select at least 1 star');
      return false;
    }

    isSubmitting.value = true;
    try {
      final body = {
        'menu_item': menuItemId,
        'rating': rating,
        'comment': comment.trim(),
      };

      final res = await ApiClient.post('/discover/review-menu-item/', body);

      if (res.statusCode == 200 || res.statusCode == 201) {
        // optional: inspect response
        // final data = json.decode(res.body);
        return true;
      } else {
        // surface backend message if any
        String msg = 'Submit failed (${res.statusCode})';
        try {
          final j = json.decode(res.body);
          msg += '\n${j is Map ? j.toString() : res.body}';
        } catch (_) {
          msg += '\n${res.body}';
        }
        Get.snackbar('Error', msg);
        return false;
      }
    } catch (e) {
      Get.snackbar('Network', 'Could not submit review: $e');
      return false;
    } finally {
      isSubmitting.value = false;
    }
  }
}
