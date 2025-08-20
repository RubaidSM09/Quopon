import 'dart:convert';

import 'package:get/get.dart';
import 'package:quopon/app/data/model/menu.dart';

import '../../../data/api.dart';
import '../../../data/base_client.dart';

class Deal {
  final String dealImg;
  final String dealTitle;
  final String dealDescription;
  final String dealValidity;

  Deal({
    required this.dealImg,
    required this.dealTitle,
    required this.dealDescription,
    required this.dealValidity,
  });
}

class VendorProfileController extends GetxController {
  var activeDeals = <Deal>[].obs;
  var menu = <Menu>[].obs;
  // var items = <Item>[].obs;

  Future<void> fetchMenu() async {
    try {
      String? accessToken = await BaseClient.getAccessToken();

      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };

      // Call the API to get the categories
      final response = await BaseClient.getRequest(api: Api.menu, headers: headers);

      // Decode the response body from JSON
      final decodedResponse = json.decode(response.body);
      print(decodedResponse);

      // Check if the response contains categories
      if (decodedResponse != null && decodedResponse is List) {
        // Map the response to Category objects and update the list
        menu.value = decodedResponse
            .map((menuJson) => Menu.fromJson(menuJson))
            .toList();
      } else {
        print('No categories found or incorrect response format.');
      }
    } catch (e) {
      print('Error fetching categories: $e');
      // Handle error appropriately (e.g., show a Snackbar or error message)
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchMenu();

    activeDeals.value = [
      Deal(
        dealImg: 'assets/images/VendorProfile/Coffee.jpg',
        dealTitle: 'Buy 1 Get 1 Free on Any Espresso Beverage',
        dealDescription: 'Buy any espresso drink and get another free, available after 2 PM.',
        dealValidity: 'June 30, 2025',
      ),
      Deal(
        dealImg: 'assets/images/VendorProfile/Tea.png',
        dealTitle: 'Cool Down with 20% Off Cold Brew',
        dealDescription: 'Enjoy 20% off all cold drinks, including Vanilla Sweet Cream & Nitro Brew.',
        dealValidity: 'July 10, 2025',
      ),
      Deal(
        dealImg: 'assets/images/VendorProfile/Tart.png',
        dealTitle: 'Morning Combo: Coffee + Croissant',
        dealDescription: 'Start your day right with a tall brewed coffee and butter croissant.',
        dealValidity: 'June 25, 2025',
      ),
    ];
  }
}
