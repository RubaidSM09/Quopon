// lib/app/modules/dealDetail/controllers/deal_detail_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quopon/app/data/base_client.dart';
import 'package:quopon/app/modules/MyDeals/controllers/my_deals_controller.dart'; // 👈 add

class DealDetailController extends GetxController {
  int? _dealId;
  bool _inited = false;

  final isSaved = false.obs;
  final isSaving = false.obs;
  final RxnInt wishlistId = RxnInt();

  void init(int dealId) {
    if (_inited) return;
    _dealId = dealId;
    _inited = true;
    _checkIfSaved();
  }

  Future<void> toggleWishlist() async {
    if (isSaving.value || _dealId == null) return;
    if (isSaved.value) {
      await removeFromWishlist();
    } else {
      await addToWishlist(dealId: _dealId!);
    }
  }

  Future<void> _checkIfSaved() async {
    if (_dealId == null) return;
    try {
      final headers = await BaseClient.authHeaders();
      final resp = await BaseClient.getRequest(
        api: 'http://10.10.13.99:8090/vendors/wish-deals/',
        headers: headers,
      );

      if (resp.statusCode >= 200 && resp.statusCode < 300) {
        final List<dynamic> rows = jsonDecode(resp.body);
        final row = rows.cast<Map<String, dynamic>?>().firstWhere(
              (e) => (e?['deal'] as int?) == _dealId,
          orElse: () => null,
        );

        if (row != null) {
          wishlistId.value = row['id'] as int?;
          isSaved.value = true;
        } else {
          wishlistId.value = null;
          isSaved.value = false;
        }
      }
    } catch (_) {}
  }

  Future<bool> addToWishlist({required int dealId}) async {
    if (isSaving.value) return false;
    isSaving.value = true;
    try {
      final headers = await BaseClient.authHeaders();
      headers['Content-Type'] = 'application/json';

      final res = await BaseClient.postRequest(
        api: 'http://10.10.13.99:8090/vendors/wish-deals/',
        headers: headers,
        body: jsonEncode({'deal': dealId}),
      );

      if (res.statusCode >= 200 && res.statusCode < 300) {
        isSaved.value = true;
        await _checkIfSaved();    // learn wishlistId
        _notifyMyDealsRefresh();  // 👈 refresh My Deals (if controller exists)
        return true;
      } else {
        Get.snackbar('Error', 'Could not save deal (${res.statusCode}).');
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return false;
    } finally {
      isSaving.value = false;
    }
  }

  Future<bool> removeFromWishlist() async {
    if (isSaving.value) return false;
    if (_dealId == null) return false;

    isSaving.value = true;
    try {
      if (wishlistId.value == null) {
        await _checkIfSaved();
      }
      final id = wishlistId.value;
      if (id == null) {
        Get.snackbar('Error', 'Wishlist item not found for this deal.');
        return false;
      }

      final headers = await BaseClient.authHeaders();
      final resp = await http.delete(
        Uri.parse('http://10.10.13.99:8090/vendors/wish-deals/$id/'),
        headers: headers,
      );

      if (resp.statusCode >= 200 && resp.statusCode < 300) {
        isSaved.value = false;
        wishlistId.value = null;
        _notifyMyDealsRefresh();  // 👈 refresh My Deals
        return true;
      } else {
        Get.snackbar('Error', 'Failed to remove (code ${resp.statusCode}).');
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return false;
    } finally {
      isSaving.value = false;
    }
  }

  void _notifyMyDealsRefresh() {
    if (Get.isRegistered<MyDealsController>()) {
      Get.find<MyDealsController>().fetchMyDeals();
    }
  }
}
