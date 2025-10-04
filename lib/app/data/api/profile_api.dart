// lib/app/data/api/profile_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quopon/app/data/base_client.dart';
import 'package:quopon/app/data/model/user_profile.dart';

class ProfileApi {
  static const _base = 'https://intensely-optimal-unicorn.ngrok-free.app/food/my-profile/';

  static Future<UserProfile> fetch() async {
    final headers = await BaseClient.authHeaders();
    final res = await http.get(Uri.parse(_base), headers: headers);
    if (res.statusCode >= 200 && res.statusCode < 300) {
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      return UserProfile.fromJson(data);
    }
    throw Exception('Failed to fetch profile (${res.statusCode}) ${res.body}');
  }

  static Future<void> update(UserProfile profile) async {
    final headers = await BaseClient.authHeaders();
    headers['Content-Type'] = 'application/json';
    final res = await http.put(
      Uri.parse(_base),
      headers: headers,
      body: jsonEncode(profile.toJson()),
    );
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('Failed to update profile (${res.statusCode}) ${res.body}');
    }
  }
}
