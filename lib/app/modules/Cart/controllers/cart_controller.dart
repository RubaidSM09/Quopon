// lib/app/modules/Cart/controllers/cart_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../../../data/model/cart.dart';

class CartController extends GetxController {
  var cart = <Cart>[].obs;

  RxBool isDelivery = false.obs;

  Cart? get currentCart => cart.isNotEmpty ? cart.first : null;

  // Optional: to guard against double-taps on "Add to cart"
  final isAdding = false.obs;

  // Optional: guard for item actions (by id)
  final _busyItemIds = <int>{}.obs;

  bool _markBusy(int id) {
    if (_busyItemIds.contains(id)) return false;
    _busyItemIds.add(id);
    return true;
  }

  void _unmarkBusy(int id) => _busyItemIds.remove(id);

  @override
  void onInit() {
    super.onInit();
    fetchCart();
  }

  Future<void> fetchCart() async {
    try {
      final accessToken = await BaseClient.getAccessToken();
      final headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
        'ngrok-skip-browser-warning': 'true',
      };

      final response =
      await BaseClient.getRequest(api: Api.cart, headers: headers);
      final decoded = json.decode(response.body);

      if (decoded is List) {
        cart.value = decoded.map<Cart>((e) => Cart.fromJson(e)).toList();
      } else if (decoded is Map<String, dynamic>) {
        cart.value = [Cart.fromJson(decoded)];
      } else {
        cart.clear();
      }
    } catch (e) {
      cart.clear();
    }
  }

  Future<bool> addToCart({
    required int menuItemId,
    int quantity = 1,
    String specialInstructions = '',
  }) async {
    if (isAdding.value) return false;
    isAdding.value = true;

    try {
      final accessToken = await BaseClient.getAccessToken();
      final headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
        'ngrok-skip-browser-warning': 'true',
      };

      final uri = Uri.parse(
          'http://intensely-optimal-unicorn.ngrok-free.app/order/cart/add/');

      final body = {
        'menu_item_id': menuItemId,
        'quantity': quantity,
        'special_instructions': specialInstructions,
      };

      final res = await http
          .post(uri, headers: headers, body: jsonEncode(body))
          .timeout(const Duration(seconds: 20));

      if (res.statusCode >= 200 && res.statusCode < 300) {
        await fetchCart();
        Get.snackbar('Success', 'Item added to cart');
        return true;
      } else {
        Get.snackbar(
            'Error', 'Add to cart failed (${res.statusCode})\n${res.body}');
        return false;
      }
    } catch (e) {
      Get.snackbar('Network', 'Add to cart failed: $e');
      return false;
    } finally {
      isAdding.value = false;
    }
  }

  // ---------- NEW: item actions ----------

  Future<bool> removeItem(int itemId) async {
    if (!_markBusy(itemId)) return false;
    try {
      final token = await BaseClient.getAccessToken();
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'ngrok-skip-browser-warning': 'true',
      };

      final uri = Uri.parse(
          'https://intensely-optimal-unicorn.ngrok-free.app/order/cart/item/$itemId/delete/');

      final res = await http.delete(uri, headers: headers);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        await fetchCart();
        return true;
      } else {
        Get.snackbar('Error',
            'Remove failed (${res.statusCode})\n${res.body}');
        return false;
      }
    } catch (e) {
      Get.snackbar('Network', 'Remove failed: $e');
      return false;
    } finally {
      _unmarkBusy(itemId);
    }
  }

  Future<bool> incrementItem(int itemId) async {
    if (!_markBusy(itemId)) return false;
    try {
      final token = await BaseClient.getAccessToken();
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'ngrok-skip-browser-warning': 'true',
      };

      final uri = Uri.parse(
          'https://intensely-optimal-unicorn.ngrok-free.app/order/cart/item/$itemId/increment/');

      final res = await http.post(uri, headers: headers);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        await fetchCart();
        return true;
      } else {
        Get.snackbar('Error',
            'Increment failed (${res.statusCode})\n${res.body}');
        return false;
      }
    } catch (e) {
      Get.snackbar('Network', 'Increment failed: $e');
      return false;
    } finally {
      _unmarkBusy(itemId);
    }
  }

  Future<bool> decrementItem(int itemId) async {
    if (!_markBusy(itemId)) return false;
    try {
      final token = await BaseClient.getAccessToken();
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'ngrok-skip-browser-warning': 'true',
      };

      final uri = Uri.parse(
          'https://intensely-optimal-unicorn.ngrok-free.app/order/cart/item/$itemId/decrement/');

      final res = await http.post(uri, headers: headers);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        await fetchCart();
        return true;
      } else {
        Get.snackbar('Error',
            'Decrement failed (${res.statusCode})\n${res.body}');
        return false;
      }
    } catch (e) {
      Get.snackbar('Network', 'Decrement failed: $e');
      return false;
    } finally {
      _unmarkBusy(itemId);
    }
  }
}
