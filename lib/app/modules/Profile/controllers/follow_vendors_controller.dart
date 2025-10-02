import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/api.dart';
import '../../../data/base_client.dart';

class FollowedVendor {
  final int id;
  final String vendorEmail;
  final int vendorId;
  final String name;
  final String logoImage;   // URL
  final String kvkNumber;
  final String phoneNumber;
  final String address;
  final int category;       // category id

  FollowedVendor({
    required this.id,
    required this.vendorEmail,
    required this.vendorId,
    required this.name,
    required this.logoImage,
    required this.kvkNumber,
    required this.phoneNumber,
    required this.address,
    required this.category,
  });

  factory FollowedVendor.fromJson(Map<String, dynamic> j) => FollowedVendor(
    id: j['id'] ?? 0,
    vendorEmail: (j['vendor_email'] ?? '').toString(),
    vendorId: j['vendor_id'] ?? 0,
    name: (j['name'] ?? '').toString(),
    logoImage: (j['logo_image'] ?? '').toString(),
    kvkNumber: (j['kvk_number'] ?? '').toString(),
    phoneNumber: (j['phone_number'] ?? '').toString(),
    address: (j['address'] ?? '').toString(),
    category: j['category'] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'vendor_email': vendorEmail,
    'vendor_id': vendorId,
    'name': name,
    'logo_image': logoImage,
    'kvk_number': kvkNumber,
    'phone_number': phoneNumber,
    'address': address,
    'category': category,
  };
}

class FollowVendorsController extends GetxController {
  final isLoading = false.obs;
  final error = RxnString();
  final followedVendors = <FollowedVendor>[].obs;

  Future<void> fetchFollowedVendors() async {
    try {
      isLoading.value = true;
      error.value = null;

      final headers = await BaseClient.authHeaders(); // includes Bearer + JSON
      final res = await BaseClient.getRequest(
        api: Api.followedVendors, // should point to /vendors/customers/followed-vendors/
        headers: headers,
      );

      if (res.statusCode < 200 || res.statusCode >= 300) {
        error.value =
        'Failed to load followed vendors (${res.statusCode}).';
        followedVendors.clear();
        debugPrint('followed-vendors error: ${res.statusCode} ${res.body}');
        return;
      }

      final body = json.decode(res.body);
      if (body is List) {
        followedVendors.assignAll(
          body.map<FollowedVendor>((e) => FollowedVendor.fromJson(e)).toList(),
        );
      } else {
        error.value = 'Unexpected response format.';
        followedVendors.clear();
      }
    } catch (e) {
      print(e.toString());
      error.value = 'Network error while loading followed vendors.';
      followedVendors.clear();
      debugPrint('fetchFollowedVendors error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchFollowedVendors();
  }
}
