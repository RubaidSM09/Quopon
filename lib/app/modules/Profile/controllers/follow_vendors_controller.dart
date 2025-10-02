import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/api.dart';
import '../../../data/base_client.dart';

class FollowedVendor {
  final int id;                 // follow row id
  final int vendorId;           // vendor_id
  final String vendorEmail;
  final String name;
  final String? logoImage;      // logo_image (nullable)
  final String kvkNumber;
  final String phoneNumber;
  final String address;
  final int? category;          // category id

  FollowedVendor({
    required this.id,
    required this.vendorId,
    required this.vendorEmail,
    required this.name,
    required this.logoImage,
    required this.kvkNumber,
    required this.phoneNumber,
    required this.address,
    required this.category,
  });

  factory FollowedVendor.fromJson(Map<String, dynamic> json) => FollowedVendor(
    id: json['id'] as int,
    vendorId: json['vendor_id'] as int,
    vendorEmail: (json['vendor_email'] ?? '').toString(),
    name: (json['name'] ?? '').toString(),
    logoImage: (json['logo_image'] ?? '').toString().trim().isEmpty
        ? null
        : (json['logo_image'] as String),
    kvkNumber: (json['kvk_number'] ?? '').toString(),
    phoneNumber: (json['phone_number'] ?? '').toString(),
    address: (json['address'] ?? '').toString(),
    category: json['category'] is int ? json['category'] as int : int.tryParse('${json['category']}'),
  );
}

class FollowVendorsController extends GetxController {
  var followedVendors = <FollowedVendor>[].obs;

  Future<void> fetchFollowedVendors() async {
    try {
      final headers = await BaseClient.authHeaders();
      final res = await BaseClient.getRequest(api: Api.followedVendors, headers: headers);
      final decoded = json.decode(res.body);

      if (res.statusCode >= 200 && res.statusCode < 300 && decoded is List) {
        followedVendors.value = decoded
            .map<FollowedVendor>((e) => FollowedVendor.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        debugPrint('Unexpected response for followed vendors: ${res.statusCode} $decoded');
        followedVendors.clear();
      }
    } catch (e) {
      debugPrint('Error fetching followed vendors: $e');
      followedVendors.clear();
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchFollowedVendors();
  }
}
