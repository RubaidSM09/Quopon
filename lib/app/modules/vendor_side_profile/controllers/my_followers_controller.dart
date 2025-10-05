// lib/app/modules/vendor_side_profile/controllers/my_followers_controller.dart
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quopon/app/data/base_client.dart';

class Follower {
  // ---- UI-needed fields (kept same names so your FollowersCard keeps working)
  final String followersProfilePic; // URL if provided, else asset placeholder
  final String followerName;        // full_name -> fallback to email
  final int redeemedDeals;          // not in API -> 0 for now
  final int pushOpens;              // not in API -> 0 for now

  // ---- Extra fields from API (useful for future)
  final String email;
  final String phoneNumber;
  final String language;
  final String country;
  final String city;
  final String address;
  final String subscriptionStatus;

  Follower({
    required this.followersProfilePic,
    required this.followerName,
    required this.redeemedDeals,
    required this.pushOpens,
    required this.email,
    required this.phoneNumber,
    required this.language,
    required this.country,
    required this.city,
    required this.address,
    required this.subscriptionStatus,
  });

  factory Follower.fromApi(Map<String, dynamic> m) {
    final email = (m['email'] ?? '').toString().trim();
    final fullName = (m['full_name'] ?? '').toString().trim();
    final profileUrl = (m['profile_picture_url'] ?? '').toString().trim();

    // If BE returns a Cloudinary URL without extension, it's still fine as a NetworkImage URL.
    final pic = profileUrl.isNotEmpty
        ? profileUrl
        : 'assets/images/Profile/Vendors/My Followers Profile Pic.png';

    return Follower(
      followersProfilePic: pic,
      followerName: fullName.isNotEmpty ? fullName : email,
      redeemedDeals: 0,
      pushOpens: 0,
      email: email,
      phoneNumber: (m['phone_number'] ?? '').toString(),
      language: (m['language'] ?? '').toString(),
      country: (m['country'] ?? '').toString(),
      city: (m['city'] ?? '').toString(),
      address: (m['address'] ?? '').toString(),
      subscriptionStatus: (m['subscription_status'] ?? '').toString(),
    );
  }
}

class MyFollowersController extends GetxController {
  final followerList = <Follower>[].obs;
  final isLoading = false.obs;
  final error = RxnString();

  Future<void> fetchFollowers() async {
    try {
      isLoading.value = true;
      error.value = null;

      final headers = await BaseClient.authHeaders();
      final uri = Uri.parse(
        'https://intensely-optimal-unicorn.ngrok-free.app/vendors/vendors/followers/',
      );
      final res = await http.get(uri, headers: headers);

      if (res.statusCode < 200 || res.statusCode >= 300) {
        error.value = 'Failed to load followers (${res.statusCode})';
        followerList.clear();
        debugPrint('followers error: ${res.statusCode} ${res.body}');
        return;
      }

      final body = json.decode(res.body);
      if (body is List) {
        final items = <Follower>[];
        for (final e in body) {
          if (e is Map<String, dynamic>) {
            items.add(Follower.fromApi(e));
          }
        }
        followerList.assignAll(items);
      } else {
        error.value = 'Unexpected response format.';
        followerList.clear();
      }
    } catch (e) {
      error.value = 'Network error while loading followers.';
      followerList.clear();
      debugPrint('fetchFollowers error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchFollowers();
  }
}
