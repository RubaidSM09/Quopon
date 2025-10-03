import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/base_client.dart';

class AddOnOptions {
  final String title;
  final double? price;
  final String? checkBoxType;
  late final bool? checked;

  AddOnOptions({
    required this.title,
    this.price = 0.0,
    this.checkBoxType = "Circle",
    this.checked = false,
  });
}

class AddOn {
  final String addOnTitle;
  final bool addOnType;
  final List<AddOnOptions> addOnOptions;

  AddOn({
    required this.addOnTitle,
    this.addOnType = true,
    required this.addOnOptions
  });
}

class ProductDetailsController extends GetxController {
  var itemAddOns = <AddOn>[].obs;
  RxDouble total_price = 0.0.obs;

  @override
  void onInit() {
    super.onInit();

    /*itemAddOns.value = [
      AddOn(
        addOnTitle: 'Select Your Bread',
        addOnOptions: [
          AddOnOptions(
            title: 'Classic Wheat Roll',
            price: 4.10,
          ),
          AddOnOptions(
            title: 'Classic Wheat Roll',
            price: 4.10,
          ),
          AddOnOptions(
            title: 'Shorti Roll',
            price: 2.20,
          ),
          AddOnOptions(
            title: 'Shorti Wheat Roll',
            price: 2.20,
          ),
          AddOnOptions(
            title: 'Junior Roll',
          ),
          AddOnOptions(
            title: 'Junior Shorti Roll',
          ),
        ]
      ),
      AddOn(
          addOnTitle: 'Select Your Toasting Options',
          addOnOptions: [
            AddOnOptions(
              title: 'Toast Whole Hoagie or Sandwich',
            ),
            AddOnOptions(
              title: 'Not Toasted',
            ),
          ]
      ),
      AddOn(
          addOnTitle: 'Select Your Cheese',
          addOnOptions: [
            AddOnOptions(
              title: 'Pepper Jack',
            ),
            AddOnOptions(
              title: 'American',
            ),
            AddOnOptions(
              title: 'Cheddar',
            ),
            AddOnOptions(
              title: 'No Cheese',
            ),
            AddOnOptions(
              title: 'Provolone',
            ),
            AddOnOptions(
              title: 'Cheddar Cheese Sauce',
            ),
          ]
      ),
    ];*/
  }

  /// Add to Cart API
  Future<bool> addToCart({
    required int menuItemId,
    int quantity = 1,
    String? specialInstructions,
  }) async {
    try {
      final headers = await BaseClient.authHeaders();

      final body = jsonEncode({
        "menu_item_id": menuItemId,
        "quantity": quantity,
        "special_instructions": specialInstructions,
      });

      final uri = Uri.parse(
          "https://intensely-optimal-unicorn.ngrok-free.app/order/cart/add/");
      print(uri);
      print(body);
      print(headers);
      final res = await http.post(uri, headers: headers, body: body);
      print(res.statusCode);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        Get.snackbar("Cart", "Item added successfully");
        return true;
      } else {
        Get.snackbar("Error", "Failed to add item (${res.statusCode})");
        return false;
      }
    } catch (e) {
      Get.snackbar("Network", "Add to cart failed: $e");
      return false;
    }
  }
}
