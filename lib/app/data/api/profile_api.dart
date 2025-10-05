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

  // keep this if you still use PUT elsewhere
  static Future<void> update(UserProfile profile) async {
    final headers = await BaseClient.authHeaders();
    headers['Content-Type'] = 'application/json';
    final res = await http.patch(
      Uri.parse(_base),
      headers: headers,
      body: jsonEncode(profile.toJson()),
    );
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('Failed to update profile (${res.statusCode}) ${res.body}');
    }
  }

  /// ✅ New: partial update, send only the keys you want
  static Future<void> patchRaw(Map<String, dynamic> body) async {
    final headers = await BaseClient.authHeaders();
    headers['Content-Type'] = 'application/json';
    final res = await http.patch(
      Uri.parse(_base),
      headers: headers,
      body: jsonEncode(body),
    );
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('Failed to patch profile (${res.statusCode}) ${res.body}');
    }
  }
}


class VendorProfileApi {
  // FETCH (GET) – your existing fetch endpoint
  static const _fetchUrl = 'https://intensely-optimal-unicorn.ngrok-free.app/vendors/business-profile/';
  // UPDATE (PATCH) – as you requested (note: “businessh” in path per your API)
  static const _patchUrl = 'https://intensely-optimal-unicorn.ngrok-free.app/vendors/businessh-profile/manage/';

  static Future<VendorBusinessProfile> fetch() async {
    final headers = await BaseClient.authHeaders();
    final res = await http.get(Uri.parse(_fetchUrl), headers: headers);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final body = jsonDecode(res.body);
      if (body is List) {
        return VendorBusinessProfile.fromJson(body.isNotEmpty ? body.first : <String, dynamic>{});
      }
      if (body is Map<String, dynamic>) {
        return VendorBusinessProfile.fromJson(body);
      }
      throw Exception('Unexpected response format');
    }
    throw Exception('Failed to fetch vendor profile (${res.statusCode}) ${res.body}');
  }

  static Future<void> patch(VendorBusinessProfile profile) async {
    final headers = await BaseClient.authHeaders();
    headers['Content-Type'] = 'application/json';

    print(jsonEncode(profile.toPatchJson()));

    final res = await http.patch(
      Uri.parse(_patchUrl),
      headers: headers,
      body: jsonEncode(profile.toPatchJson()), // no {"data": ...} wrapper
    );

    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('Failed to update vendor profile (${res.statusCode}) ${res.body}');
    }
  }

  static Future<void> patchRaw(Map<String, dynamic> body) async {
    final headers = await BaseClient.authHeaders();
    headers['Content-Type'] = 'application/json';
    final res = await http.patch(Uri.parse(_patchUrl), headers: headers, body: jsonEncode(body));
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('Failed to update vendor profile (${res.statusCode}) ${res.body}');
    }
  }
}


class VendorBusinessProfile {
  final int id;
  final String vendorEmail;
  final int vendorId;
  final String name;
  final String? logoImage; // keep nullable
  final String kvkNumber;
  final String phoneNumber;
  final String address;
  final int category; // category id

  VendorBusinessProfile({
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

  factory VendorBusinessProfile.fromJson(Map<String, dynamic> j) {
    return VendorBusinessProfile(
      id: j['id'] ?? 0,
      vendorEmail: (j['vendor_email'] ?? '').toString(),
      vendorId: j['vendor_id'] ?? 0,
      name: (j['name'] ?? '').toString(),
      logoImage: j['logo_image']?.toString(),
      kvkNumber: (j['kvk_number'] ?? '').toString(),
      phoneNumber: (j['phone_number'] ?? '').toString(),
      address: (j['address'] ?? '').toString(),
      category: j['category'] is int ? j['category'] : int.tryParse('${j['category']}') ?? 0,
    );
  }

  /// Only keys that the API actually updates.
  Map<String, dynamic> toPatchJson() {
    final m = <String, dynamic>{
      'name': name,
      'kvk_number': kvkNumber,
      'phone_number': phoneNumber,
      'address': address,
      'category': category,
    };
    // ✅ only send when we have a non-empty URL (prevents accidental clearing)
    if (logoImage != null && logoImage!.trim().isNotEmpty) {
      m['logo'] = logoImage!.trim();
    }
    return m;
  }
}
