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

  final isAdding = false.obs;
  final _busyItemIds = <int>{}.obs;

  // 🔹 dealId -> vendorUserId (or null if unknown)
  final RxMap<int, int?> _dealToVendor = <int, int?>{}.obs;

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

      final response = await BaseClient.getRequest(api: Api.cart, headers: headers);
      final decoded = json.decode(response.body);

      if (decoded is List) {
        cart.value = decoded.map<Cart>((e) => Cart.fromJson(e)).toList();
      } else if (decoded is Map<String, dynamic>) {
        cart.value = [Cart.fromJson(decoded)];
      } else {
        cart.clear();
      }
    } catch (_) {
      cart.clear();
    }
  }

  // ---------- NEW: build (or refresh) deal -> vendor index ----------
  Future<void> _ensureDealVendorIndex() async {
    // If we already have entries for the deals in cart, you can skip refresh.
    // To be safe/simple: refresh the whole list now.
    try {
      final token = await BaseClient.getAccessToken();
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'ngrok-skip-browser-warning': 'true',
      };

      final res = await http.get(Uri.parse(Api.deals), headers: headers);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final List<dynamic> list = jsonDecode(res.body);
        // Fill map: deal.id -> user_id (or null)
        for (final e in list) {
          if (e is Map<String, dynamic>) {
            final dealId = e['id'] as int?;
            final userId = (e['user_id'] ?? e['user']) as int?;
            if (dealId != null) {
              _dealToVendor[dealId] = userId;
            }
          }
        }
      } else {
        // If fetch fails, keep old map (if any)
        Get.snackbar('Error', 'Failed to fetch deals (${res.statusCode})');
      }
    } catch (e) {
      Get.snackbar('Network', 'Failed to fetch deals: $e');
    }
  }

  /// Resolves a single vendorId for the current cart.
  /// Returns null if not found or if multiple vendors are present.
  Future<int?> resolveVendorIdFromCart() async {
    final c = currentCart;
    if (c == null || c.items.isEmpty) return null;

    // Make sure we have the index
    await _ensureDealVendorIndex();

    // Collect vendorIds for all items in the cart (skip nulls)
    final vendorIds = <int>{};
    for (final it in c.items) {
      final v = _dealToVendor[it.dealId];
      if (v != null) vendorIds.add(v);
    }

    if (vendorIds.isEmpty) {
      // Couldn’t map any item → vendor, possibly because deal list is stale or user=null
      return null;
    }

    if (vendorIds.length > 1) {
      // Cart has items from multiple vendors — decide your business rule.
      // For now, block checkout and ask user to split carts.
      Get.snackbar('Multiple vendors',
          'Your cart contains items from multiple vendors. Please checkout per vendor.');
      return null;
    }

    return vendorIds.first;
  }

  // ----- existing add/remove/increment/decrement unchanged -----
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
          'http://10.10.13.99:8090/order/cart/add/'); // use https

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
        Get.snackbar('Error', 'Add to cart failed (${res.statusCode})\n${res.body}');
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
          'http://10.10.13.99:8090/order/cart/item/$itemId/delete/');

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
          'http://10.10.13.99:8090/order/cart/item/$itemId/increment/');

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
          'http://10.10.13.99:8090/order/cart/item/$itemId/decrement/');

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
