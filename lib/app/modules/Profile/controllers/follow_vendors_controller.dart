import 'dart:convert';

import 'package:get/get.dart';

import '../../../data/api.dart';
import '../../../data/base_client.dart';

class FollowedVendor {
  int id;
  int menuCategory;
  String title;
  String category;
  String logoUrl;
  bool isFollowed;
  String descriptions;
  DateTime expiryDate;

  FollowedVendor({
    required this.id,
    required this.menuCategory,
    required this.title,
    required this.category,
    required this.logoUrl,
    required this.isFollowed,
    required this.descriptions,
    required this.expiryDate,
  });

  factory FollowedVendor.fromJson(Map<String, dynamic> json) => FollowedVendor(
    id: json["id"],
    menuCategory: json["menu_category"],
    title: json["title"],
    category: json["category"],
    logoUrl: json["logo_url"],
    isFollowed: json["is_followed"],
    descriptions: json["descriptions"],
    expiryDate: DateTime.parse(json["expiry_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "menu_category": menuCategory,
    "title": title,
    "category": category,
    "logo_url": logoUrl,
    "is_followed": isFollowed,
    "descriptions": descriptions,
    "expiry_date": expiryDate.toIso8601String(),
  };
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
