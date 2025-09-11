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
      final headers = await BaseClient.authHeaders();

      // Hit the new vendors endpoint
      final response = await BaseClient.getRequest(
        api: 'http://10.10.13.52:7000/vendors/all-business-profile/',
        headers: headers,
      );

      final decoded = json.decode(response.body);

      if (decoded != null && decoded is List) {
        // Map category ids to display names (tweak as needed)
        String mapCategory(dynamic id) {
          switch (id) {
            case 1:
              return 'Restaurant';
            case 2:
              return 'Grocery';
            default:
              return 'Other';
          }
        }

        // Provide a safe fallback for missing logos
        const placeholderLogo = 'https://via.placeholder.com/120';

        nearShops.value = decoded.map<NearShops>((item) {
          final m = (item as Map<String, dynamic>);

          // Adapt the API shape to whatever NearShops.fromJson expects in your app
          final adapted = <String, dynamic>{
            // Common identifiers (optional, but handy to keep)
            'id': m['id'],
            'vendor_id': m['vendor_id'],
            'vendor_email': m['vendor_email'],

            // Fields your UI uses directly
            'logo_url': m['logo_image'] ?? placeholderLogo,            // -> nearShops.logoUrl
            'name': m['name'] ?? 'Unknown',                            // -> nearShops.name
            'category_name': mapCategory(m['category']),               // -> nearShops.categoryName
            'shop_title': m['name'] ?? 'Unknown',                      // -> nearShops.shopTitle
            'status_text': m['address'] ?? 'Address unavailable',      // -> nearShops.statusText

            // Extras you might want inside the model
            'address': m['address'],
            'phone_number': m['phone_number'],
            'kvk_number': m['kvk_number'],
          };

          return NearShops.fromJson(adapted);
        }).toList();
      } else {
        print('No near shops found or incorrect response format.');
      }
    } catch (e) {
      print('Error fetching near shops: $e');
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
