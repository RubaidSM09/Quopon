// To parse this JSON data, do
//
//     final businessProfile = businessProfileFromJson(jsonString);

import 'dart:convert';

BusinessProfile businessProfileFromJson(String str) => BusinessProfile.fromJson(json.decode(str));

String businessProfileToJson(BusinessProfile data) => json.encode(data.toJson());

class BusinessProfile {
  String message;
  Data data;

  BusinessProfile({
    required this.message,
    required this.data,
  });

  factory BusinessProfile.fromJson(Map<String, dynamic> json) => BusinessProfile(
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  int id;
  String name;
  dynamic logoImage;
  String kvkNumber;
  String phoneNumber;
  String address;
  dynamic category;

  Data({
    required this.id,
    required this.name,
    required this.logoImage,
    required this.kvkNumber,
    required this.phoneNumber,
    required this.address,
    required this.category,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    logoImage: json["logo_image"],
    kvkNumber: json["kvk_number"],
    phoneNumber: json["phone_number"],
    address: json["address"],
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "logo_image": logoImage,
    "kvk_number": kvkNumber,
    "phone_number": phoneNumber,
    "address": address,
    "category": category,
  };
}
