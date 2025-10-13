// lib/app/modules/Review/controllers/review_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quopon/app/data/api_client.dart';

class ReviewController extends GetxController {
  /// holds the current star rating (1..5)
  final rating = 0.obs;

  /// simple loading flag for submit btn
  final isSubmitting = false.obs;

  /// Item UI state (for preview in dialog)
  final isLoadingItem = false.obs;
  final itemTitle = ''.obs;
  final itemSubtitle = ''.obs;
  final itemImageUrl = ''.obs;

  String? _loadedForName;

  // -------- Load preview (title + image) by MENU NAME from /vendors/deals/ --------
  Future<void> loadMenuByName(String name) async {
    if (_loadedForName == name) return;
    _loadedForName = name;

    isLoadingItem.value = true;
    try {
      final headers = await ApiClient.authHeaders();
      headers['ngrok-skip-browser-warning'] = 'true';

      final res = await http.get(
        Uri.parse('https://doctorless-stopperless-turner.ngrok-free.dev/vendors/deals/'),
        headers: headers,
      );

      if (res.statusCode >= 200 && res.statusCode < 300) {
        final data = json.decode(res.body);
        if (data is List) {
          final match = data
              .whereType<Map<String, dynamic>>()
              .firstWhere(
                (m) => (m['title'] ?? '').toString().toLowerCase() == name.toLowerCase(),
            orElse: () => const {},
          );

          if (match.isNotEmpty) {
            itemTitle.value = (match['title'] ?? name).toString();
            itemSubtitle.value = (match['description'] ?? '').toString();

            final logo = (match['logo_image'] ?? '').toString();
            final imgPath = (match['image'] ?? '').toString(); // e.g. "image/upload/..."
            itemImageUrl.value = logo.isNotEmpty
                ? logo
                : (imgPath.isNotEmpty ? 'https://res.cloudinary.com/dfqklzktu/$imgPath' : '');
            return;
          }
        }
      }

      // Fallback if nothing matched
      itemTitle.value = name;
      itemSubtitle.value = '';
      itemImageUrl.value = '';
    } catch (_) {
      itemTitle.value = name;
      itemSubtitle.value = '';
      itemImageUrl.value = '';
    } finally {
      isLoadingItem.value = false;
    }
  }

  // -------- helper: resolve numeric ID by NAME for POST --------
  Future<int?> _getMenuIdByName(String name) async {
    try {
      final headers = await ApiClient.authHeaders();
      headers['ngrok-skip-browser-warning'] = 'true';

      final res = await http.get(
        Uri.parse('https://doctorless-stopperless-turner.ngrok-free.dev/vendors/deals/'),
        headers: headers,
      );

      if (res.statusCode >= 200 && res.statusCode < 300) {
        final data = json.decode(res.body);
        if (data is List) {
          final match = data
              .whereType<Map<String, dynamic>>()
              .firstWhere(
                (m) => (m['title'] ?? '').toString().toLowerCase() == name.toLowerCase(),
            orElse: () => const {},
          );
          if (match.isNotEmpty) {
            final id = match['id'];
            if (id is int) return id;
            if (id is String) return int.tryParse(id);
          }
        }
      }
    } catch (_) {}
    return null;
  }

  // -------- Submit review by NAME (resolve id first) --------
  Future<bool> submitReviewByName({
    required String menuName,
    required int rating,
    required String comment,
  }) async {
    if (rating <= 0) {
      Get.snackbar('Rating required', 'Please select at least 1 star');
      return false;
    }

    // Resolve ID from the provided name
    final menuId = await _getMenuIdByName(menuName);
    if (menuId == null) {
      Get.snackbar('Not found', 'Could not find menu item "$menuName".');
      return false;
    }

    isSubmitting.value = true;
    try {
      final body = {
        'menu_item': menuId, // backend expects numeric id
        'rating': rating,
        'comment': comment.trim(),
      };

      final res = await ApiClient.post('/discover/review-menu-item/', body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        return true;
      } else {
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
