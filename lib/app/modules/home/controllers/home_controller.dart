import 'dart:async';
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
import '../../../data/model/business_hour.dart';
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

  // Live, reactive status by user_id
  final RxMap<int, String> vendorStatus = <int, String>{}.obs;

// Caches
  final Map<int, BusinessHour> _hoursCache = {};     // user_id -> hours
  final Map<int, double> _vendorDistanceKm = {};     // user_id -> distance
  Timer? _statusTicker;

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

  String _fmtEtaRange(int minutes) {
    int lower = minutes - 5;
    int upper = minutes + 5;
    if (lower < 10) lower = 10;
    if (upper < lower + 4) upper = lower + 4;
    if (upper > 90) upper = 90;
    return '$lower–$upper min';
  }

  int _estimateDeliveryMinutes(double km) {
    // Simple: 12 min base + ~6 min per km, clamped
    final m = (12 + km * 6).round();
    return m.clamp(10, 90);
  }

  Duration? _parseHms(String? s) {
    if (s == null || s.isEmpty) return null;
    final p = s.split(':');
    if (p.length < 2) return null;
    final h = int.tryParse(p[0]) ?? 0;
    final m = int.tryParse(p[1]) ?? 0;
    final sec = (p.length > 2 ? int.tryParse(p[2]) : null) ?? 0;
    return Duration(hours: h, minutes: m, seconds: sec);
  }

  bool _isOpenNow(String? openHms, String? closeHms, DateTime now) {
    final open = _parseHms(openHms);
    final close = _parseHms(closeHms);
    if (open == null || close == null) return false;
    final nowSec = now.hour * 3600 + now.minute * 60 + now.second;
    final o = open.inSeconds;
    final c = close.inSeconds;
    if (c == o) return false;                 // zero window -> closed
    if (c > o) {
      return nowSec >= o && nowSec < c;       // same-day window
    } else {
      return nowSec >= o || nowSec < c;       // crosses midnight
    }
  }

  int? _minutesUntilOpenToday(String? openHms, DateTime now) {
    final open = _parseHms(openHms);
    if (open == null) return null;
    final nowSec = now.hour * 3600 + now.minute * 60 + now.second;
    final o = open.inSeconds;
    if (nowSec <= o) return ((o - nowSec) / 60).ceil();
    return null; // today’s open already passed
  }

  String _statusFromSchedule(Schedule s, double km, DateTime now) {
    if (s.isClosed) return 'Closed';

    final open = s.openTime;
    final close = s.closeTime;
    if (_isOpenNow(open, close, now)) {
      final eta = _estimateDeliveryMinutes(km);
      return _fmtEtaRange(eta);
    } else {
      final mins = _minutesUntilOpenToday(open, now);
      if (mins != null && mins <= 30) return 'Opens in $mins min';
      return 'Closed';
    }
  }

  Schedule _scheduleForDay(BusinessHour hours, int weekdayIdx) {
    // weekdayIdx: 0=Mon...6=Sun
    final list = hours.schedule;
    if (weekdayIdx >= 0 && weekdayIdx < list.length) return list[weekdayIdx];
    return Schedule(day: 'Monday', dayDisplay: 'Monday', openTime: null, closeTime: null, isClosed: true);
  }

  Future<BusinessHour?> _fetchVendorHours(int userId) async {
    try {
      final headers = await BaseClient.authHeaders();
      final res = await BaseClient.getRequest(
        api: 'https://intensely-optimal-unicorn.ngrok-free.app/home/users/$userId/business-hours/',
        headers: headers,
      );
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final j = json.decode(res.body) as Map<String, dynamic>;
        return BusinessHour.fromJson(j);
      }
    } catch (_) {}
    return null;
  }

  void _recomputeStatuses() {
    final now = DateTime.now();
    final weekdayIdx = now.weekday - 1; // 0..6
    final newMap = <int, String>{};

    for (final e in _vendorDistanceKm.entries) {
      final userId = e.key;
      final km = e.value;
      final hours = _hoursCache[userId];
      String status = 'Closed';
      if (hours != null) {
        final today = _scheduleForDay(hours, weekdayIdx);
        status = _statusFromSchedule(today, km, now);
      }
      newMap[userId] = status;
    }
    vendorStatus.assignAll(newMap); // reactive
  }

  Future<void> _primeBusinessHoursAndStatuses() async {
    print('Rubaid');
    // Fetch hours for any userIds we don't have yet
    for (final userId in _vendorDistanceKm.keys) {
      if (_hoursCache.containsKey(userId)) continue;
      final h = await _fetchVendorHours(userId);
      if (h != null) _hoursCache[userId] = h;
    }
    _recomputeStatuses();
    _statusTicker?.cancel();
    _statusTicker = Timer.periodic(const Duration(seconds: 30), (_) => _recomputeStatuses());
  }

  Future<void> fetchNearShops() async {
    try {
      final headers = await BaseClient.authHeaders();

      await _ensureLocationPermission();
      final pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      final userLL = LatLng(pos.latitude, pos.longitude);

      final response = await BaseClient.getRequest(
        api: 'https://intensely-optimal-unicorn.ngrok-free.app/vendors/all-business-profile/',
        headers: headers,
      );

      final decoded = json.decode(response.body);
      if (decoded == null || decoded is! List) {
        debugPrint('No near shops: bad response format');
        return;
      }

      final d = Distance();
      final List<_NearTmp> candidates = [];

      for (final item in decoded) {
        final m = (item as Map<String, dynamic>);
        final address = (m['address'] ?? '').toString().trim();
        if (address.isEmpty) continue;

        LatLng? vendorLL;
        if (m['lat'] is num && m['lng'] is num) {
          vendorLL = LatLng((m['lat'] as num).toDouble(), (m['lng'] as num).toDouble());
        } else {
          vendorLL = _geoCache[address];
          vendorLL ??= await _geocodeAddressMulti(address, bias: userLL);
          if (vendorLL != null) _geoCache[address] = vendorLL;
          await Future.delayed(const Duration(milliseconds: 200));
        }
        if (vendorLL == null) continue;

        final meters = d.distance(userLL, vendorLL);
        final km = meters / 1000.0;
        if (km > _nearRadiusKm) continue;

        // 📌 KEY: prefer user_id for hours endpoint; fallback to vendor_id
        final int userIdKey = (m['user_id'] is int)
            ? m['user_id'] as int
            : (m['vendor_id'] is int ? m['vendor_id'] as int : -1);
        if (userIdKey == -1) continue;

        // 📌 keep distance keyed by user_id
        _vendorDistanceKm[userIdKey] = km;

        String mapCategory(dynamic id) {
          switch (id) {
            case 1: return 'Restaurant';
            case 2: return 'Grocery';
            default: return 'Other';
          }
        }
        const placeholderLogo = 'https://via.placeholder.com/120';

        // get a clean logo string
        final rawLogo = (m['logo_image'] ?? '').toString().trim();
        final logo = rawLogo.isNotEmpty ? rawLogo : placeholderLogo;

        final adapted = <String, dynamic>{
          'id': m['id'],
          // expose user_id as vendor_id (unchanged)
          'vendor_id': userIdKey,
          'vendor_email': m['vendor_email'],
          // ✅ KEY FIX: must be "logo_image" to match NearShops.fromJson
          'logo_image': logo,
          'name': m['name'] ?? 'Unknown',
          'category': m['category'],
          'address': m['address'],
          'phone_number': m['phone_number'],
          'kvk_number': m['kvk_number'],
          // optional fields you already add:
          'shop_title': m['name'] ?? 'Unknown',
          'status_text': '—',
          'distance_km': double.parse(km.toStringAsFixed(2)),
        };

        candidates.add(_NearTmp(distanceKm: km, json: adapted));
      }

      candidates.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
      final limited = candidates.take(_nearLimit).map((e) => e.json).toList();

      nearShops.value = limited.map<NearShops>((j) => NearShops.fromJson(j)).toList();

      // 📌 fetch hours + compute live statuses
      await _primeBusinessHoursAndStatuses();
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
      final headers = await BaseClient.authHeaders();

      // A) user location (for distance/ETA)
      await _ensureLocationPermission();
      final pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      final userLL = LatLng(pos.latitude, pos.longitude);
      final dist = Distance();

      // B) who is the user? (premium affects blur)
      final profileRes = await BaseClient.getRequest(
        api: 'https://intensely-optimal-unicorn.ngrok-free.app/food/my-profile/',
        headers: headers,
      );
      bool isUserPremium = false;
      if (profileRes.statusCode >= 200 && profileRes.statusCode < 300) {
        final Map<String, dynamic> p = json.decode(profileRes.body) as Map<String, dynamic>;
        final sub = (p['subscription_status'] ?? '').toString().trim().toLowerCase();
        isUserPremium = sub == 'active';
      }

      // C) deals (we only want ones that can be delivered quickly)
      final dealsRes = await BaseClient.getRequest(
        api: 'https://intensely-optimal-unicorn.ngrok-free.app/vendors/all-vendor-deals/',
        headers: headers,
      );
      if (dealsRes.statusCode < 200 || dealsRes.statusCode >= 300) {
        throw 'Failed to fetch deals (${dealsRes.statusCode})';
      }
      final List<dynamic> deals = json.decode(dealsRes.body) as List<dynamic>;

      // D) vendors (for name/logo/address/coords)
      final vendorsRes = await BaseClient.getRequest(
        api: 'https://intensely-optimal-unicorn.ngrok-free.app/vendors/all-business-profile/',
        headers: headers,
      );
      final Map<int, Map<String, dynamic>> vendorByUserId = {};
      if (vendorsRes.statusCode >= 200 && vendorsRes.statusCode < 300) {
        final List<dynamic> vendors = json.decode(vendorsRes.body) as List<dynamic>;
        for (final v in vendors) {
          final vm = v as Map<String, dynamic>;
          final uid = (vm['user_id'] is int)
              ? vm['user_id'] as int
              : (vm['vendor_id'] is int ? vm['vendor_id'] as int : -1);
          if (uid != -1) vendorByUserId[uid] = vm;
        }
      }

      // E) map to SpeedyDeliveries with computed distance/ETA
      final items = <SpeedyDeliveries>[];
      for (final raw in deals) {
        final m = raw as Map<String, dynamic>;

        // must be active and deliverable
        final active = m['is_active'] == true;
        if (!active) continue;
        final redem = (m['redemption_type'] ?? '').toString().trim().toUpperCase();
        if (!(redem == 'DELIVERY' || redem == 'BOTH')) continue;

        final userId = (m['user_id'] is int) ? m['user_id'] as int : -1;
        if (userId == -1) continue;
        final vendor = vendorByUserId[userId];
        if (vendor == null) continue;

        // vendor coords (or geocode address)
        LatLng? vendorLL;
        if (vendor['lat'] is num && vendor['lng'] is num) {
          vendorLL = LatLng((vendor['lat'] as num).toDouble(), (vendor['lng'] as num).toDouble());
        } else {
          final address = (vendor['address'] ?? '').toString().trim();
          if (address.isEmpty) continue;
          vendorLL = _geoCache[address];
          vendorLL ??= await _geocodeAddressMulti(address, bias: userLL);
          if (vendorLL != null) _geoCache[address] = vendorLL;
          await Future.delayed(const Duration(milliseconds: 150));
        }
        if (vendorLL == null) continue;

        // distance + ETA
        final meters = dist.distance(userLL, vendorLL);
        final km = meters / 1000.0;
        final etaMin = _estimateDeliveryMinutes(km);

        // (optional) focus on truly “speedy” ones within radius
        if (km > _nearRadiusKm) continue;

        // normalize costs
        final List<dynamic> rawCosts = (m['delivery_costs'] as List<dynamic>? ?? []);
        final costs = rawCosts
            .map((e) => DeliveryCostBN.fromJson(e as Map<String, dynamic>))
            .toList();

        // paid/free logic (blur for free users)
        String _normDealType(Object? v) {
          final s = (v ?? '').toString().trim().toLowerCase();
          if (s == 'paid') return 'Paid';
          if (s == 'free') return 'Free';
          if (s == 'both') return 'Both';
          return '';
        }
        final normalizedDealType = _normDealType(m['deal_type']);
        final isPaidDeal = normalizedDealType == 'Paid';
        final computedIsPremium = isPaidDeal && !isUserPremium;

        String _norm(Object? v) => (v ?? '').toString().trim();

        // build item (set distance/ETA explicitly)
        final miles = (km * 0.621371).toStringAsFixed(1);

        items.add(
          SpeedyDeliveries(
            id: m['id'] as int,
            userId: userId,
            email: _norm(m['email'] ?? vendor['vendor_email']),
            linkedMenuItem: (m['linked_menu_item'] ?? 0) as int,
            title: _norm(m['title'] ?? m['offers']),
            description: _norm(m['description']),
            imageUrl: _norm(m['image_url']),
            discountValue: _norm(m['discount_value'] ?? m['discount_value_free'] ?? '0'),
            startDate: DateTime.parse(m['start_date'].toString()),
            endDate: DateTime.parse(m['end_date'].toString()),
            redemptionType: redem,
            dealType: normalizedDealType,
            maxCouponsTotal: (m['max_coupons_total'] ?? 0) as int,
            maxCouponsPerCustomer: (m['max_coupons_per_customer'] ?? 0) as int,
            deliveryCosts: costs,
            isActive: true,
            qrImage: _norm(m['qrimage']),
            vendorName: _norm(vendor['name']),
            vendorLogoUrl: _norm(vendor['logo_image']),
            vendorAddress: _norm(vendor['address']),
            rating: '4.6',
            distanceMiles: miles,
            deliveryTimeMinutes: etaMin,
            isPremium: computedIsPremium,
            isFavourite: false,
            priceRange: 2,
          ),
        );
      }

      // F) sort by fastest ETA, then by distance
      items.sort((a, b) {
        final c = a.deliveryTimeMinutes.compareTo(b.deliveryTimeMinutes);
        if (c != 0) return c;
        final da = double.tryParse(a.distanceMiles) ?? 0;
        final db = double.tryParse(b.distanceMiles) ?? 0;
        return da.compareTo(db);
      });

      // (optional) take top N
      final top = items.take(_nearLimit).toList();

      speedyDeliveries.assignAll(top);
    } catch (e) {
      debugPrint('Error fetching speedy deliveries: $e');
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
    _statusTicker?.cancel();
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
