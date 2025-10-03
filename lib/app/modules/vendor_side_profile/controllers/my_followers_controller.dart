// lib/app/modules/vendor_side_profile/controllers/my_followers_controller.dart
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quopon/app/data/base_client.dart';

class Follower {
  final String followersProfilePic; // asset or URL (we pass asset placeholder)
  final String followerName;        // email for now (fallback), name later if provided
  final int redeemedDeals;          // not provided by API -> 0 for now
  final int pushOpens;              // not provided by API -> 0 for now

  Follower({
    required this.followersProfilePic,
    required this.followerName,
    required this.redeemedDeals,
    required this.pushOpens,
  });

  /// Helper to build from API map, using email as name for now.
  factory Follower.fromApi(Map<String, dynamic> m) {
    final email = (m['email'] ?? '').toString();
    final nameFromApi = (m['name'] ?? '').toString(); // future-proof if BE adds it
    return Follower(
      followersProfilePic: 'assets/images/Profile/Vendors/My Followers Profile Pic.png',
      followerName: nameFromApi.isNotEmpty ? nameFromApi : email,
      redeemedDeals: 0,
      pushOpens: 0,
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
