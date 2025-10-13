// lib/app/data/repo/deals_repo.dart
import 'dart:convert';
import 'package:quopon/app/data/base_client.dart';

class DealBundle {
  final Map<String, dynamic> deal; // the raw deal map
  final String address;            // resolved vendor address ('' if not found)
  final bool userType;             // true if subscription_status == 'Active'

  DealBundle({
    required this.deal,
    required this.address,
    required this.userType,
  });
}

class DealsRepo {
  static String dealByIdUrl(int id) =>
      'https://doctorless-stopperless-turner.ngrok-free.dev/vendors/all-vendor-deals/$id/';
  static String allBusinessProfileUrl =
      'https://doctorless-stopperless-turner.ngrok-free.dev/vendors/all-business-profile/';
  static String myProfileUrl =
      'https://doctorless-stopperless-turner.ngrok-free.dev/food/my-profile/';

  // Optional tiny cache to avoid repeated address lookups during a session
  static final Map<int, String> _addressCacheByVendorId = {};

  static Future<Map<String, dynamic>> fetchDealRawById(int id) async {
    final headers = await BaseClient.authHeaders();
    final res = await BaseClient.getRequest(api: dealByIdUrl(id), headers: headers);

    if (res.statusCode >= 200 && res.statusCode <= 210) {
      return json.decode(res.body) as Map<String, dynamic>;
    } else {
      final body = json.decode(res.body);
      throw body['message'] ?? 'Failed to fetch deal #$id';
    }
  }

  /// Finds the vendor's address by matching business_profile.vendor_id == userId
  static Future<String> fetchVendorAddressByUserId(int userId) async {
    // cache hit?
    if (_addressCacheByVendorId.containsKey(userId)) {
      return _addressCacheByVendorId[userId] ?? '';
    }

    final headers = await BaseClient.authHeaders();
    final res = await BaseClient.getRequest(api: allBusinessProfileUrl, headers: headers);

    if (res.statusCode >= 200 && res.statusCode <= 210) {
      final list = json.decode(res.body);
      if (list is List) {
        for (final item in list) {
          try {
            final vid = int.tryParse(item['vendor_id']?.toString() ?? '');
            if (vid != null && vid == userId) {
              final addr = (item['address'] ?? '').toString();
              _addressCacheByVendorId[userId] = addr;
              return addr;
            }
          } catch (_) {}
        }
      }
      return '';
    } else {
      // On error, just return empty string; dialog will still render
      return '';
    }
  }

  /// Returns true when subscription_status == 'Active' (case-insensitive)
  static Future<bool> fetchUserType() async {
    try {
      final headers = await BaseClient.authHeaders();
      final res = await BaseClient.getRequest(api: myProfileUrl, headers: headers);
      if (res.statusCode >= 200 && res.statusCode <= 210) {
        final m = json.decode(res.body) as Map<String, dynamic>;
        final status = (m['subscription_status'] ?? '').toString().toLowerCase();
        return status == 'active';
      }
    } catch (_) {}
    return false;
  }

  /// Convenience: get deal + vendor address (by user_id) + userType (from my-profile)
  static Future<DealBundle> fetchDealBundle(int dealId) async {
    final deal = await fetchDealRawById(dealId);

    // user_id comes from deal payload
    final userId = int.tryParse(deal['user_id']?.toString() ?? '');
    String address = '';
    if (userId != null) {
      address = await fetchVendorAddressByUserId(userId);
    }

    final userType = await fetchUserType();

    return DealBundle(deal: deal, address: address, userType: userType);
  }
}
