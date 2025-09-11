import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../../../data/model/cart.dart';

class CartController extends GetxController {
  var cart = <Cart>[].obs;

  RxBool isDelivery = false.obs;

  Cart? get currentCart => cart.isNotEmpty ? cart.first : null;

  @override
  void onInit() {
    super.onInit();
    fetchCart(); // actually load data
  }

  Future<void> fetchCart() async {
    try {
      final accessToken = await BaseClient.getAccessToken();
      final headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };

      final response = await BaseClient.getRequest(api: Api.cart, headers: headers);
      final decoded = json.decode(response.body);

      if (decoded is List) {
        cart.value = decoded.map<Cart>((e) => Cart.fromJson(e)).toList();
      } else if (decoded is Map<String, dynamic>) {
        // If your API returns a single cart object:
        cart.value = [Cart.fromJson(decoded)];
      } else {
        cart.clear();
      }
    } catch (e) {
      print('Error fetching cart: $e');
      cart.clear();
    }
  }
}