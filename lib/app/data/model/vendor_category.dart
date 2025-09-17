// To parse the JSON data, do
//
//     final vendorCategoryList = vendorCategoryFromJson(jsonString);

import 'dart:convert';

List<VendorCategory> vendorCategoryFromJson(List<dynamic> data) =>
    List<VendorCategory>.from(data.map((x) => VendorCategory.fromJson(x)));

String vendorCategoryToJson(List<VendorCategory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VendorCategory {
  int id;
  String categoryTitle;
  String imageUrl;

  VendorCategory({
    required this.id,
    required this.categoryTitle,
    required this.imageUrl,
  });

  factory VendorCategory.fromJson(Map<String, dynamic> json) => VendorCategory(
    id: json["id"],
    categoryTitle: json["name"],
    imageUrl: json["logo_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": categoryTitle,
    "logo_image": imageUrl
  };
}