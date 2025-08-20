import 'dart:convert';

import 'package:get/get.dart';

import '../../../data/api.dart';
import '../../../data/base_client.dart';

class FollowedVendor {
  final int id;
  final String title;
  final String category;
  final String logoUrl;
  final int activeDeals;

  FollowedVendor({
    required this.id,
    required this.title,
    required this.category,
    required this.logoUrl,
    this.activeDeals = 3,
  });

  factory FollowedVendor.fromJson(Map<String, dynamic> json) {
    return FollowedVendor(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      logoUrl: json['logo_url'],
    );
  }
}

class FollowVendorsController extends GetxController {
  var followedVendors = <FollowedVendor>[].obs;

  Future<void> fetchFollowedVendors() async {
    try {
      String? accessToken = await BaseClient.getAccessToken();

      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };

      // Call the API to get the categories
      final response = await BaseClient.getRequest(api: Api.followedVendors, headers: headers,);

      // Decode the response body from JSON
      final decodedResponse = json.decode(response.body);
      print(decodedResponse);

      // Check if the response contains categories
      if (decodedResponse != null && decodedResponse is List) {
        // Map the response to Category objects and update the list
        followedVendors.value = decodedResponse
            .map((followedVendorsJson) => FollowedVendor.fromJson(followedVendorsJson))
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
    fetchFollowedVendors();
  }
}
