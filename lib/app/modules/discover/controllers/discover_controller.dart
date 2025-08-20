import 'dart:convert';

import 'package:get/get.dart';
import 'package:quopon/app/data/model/discoverList.dart';

import '../../../data/api.dart';
import '../../../data/base_client.dart';

class DiscoverController extends GetxController {
  RxBool isMap = true.obs;
  RxBool isDelivery = true.obs;

  RxList<RxBool> selectedCuisine = [false.obs, true.obs, false.obs, false.obs, false.obs, false.obs, true.obs, false.obs, false.obs].obs;

  RxList<RxBool> selectedDiet = [false.obs, true.obs, false.obs].obs;

  RxList<RxBool> selectedPrice = [false.obs, true.obs, false.obs].obs;

  RxList<RxBool> selectedRating = [false.obs, false.obs, true.obs, true.obs].obs;

  var discoverList = <DiscoverList>[].obs;

  Future<void> fetchDiscoverList() async {
    try {
      // Call the API to get the categories
      final response = await BaseClient.getRequest(api: Api.discoverList);
      print('Hi!');

      // Decode the response body from JSON
      final decodedResponse = json.decode(response.body);

      // Check if the response contains categories
      if (decodedResponse != null && decodedResponse is List) {
        // Map the response to Category objects and update the list
        discoverList.value = decodedResponse
            .map((discoverListJson) => DiscoverList.fromJson(discoverListJson))
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
    fetchDiscoverList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
