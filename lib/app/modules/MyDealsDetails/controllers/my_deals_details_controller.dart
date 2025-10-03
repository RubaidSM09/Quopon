import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quopon/app/data/base_client.dart';

class MyDealsDetailsController extends GetxController {
  /// When opened from "My Deals", this item is already saved
  final isSaved = true.obs;

  /// Show spinner while calling the DELETE API
  final isDeleting = false.obs;

  /// Calls DELETE /vendors/wish-deals/{wishlist_id}/
  Future<bool> removeFromWishlist(int wishlistId) async {
    if (isDeleting.value) return false;
    isDeleting.value = true;

    try {
      final headers = await BaseClient.authHeaders();

      final resp = await http.delete(
        Uri.parse(
          'https://intensely-optimal-unicorn.ngrok-free.app/vendors/wish-deals/$wishlistId/',
        ),
        headers: headers,
      );

      if (resp.statusCode >= 200 && resp.statusCode < 300) {
        isSaved.value = false;
        return true;
      } else {
        Get.snackbar('Error', 'Failed to remove (code ${resp.statusCode})');
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return false;
    } finally {
      isDeleting.value = false;
    }
  }
}
