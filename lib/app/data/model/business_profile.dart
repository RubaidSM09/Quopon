// lib/app/data/model/business_profile.dart
// Vendor-centric model compatible with DiscoverController

import 'dart:convert';

/// Parse a JSON array (from /vendors/all-business-profile/) into a List<BusinessProfile>
List<BusinessProfile> businessProfileListFromJson(String str) =>
    (json.decode(str) as List)
        .map((e) => BusinessProfile.fromJson(e as Map<String, dynamic>))
        .toList();

/// Encode a List<BusinessProfile> back to JSON (rarely needed on client)
String businessProfileListToJson(List<BusinessProfile> data) =>
    json.encode(data.map((e) => e.toJson()).toList());

class BusinessProfile {
  final int id;

  // The API sometimes includes these; keep them nullable for safety.
  final String? vendorEmail;
  final int? vendorId;

  final String name;
  final String? logoImage;
  final String kvkNumber;
  final String phoneNumber;
  final String address;
  final int? category;

  /// Client-side geocoded coordinates (API doesn’t send these yet)
  final double? lat;
  final double? lng;

  const BusinessProfile({
    required this.id,
    required this.name,
    required this.logoImage,
    required this.kvkNumber,
    required this.phoneNumber,
    required this.address,
    this.category,
    this.vendorEmail,
    this.vendorId,
    this.lat,
    this.lng,
  });

  /// Handy for setting lat/lng after geocoding (and any other partial updates)
  BusinessProfile copyWith({
    int? id,
    String? vendorEmail,
    int? vendorId,
    String? name,
    String? logoImage,
    String? kvkNumber,
    String? phoneNumber,
    String? address,
    int? category,
    double? lat,
    double? lng,
  }) {
    return BusinessProfile(
      id: id ?? this.id,
      vendorEmail: vendorEmail ?? this.vendorEmail,
      vendorId: vendorId ?? this.vendorId,
      name: name ?? this.name,
      logoImage: logoImage ?? this.logoImage,
      kvkNumber: kvkNumber ?? this.kvkNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      category: category ?? this.category,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  bool get hasCoords => lat != null && lng != null;

  factory BusinessProfile.fromJson(Map<String, dynamic> json) {
    return BusinessProfile(
      id: json['id'] as int,
      vendorEmail: (json['vendor_email'] ?? json['vendorEmail'])?.toString(),
      vendorId: json['vendor_id'] is int ? json['vendor_id'] as int : (json['vendorId'] as int?),
      name: (json['name'] ?? '').toString(),
      logoImage: json['logo_image'] as String?,
      kvkNumber: (json['kvk_number'] ?? '').toString(),
      phoneNumber: (json['phone_number'] ?? '').toString(),
      address: (json['address'] ?? '').toString(),
      category: json['category'] is int ? json['category'] as int : null,

      // If backend later returns lat/lng, we’ll pick them up; otherwise null.
      lat: (json['lat'] is num) ? (json['lat'] as num).toDouble() : null,
      lng: (json['lng'] is num) ? (json['lng'] as num).toDouble() : null,
    );
  }

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
    'lat': lat,
    'lng': lng,
  };
}
