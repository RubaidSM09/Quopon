import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:quopon/app/data/base_client.dart';
import 'package:quopon/app/data/model/beyondNeighbourhood.dart';
import 'package:quopon/app/data/model/nearShops.dart';
import 'package:quopon/app/data/model/speedyDeliveries.dart';

import '../../../data/api.dart';
import '../../../data/model/vendor_category.dart';

class HomeController extends GetxController {
  RxBool deliveryHighToLow = true.obs;

  final double _nearRadiusKm = 5.0;                 // radius for "Shops Near You"
  final int _nearLimit = 20;                        // cap list if many results
  final Map<String, LatLng> _geoCache = {};         // address -> coords

  // Reactive list to store categories
  RxList<VendorCategory> vendorCategories = <VendorCategory>[].obs;
  var beyondNeighbourhood = <BeyondNeighbourhood>[].obs;
  var nearShops = <NearShops>[].obs;
  var speedyDeliveries = <SpeedyDeliveries>[].obs;

  // Fetch categories from the API
  Future<void> fetchVendorCategories() async {
    try {
      String? userId = await BaseClient.getUserId();

      if (userId == null) {
        throw "User ID not found. Please log in again.";
      }

      final apiUrl = 'https://intensely-optimal-unicorn.ngrok-free.app/vendors/vendor-categories/';
      final headers = await BaseClient.authHeaders();

      final response = await BaseClient.getRequest(api: apiUrl, headers: headers);

      if (response.statusCode >= 200 && response.statusCode <= 210) {
        final responseBody = json.decode(response.body);

        print(responseBody);

        List<VendorCategory> categories = vendorCategoryFromJson(responseBody);

        vendorCategories.value = categories;

        print(vendorCategories.value);
      } else {
        final responseBody = json.decode(response.body);
        throw responseBody['message'] ?? 'Failed to fetch vendor categories';
      }
    } catch (error) {
      print('Error ${error.toString()}');
      Get.snackbar('Error', error.toString());
    }
  }

  // Fetch categories from the API
  Future<void> fetchBeyondNeighbourhood() async {
    try {
      final headers = await BaseClient.authHeaders();

      // A) Who is the user?
      final profileRes = await BaseClient.getRequest(
        api: 'https://intensely-optimal-unicorn.ngrok-free.app/food/my-profile/',
        headers: headers,
      );
      bool isUserPremium = false;
      if (profileRes.statusCode >= 200 && profileRes.statusCode < 300) {
        final Map<String, dynamic> p = json.decode(profileRes.body) as Map<String, dynamic>;
        final sub = (p['subscription_status'] ?? '').toString().trim().toLowerCase();
        isUserPremium = sub == 'active'; // subscribed = premium
      }

      // B) Deals
      final dealsRes = await BaseClient.getRequest(
        api: 'https://intensely-optimal-unicorn.ngrok-free.app/vendors/all-vendor-deals/',
        headers: headers,
      );
      if (dealsRes.statusCode < 200 || dealsRes.statusCode >= 300) {
        throw 'Failed to fetch deals (${dealsRes.statusCode})';
      }
      final List<dynamic> deals = json.decode(dealsRes.body) as List<dynamic>;

      // C) Vendors
      final vendorsRes = await BaseClient.getRequest(
        api: 'https://intensely-optimal-unicorn.ngrok-free.app/vendors/all-business-profile/',
        headers: headers,
      );
      final Map<int, Map<String, dynamic>> vendorById = {};
      if (vendorsRes.statusCode >= 200 && vendorsRes.statusCode < 300) {
        final List<dynamic> vendors = json.decode(vendorsRes.body) as List<dynamic>;
        for (final v in vendors) {
          final vm = v as Map<String, dynamic>;
          final vid = vm['vendor_id'];
          if (vid is int) vendorById[vid] = vm;
        }
      }

      // D) Map ALL deals (no paid filtering) and compute per-user isPremium
      String normDealType(Object? v) {
        final s = (v ?? '').toString().trim().toLowerCase();
        if (s == 'paid') return 'paid';
        if (s == 'free') return 'free';
        if (s == 'both') return 'both';
        return ''; // unknown/null
      }

      final items = <BeyondNeighbourhood>[];
      for (final raw in deals) {
        final m = raw as Map<String, dynamic>;
        // Optional: hide completely inactive deals, or expired ones (keep if you want them shown)
        final active = m['is_active'] == true;
        if (!active) continue;

        final vendor = vendorById[m['user_id'] as int? ?? -1];

        final bn = BeyondNeighbourhood.fromDealJson(
          m,
          vendorJson: vendor,
          isUserPremium: isUserPremium, // <- critical for blur logic
        );
        items.add(bn);
      }

      // Optional: sort by newest first (or however you like)
      items.sort((a, b) => b.startDate.compareTo(a.startDate));

      beyondNeighbourhood.assignAll(items);
      debugPrint('BeyondNeighbourhood loaded: ${items.length} (userPremium=$isUserPremium)');
    } catch (e) {
      debugPrint('Error fetching beyond neighbourhood: $e');
      Get.snackbar('Error', 'Failed to load deals beyond your neighbourhood');
    }
  }

  Future<void> fetchNearShops() async {
    try {
      final headers = await BaseClient.authHeaders();

      // 1) Get user's current location (with permission)
      await _ensureLocationPermission();
      final pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      final userLL = LatLng(pos.latitude, pos.longitude);

      // 2) Fetch all vendor profiles
      final response = await BaseClient.getRequest(
        api: 'https://intensely-optimal-unicorn.ngrok-free.app/vendors/all-business-profile/',
        headers: headers,
      );

      final decoded = json.decode(response.body);
      if (decoded == null || decoded is! List) {
        debugPrint('No near shops: bad response format');
        return;
      }

      // 3) Build (distance, adaptedJson) list
      final d = Distance();
      final List<_NearTmp> candidates = [];

      for (final item in decoded) {
        final m = (item as Map<String, dynamic>);
        final address = (m['address'] ?? '').toString().trim();
        if (address.isEmpty) continue;

        // (a) If backend starts returning lat/lng, use them; else geocode
        LatLng? vendorLL;
        if (m['lat'] is num && m['lng'] is num) {
          vendorLL = LatLng((m['lat'] as num).toDouble(), (m['lng'] as num).toDouble());
        } else {
          vendorLL = _geoCache[address];
          vendorLL ??= await _geocodeAddressMulti(address, bias: userLL);
          if (vendorLL != null) _geoCache[address] = vendorLL;
          await Future.delayed(const Duration(milliseconds: 200)); // be polite to free endpoints
        }

        if (vendorLL == null) continue;

        final meters = d.distance(userLL, vendorLL); // <- correct usage
        final km = meters / 1000.0;
        if (km > _nearRadiusKm) continue;

        // Map to your NearShops JSON shape (UI unchanged)
        String mapCategory(dynamic id) {
          switch (id) {
            case 1: return 'Restaurant';
            case 2: return 'Grocery';
            default: return 'Other';
          }
        }

        const placeholderLogo = 'https://via.placeholder.com/120';
        final adapted = <String, dynamic>{
          'id': m['id'],
          'vendor_id': m['vendor_id'],
          'vendor_email': m['vendor_email'],
          'logo_url': (m['logo_image'] ?? placeholderLogo),
          'name': m['name'] ?? 'Unknown',
          'category_name': mapCategory(m['category']),
          'shop_title': m['name'] ?? 'Unknown',
          'status_text': m['address'] ?? 'Address unavailable',
          'address': m['address'],
          'phone_number': m['phone_number'],
          'kvk_number': m['kvk_number'],
          // (Optional) if your NearShops model supports, you can add distance too.
          // 'distance_km': double.parse(km.toStringAsFixed(2)),
        };

        candidates.add(_NearTmp(distanceKm: km, json: adapted));
      }

      // 4) Sort by nearest, limit, then push to observable
      candidates.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
      final limited = candidates.take(_nearLimit).map((e) => e.json).toList();

      nearShops.value = limited.map<NearShops>((j) => NearShops.fromJson(j)).toList();
    } catch (e) {
      debugPrint('Error fetching near shops: $e');
    }
  }

  Future<void> _ensureLocationPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) throw 'Location services are disabled.';

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      throw 'Location permission denied.';
    }
  }

  Future<LatLng?> _geocodeAddressMulti(String address, {LatLng? bias}) async {
    // 1) Device geocoding (no key)
    try {
      final results = await locationFromAddress(address);
      if (results.isNotEmpty) {
        final loc = results.first;
        return LatLng(loc.latitude, loc.longitude);
      }
    } catch (_) {}

    // 2) Open-Meteo (keyless)
    try {
      final q = Uri.encodeQueryComponent(address);
      final url = Uri.parse('https://geocoding-api.open-meteo.com/v1/search?name=$q&count=1&language=en&format=json');
      final res = await http.get(url, headers: {'Accept': 'application/json'});
      if (res.statusCode == 200) {
        final j = jsonDecode(res.body);
        final results = j['results'] as List?;
        if (results != null && results.isNotEmpty) {
          final r = results[0];
          final lat = (r['latitude'] as num?)?.toDouble();
          final lon = (r['longitude'] as num?)?.toDouble();
          if (lat != null && lon != null) return LatLng(lat, lon);
        }
      }
    } catch (_) {}

    // 3) Photon (Komoot) (keyless) – with bias when available
    try {
      final q = Uri.encodeQueryComponent(address);
      final base = 'https://photon.komoot.io/api/?q=$q&limit=1&lang=en';
      final url = (bias != null) ? Uri.parse('$base&lat=${bias.latitude}&lon=${bias.longitude}') : Uri.parse(base);
      final res = await http.get(url, headers: {'Accept': 'application/json'});
      if (res.statusCode == 200) {
        final j = jsonDecode(res.body);
        final feats = j['features'] as List?;
        if (feats != null && feats.isNotEmpty) {
          final coords = feats[0]?['geometry']?['coordinates'] as List?;
          if (coords != null && coords.length >= 2) {
            final lon = (coords[0] as num).toDouble();
            final lat = (coords[1] as num).toDouble();
            return LatLng(lat, lon);
          }
        }
      }
    } catch (_) {}

    // 4) Nominatim fallback (keyless; be gentle)
    try {
      final q = Uri.encodeQueryComponent(address);
      final url = Uri.parse('https://nominatim.openstreetmap.org/search?q=$q&format=json&limit=1');
      final res = await http.get(url, headers: {
        'User-Agent': 'Quopon/1.0 (contact: youremail@example.com)',
        'Accept': 'application/json',
      });
      if (res.statusCode == 200) {
        final list = jsonDecode(res.body) as List;
        if (list.isNotEmpty) {
          final lat = double.tryParse(list[0]['lat'] ?? '');
          final lon = double.tryParse(list[0]['lon'] ?? '');
          if (lat != null && lon != null) return LatLng(lat, lon);
        }
      }
    } catch (_) {}

    return null;
  }

  Future<void> fetchSpeedyDeliveries() async {
    try {
      // Call the API to get the categories
      final response = await BaseClient.getRequest(api: Api.speedyDeliveries, );

      // Decode the response body from JSON
      final decodedResponse = json.decode(response.body);

      // Check if the response contains categories
      if (decodedResponse != null && decodedResponse is List) {
        // Map the response to Category objects and update the list
        speedyDeliveries.value = decodedResponse
            .map((speedyDeliveriesJson) => SpeedyDeliveries.fromJson(speedyDeliveriesJson))
            .toList();
      } else {
        print('No categories found or incorrect response format.');
      }
    } catch (e) {
      print('Error fetching categories: $e');
      // Handle error appropriately (e.g., show a Snackbar or error message)
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchVendorCategories();  // Call the API to fetch categories on controller init
    fetchBeyondNeighbourhood();
    fetchNearShops();
    fetchSpeedyDeliveries();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

class _NearTmp {
  final double distanceKm;
  final Map<String, dynamic> json;
  _NearTmp({required this.distanceKm, required this.json});
}

class Category {
  final int id;
  final String name;
  final String imageUrl;

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  // Factory constructor to create a Category object from JSON response
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
    );
  }
}
