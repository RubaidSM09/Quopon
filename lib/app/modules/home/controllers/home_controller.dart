import 'dart:convert';

import 'package:get/get.dart';
import 'package:quopon/app/data/base_client.dart';
import 'package:quopon/app/data/model/beyondNeighbourhood.dart';
import 'package:quopon/app/data/model/nearShops.dart';
import 'package:quopon/app/data/model/speedyDeliveries.dart';

import '../../../data/api.dart';

class HomeController extends GetxController {
  RxBool deliveryHighToLow = true.obs;

  // Reactive list to store categories
  var categories = <Category>[].obs;
  var beyondNeighbourhood = <BeyondNeighbourhood>[].obs;
  var nearShops = <NearShops>[].obs;
  var speedyDeliveries = <SpeedyDeliveries>[].obs;

  // Fetch categories from the API
  Future<void> fetchCategories() async {
    try {
      // Call the API to get the categories
      final response = await BaseClient.getRequest(api: Api.categories);

      // Decode the response body from JSON
      final decodedResponse = json.decode(response.body);

      // Check if the response contains categories
      if (decodedResponse != null && decodedResponse is List) {
        // Map the response to Category objects and update the list
        categories.value = decodedResponse
            .map((categoryJson) => Category.fromJson(categoryJson))
            .toList();
      } else {
        print('No categories found or incorrect response format.');
      }
    } catch (e) {
      print('Error fetching categories: $e');
      // Handle error appropriately (e.g., show a Snackbar or error message)
    }
  }

  // Fetch categories from the API
  Future<void> fetchBeyondNeighbourhood() async {
    try {
      // Call the API to get the categories
      final response = await BaseClient.getRequest(api: Api.beyondNeighbourhood, );

      // Decode the response body from JSON
      final decodedResponse = json.decode(response.body);

      // Check if the response contains categories
      if (decodedResponse != null && decodedResponse is List) {
        // Map the response to Category objects and update the list
        beyondNeighbourhood.value = decodedResponse
            .map((beyondNeighbourhoodJson) => BeyondNeighbourhood.fromJson(beyondNeighbourhoodJson))
            .toList();
      } else {
        print('No categories found or incorrect response format.');
      }
    } catch (e) {
      print('Error fetching categories: $e');
      // Handle error appropriately (e.g., show a Snackbar or error message)
    }
  }

  Future<void> fetchNearShops() async {
    try {
      // Call the API to get the categories
      final response = await BaseClient.getRequest(api: Api.searchByCategories, );

      // Decode the response body from JSON
      final decodedResponse = json.decode(response.body);

      // Check if the response contains categories
      if (decodedResponse != null && decodedResponse is List) {
        // Map the response to Category objects and update the list
        print(decodedResponse);
        nearShops.value = decodedResponse
            .map((nearShopsJson) => NearShops.fromJson(nearShopsJson))
            .toList();
      } else {
        print('No categories found or incorrect response format.');
      }
    } catch (e) {
      print('Error fetching categories: $e');
      // Handle error appropriately (e.g., show a Snackbar or error message)
    }
  }

  Future<void> fetchSpeedyDeliveries() async {
    try {
      // Call the API to get the categories
      final response = await BaseClient.getRequest(api: Api.speedyDeliveries, );

      // Decode the response body from JSON
      final decodedResponse = json.decode(response.body);

      // Check if the response contains categories
      if (decodedResponse != null && decodedResponse is List) {
        // Map the response to Category objects and update the list
        speedyDeliveries.value = decodedResponse
            .map((speedyDeliveriesJson) => SpeedyDeliveries.fromJson(speedyDeliveriesJson))
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
    fetchCategories();  // Call the API to fetch categories on controller init
    fetchBeyondNeighbourhood();
    fetchNearShops();
    fetchSpeedyDeliveries();
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

class Category {
  final int id;
  final String name;
  final String imageUrl;

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  // Factory constructor to create a Category object from JSON response
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
    );
  }
}
