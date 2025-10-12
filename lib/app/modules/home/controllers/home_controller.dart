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

import '../../../data/model/business_hour.dart';
import '../../../data/model/vendor_category.dart';

enum SearchMode { none, vendor, deal, menu }

class HomeController extends GetxController {
  final RxString locationLabel = 'Current Location'.obs;

  // ---------------- Existing state ----------------
  RxBool deliveryHighToLow = true.obs;

  final RxBool loadingBeyond = false.obs;

  final double _nearRadiusKm = 5.0; // radius for "Shops Near You"
  final int _nearLimit = 20; // cap list if many results
  final Map<String, LatLng> _geoCache = {}; // address -> coords

  // Reactive lists surfaced to UI
  RxList<VendorCategory> vendorCategories = <VendorCategory>[].obs;
  var beyondNeighbourhood = <BeyondNeighbourhood>[].obs;
  var nearShops = <NearShops>[].obs;
  var speedyDeliveries = <SpeedyDeliveries>[].obs;

  // Live, reactive status by user_id (ETA buckets like "15–25 min")
  final RxMap<int, String> vendorStatus = <int, String>{}.obs;

  // Caches
  final Map<int, BusinessHour> _hoursCache = {}; // user_id -> hours
  final Map<int, double> _vendorDistanceKm =
      {}; // user_id -> distance from user

  // NEW: cache vendor category by user_id (== vendor_id in your data)
  final Map<int, int?> _vendorCategory =
      {}; // user_id -> category id (nullable)

  Timer? _statusTicker;
  final RxBool sortTouched = false.obs;

  // ---------------- Filter state & master copies ----------------
  final RxBool filterPickup =
      false.obs; // Pickup & Both only (excludes Delivery-only)
  final RxBool filterOffers = false.obs; // Near shops that have any active deal
  final RxBool filterUnder30 = false.obs; // ETA under 30 mins

  // NEW: selected category
  final RxnInt selectedCategoryId = RxnInt(); // null = all categories

  // Masters (unfiltered)
  final List<BeyondNeighbourhood> _allBeyond = [];
  final List<NearShops> _allNear = [];
  final List<SpeedyDeliveries> _allSpeedy = [];

  // Indices to support filtering/sorting
  // user_id -> list of raw deals (as returned from /all-vendor-deals)
  final Map<int, List<Map<String, dynamic>>> _dealsByUserId = {};
  // Approximate "effective" delivery fee per vendor (see heuristic below)
  final Map<int, double> _vendorEffectiveFee = {}; // user_id -> fee

  // ---------------- SEARCH STATE (NEW) ----------------
  final RxString currentQuery = ''.obs;
  final RxBool searching = false.obs;

  final Rx<SearchMode> searchMode = SearchMode.none.obs;

  // Menu caches for menu-name search
  final Map<int, String> _menuNameById = {}; // linked_menu_item id -> menu name
  final Map<int, Set<int>> _vendorMenuIds =
      {}; // vendor_id -> set<linked_menu_item ids>

  // ---------------- Utilities ----------------
  String _normStr(Object? v) => (v ?? '').toString().trim();
  String _lc(Object? v) => (v ?? '').toString().toLowerCase().trim();
  bool _contains(String hay, String needle) => hay.contains(needle);

  bool _isPickupOrBoth(Object? v) {
    final s = _normStr(v).toUpperCase();
    return s == 'PICKUP' || s == 'BOTH';
  }

  bool _isDeliverable(Object? v) {
    final s = _normStr(v).toUpperCase();
    return s == 'DELIVERY' || s == 'BOTH';
  }

  double _tryParseDouble(Object? v, {double fallback = 0.0}) {
    if (v == null) return fallback;
    return double.tryParse(v.toString()) ?? fallback;
  }

  // Choose an "effective" delivery fee for a vendor given our current constraints.
  double _effectiveFeeForCosts(List<dynamic>? rawCosts, {double km = 0.0}) {
    if (rawCosts == null || rawCosts.isEmpty) return 0.0;
    double best = double.infinity;
    for (final c in rawCosts) {
      final fee = _tryParseDouble(
        (c as Map)['delivery_fee'],
        fallback: double.infinity,
      );
      if (fee < best) best = fee;
    }
    return (best == double.infinity) ? 0.0 : best;
  }

  double _feeForVendor(int userId) => _vendorEffectiveFee[userId] ?? 0.0;

  int? _minFromStatus(String s) {
    final m = RegExp(r'(\d+)').firstMatch(s);
    if (m == null) return null;
    return int.tryParse(m.group(1)!);
  }

  // ---------------- Fetches ----------------

  Future<void> fetchVendorCategories() async {
    try {
      final apiUrl =
          'http://10.10.13.99:8090/vendors/vendor-categories/';
      final headers = await BaseClient.authHeaders();

      final response = await BaseClient.getRequest(
        api: apiUrl,
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        final responseBody = json.decode(response.body);
        final categories = vendorCategoryFromJson(responseBody);
        vendorCategories.value = categories;
      } else {
        final responseBody = json.decode(response.body);
        throw responseBody['message'] ?? 'Failed to fetch vendor categories';
      }
    } catch (error) {
      debugPrint('Error ${error.toString()}');
      Get.snackbar('Error', error.toString());
    }
  }

  Future<void> _updateLocationLabelFrom(Position pos) async {
    try {
      final placemarks = await placemarkFromCoordinates(pos.latitude, pos.longitude);
      String label = 'Current Location';
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;

        // Build a short, readable area string: SubLocality, Locality, AdminArea
        final parts = <String>[
          (p.subLocality ?? '').trim(),
          (p.locality ?? '').trim(),
          (p.administrativeArea ?? '').trim(),
        ].where((e) => e.isNotEmpty).toList();

        if (parts.isNotEmpty) {
          label = parts.take(2).join(', '); // e.g., "Banani, Dhaka"
          if (label.length > 24) {
            // keep it short to avoid overlap
            label = label.split(',').first;
            if (label.length > 24) {
              label = label.substring(0, 24);
            }
          }
        }
      }
      locationLabel.value = label;
    } catch (_) {
      locationLabel.value = 'Current Location';
    }
  }

  Future<void> fetchBeyondNeighbourhood() async {
    loadingBeyond.value = true;
    try {
      final headers = await BaseClient.authHeaders();

      // A) user (for premium)
      final profileRes = await BaseClient.getRequest(
        api:
            'http://10.10.13.99:8090/food/my-profile/',
        headers: headers,
      );
      bool isUserPremium = false;
      if (profileRes.statusCode >= 200 && profileRes.statusCode < 300) {
        final Map<String, dynamic> p =
            json.decode(profileRes.body) as Map<String, dynamic>;
        final sub = (p['subscription_status'] ?? '')
            .toString()
            .trim()
            .toLowerCase();
        isUserPremium = sub == 'active';
      }

      // B) user location (for distance/ETA fallback)
      await _ensureLocationPermission();
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final userLL = LatLng(pos.latitude, pos.longitude);
      await _updateLocationLabelFrom(pos);
      final dist = Distance();

      // C) deals
      final dealsRes = await BaseClient.getRequest(
        api:
            'http://10.10.13.99:8090/vendors/all-vendor-deals/',
        headers: headers,
      );
      if (dealsRes.statusCode < 200 || dealsRes.statusCode >= 300) {
        throw 'Failed to fetch deals (${dealsRes.statusCode})';
      }
      final List<dynamic> deals = json.decode(dealsRes.body) as List<dynamic>;

      // D) vendors → map by (assumed) user_id == vendor_id
      final vendorsRes = await BaseClient.getRequest(
        api:
            'http://10.10.13.99:8090/vendors/all-business-profile/',
        headers: headers,
      );
      final Map<int, Map<String, dynamic>> vendorByUserId = {};
      if (vendorsRes.statusCode >= 200 && vendorsRes.statusCode < 300) {
        final List<dynamic> vendors =
            json.decode(vendorsRes.body) as List<dynamic>;
        for (final v in vendors) {
          final vm = v as Map<String, dynamic>;
          final uid = (vm['user_id'] is int)
              ? vm['user_id'] as int
              : (vm['vendor_id'] is int ? vm['vendor_id'] as int : -1);
          if (uid != -1) {
            vendorByUserId[uid] = vm;
            // cache vendor category for filtering later
            _vendorCategory[uid] = vm['category'] as int?;
          }
        }
      }

      // E) build items + indexes + compute vendor distances (for ETA fallback)
      final items = <BeyondNeighbourhood>[];
      _dealsByUserId.clear();

      for (final raw in deals) {
        final m = raw as Map<String, dynamic>;
        final active = m['is_active'] == true;
        if (!active) continue;

        final int uid = (m['user_id'] is int) ? m['user_id'] as int : -1;
        if (uid == -1) continue;

        // index deals by vendor
        (_dealsByUserId[uid] ??= []).add(m);

        // effective fee cache
        final costs = (m['delivery_costs'] as List<dynamic>?) ?? const [];
        final fee = _effectiveFeeForCosts(costs);
        final prev = _vendorEffectiveFee[uid];
        if (prev == null || fee < prev) _vendorEffectiveFee[uid] = fee;

        final vendor = vendorByUserId[uid];

        // compute & cache vendor distance for ETA fallback
        if (!_vendorDistanceKm.containsKey(uid) && vendor != null) {
          LatLng? vendorLL;
          if (vendor['lat'] is num && vendor['lng'] is num) {
            vendorLL = LatLng(
              (vendor['lat'] as num).toDouble(),
              (vendor['lng'] as num).toDouble(),
            );
          } else {
            final address = (vendor['address'] ?? '').toString().trim();
            if (address.isNotEmpty) {
              vendorLL = _geoCache[address];
              vendorLL ??= await _geocodeAddressMulti(address, bias: userLL);
              if (vendorLL != null) _geoCache[address] = vendorLL;
              await Future.delayed(const Duration(milliseconds: 120));
            }
          }
          if (vendorLL != null) {
            final meters = dist.distance(userLL, vendorLL);
            _vendorDistanceKm[uid] = meters / 1000.0; // km
          }
        }

        // NOTE: ensure your model has `linkedMenuItem` (nullable) to help menu search
        final bn = BeyondNeighbourhood.fromDealJson(
          m,
          vendorJson: vendor,
          isUserPremium: isUserPremium,
          // If your factory supports it, ensure it keeps linked_menu_item
        );
        items.add(bn);
      }

      // newest first
      items.sort((a, b) => b.startDate.compareTo(a.startDate));

      _allBeyond
        ..clear()
        ..addAll(items);

      _applyFilters();
    } catch (e) {
      debugPrint('Error fetching beyond neighbourhood: $e');
      Get.snackbar('Error', 'Failed to load deals beyond your neighbourhood');
    } finally {
      loadingBeyond.value = false;
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
    if (c == o) return false;
    if (c > o) {
      return nowSec >= o && nowSec < c; // same-day window
    } else {
      return nowSec >= o || nowSec < c; // crosses midnight
    }
  }

  int? _minutesUntilOpenToday(String? openHms, DateTime now) {
    final open = _parseHms(openHms);
    if (open == null) return null;
    final nowSec = now.hour * 3600 + now.minute * 60 + now.second;
    final o = open.inSeconds;
    if (nowSec <= o) return ((o - nowSec) / 60).ceil();
    return null;
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
    final list = hours.schedule;
    if (weekdayIdx >= 0 && weekdayIdx < list.length) return list[weekdayIdx];
    return Schedule(
      day: 'Monday',
      dayDisplay: 'Monday',
      openTime: null,
      closeTime: null,
      isClosed: true,
    );
  }

  Future<BusinessHour?> _fetchVendorHours(int userId) async {
    try {
      final headers = await BaseClient.authHeaders();
      final res = await BaseClient.getRequest(
        api:
            'http://10.10.13.99:8090/home/users/$userId/business-hours/',
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
    vendorStatus.assignAll(newMap);
    if (filterUnder30.value) _applyFilters();
  }

  Future<void> _primeBusinessHoursAndStatuses() async {
    for (final userId in _vendorDistanceKm.keys) {
      if (_hoursCache.containsKey(userId)) continue;
      final h = await _fetchVendorHours(userId);
      if (h != null) _hoursCache[userId] = h;
    }
    _recomputeStatuses();
    _statusTicker?.cancel();
    _statusTicker = Timer.periodic(
      const Duration(seconds: 30),
      (_) => _recomputeStatuses(),
    );
  }

  Future<void> fetchNearShops() async {
    try {
      final headers = await BaseClient.authHeaders();

      await _ensureLocationPermission();
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final userLL = LatLng(pos.latitude, pos.longitude);
      await _updateLocationLabelFrom(pos);

      final response = await BaseClient.getRequest(
        api:
            'http://10.10.13.99:8090/vendors/all-business-profile/',
        headers: headers,
      );

      final decoded = json.decode(response.body);
      if (decoded == null || decoded is! List) {
        debugPrint('No near shops: bad response format');
        return;
      }

      // Ensure we have deals index at least once for Offers / Pickup filters
      if (_dealsByUserId.isEmpty) {
        try {
          final dealsRes = await BaseClient.getRequest(
            api:
                'http://10.10.13.99:8090/vendors/all-vendor-deals/',
            headers: headers,
          );
          if (dealsRes.statusCode >= 200 && dealsRes.statusCode < 300) {
            final List<dynamic> deals =
                json.decode(dealsRes.body) as List<dynamic>;
            for (final raw in deals) {
              final m = raw as Map<String, dynamic>;
              final uid = (m['user_id'] is int) ? m['user_id'] as int : -1;
              if (uid != -1) {
                (_dealsByUserId[uid] ??= []).add(m);
                final costs =
                    (m['delivery_costs'] as List<dynamic>?) ?? const [];
                final fee = _effectiveFeeForCosts(costs);
                final prev = _vendorEffectiveFee[uid];
                if (prev == null || fee < prev) _vendorEffectiveFee[uid] = fee;
              }
            }
          }
        } catch (_) {}
      }

      final d = Distance();
      final List<_NearTmp> candidates = [];

      for (final item in decoded) {
        final m = (item as Map<String, dynamic>);
        final address = (m['address'] ?? '').toString().trim();
        if (address.isEmpty) continue;

        LatLng? vendorLL;
        if (m['lat'] is num && m['lng'] is num) {
          vendorLL = LatLng(
            (m['lat'] as num).toDouble(),
            (m['lng'] as num).toDouble(),
          );
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

        // prefer user_id; fallback to vendor_id
        final int userIdKey = (m['user_id'] is int)
            ? m['user_id'] as int
            : (m['vendor_id'] is int ? m['vendor_id'] as int : -1);
        if (userIdKey == -1) continue;

        _vendorDistanceKm[userIdKey] = km;

        // cache category for category filtering
        _vendorCategory[userIdKey] = m['category'] as int?;

        const placeholderLogo = 'https://via.placeholder.com/120';
        final rawLogo = (m['logo_image'] ?? '').toString().trim();
        final logo = rawLogo.isNotEmpty ? rawLogo : placeholderLogo;

        final adapted = <String, dynamic>{
          'id': m['id'],
          'vendor_id': userIdKey,
          'vendor_email': m['vendor_email'],
          'logo_image': logo,
          'name': m['name'] ?? 'Unknown',
          'category': m['category'],
          'address': m['address'],
          'phone_number': m['phone_number'],
          'kvk_number': m['kvk_number'],
          'shop_title': m['name'] ?? 'Unknown',
          'status_text': '—',
          'distance_km': double.parse(km.toStringAsFixed(2)),
        };

        candidates.add(_NearTmp(distanceKm: km, json: adapted));
      }

      candidates.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
      final limited = candidates.take(_nearLimit).map((e) => e.json).toList();

      final parsed = limited
          .map<NearShops>((j) => NearShops.fromJson(j))
          .toList();

      _allNear
        ..clear()
        ..addAll(parsed);

      await _primeBusinessHoursAndStatuses(); // for ETA buckets
      _applyFilters();
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
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw 'Location permission denied.';
    }
  }

  Future<LatLng?> _geocodeAddressMulti(String address, {LatLng? bias}) async {
    try {
      final results = await locationFromAddress(address);
      if (results.isNotEmpty) {
        final loc = results.first;
        return LatLng(loc.latitude, loc.longitude);
      }
    } catch (_) {}

    try {
      final q = Uri.encodeQueryComponent(address);
      final url = Uri.parse(
        'https://geocoding-api.open-meteo.com/v1/search?name=$q&count=1&language=en&format=json',
      );
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

    try {
      final q = Uri.encodeQueryComponent(address);
      final base = 'https://photon.komoot.io/api/?q=$q&limit=1&lang=en';
      final url = (bias != null)
          ? Uri.parse('$base&lat=${bias.latitude}&lon=${bias.longitude}')
          : Uri.parse(base);
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

    try {
      final q = Uri.encodeQueryComponent(address);
      final url = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=$q&format=json&limit=1',
      );
      final res = await http.get(
        url,
        headers: {
          'User-Agent': 'Quopon/1.0 (contact: youremail@example.com)',
          'Accept': 'application/json',
        },
      );
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

      // A) user location
      await _ensureLocationPermission();
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final userLL = LatLng(pos.latitude, pos.longitude);
      await _updateLocationLabelFrom(pos);
      final dist = Distance();

      // B) who is the user? (premium affects blur)
      final profileRes = await BaseClient.getRequest(
        api:
            'http://10.10.13.99:8090/food/my-profile/',
        headers: headers,
      );
      bool isUserPremium = false;
      if (profileRes.statusCode >= 200 && profileRes.statusCode < 300) {
        final Map<String, dynamic> p =
            json.decode(profileRes.body) as Map<String, dynamic>;
        final sub = (p['subscription_status'] ?? '')
            .toString()
            .trim()
            .toLowerCase();
        isUserPremium = sub == 'active';
      }

      // C) deals (deliverable)
      final dealsRes = await BaseClient.getRequest(
        api:
            'http://10.10.13.99:8090/vendors/all-vendor-deals/',
        headers: headers,
      );
      if (dealsRes.statusCode < 200 || dealsRes.statusCode >= 300) {
        throw 'Failed to fetch deals (${dealsRes.statusCode})';
      }
      final List<dynamic> deals = json.decode(dealsRes.body) as List<dynamic>;

      // D) vendors (map by user_id == vendor_id)
      final vendorsRes = await BaseClient.getRequest(
        api:
            'http://10.10.13.99:8090/vendors/all-business-profile/',
        headers: headers,
      );
      final Map<int, Map<String, dynamic>> vendorByUserId = {};
      if (vendorsRes.statusCode >= 200 && vendorsRes.statusCode < 300) {
        final List<dynamic> vendors =
            json.decode(vendorsRes.body) as List<dynamic>;
        for (final v in vendors) {
          final vm = v as Map<String, dynamic>;
          final uid = (vm['user_id'] is int)
              ? vm['user_id'] as int
              : (vm['vendor_id'] is int ? vm['vendor_id'] as int : -1);
          if (uid != -1) {
            vendorByUserId[uid] = vm;
            _vendorCategory[uid] = vm['category'] as int?;
          }
        }
      }

      // E) map to SpeedyDeliveries
      final items = <SpeedyDeliveries>[];
      for (final raw in deals) {
        final m = raw as Map<String, dynamic>;

        final active = m['is_active'] == true;
        if (!active) continue;
        final redem = (m['redemption_type'] ?? '')
            .toString()
            .trim()
            .toUpperCase();
        if (!(redem == 'DELIVERY' || redem == 'BOTH')) continue;

        final userId = (m['user_id'] is int) ? m['user_id'] as int : -1;
        if (userId == -1) continue;
        final vendor = vendorByUserId[userId];
        if (vendor == null) continue;

        // vendor coords
        LatLng? vendorLL;
        if (vendor['lat'] is num && vendor['lng'] is num) {
          vendorLL = LatLng(
            (vendor['lat'] as num).toDouble(),
            (vendor['lng'] as num).toDouble(),
          );
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
        if (km > _nearRadiusKm) continue;

        // normalize costs & record fees for sorting later
        final List<dynamic> rawCosts =
            (m['delivery_costs'] as List<dynamic>? ?? []);
        final fee = _effectiveFeeForCosts(rawCosts);
        final prevFee = _vendorEffectiveFee[userId];
        if (prevFee == null || fee < prevFee) _vendorEffectiveFee[userId] = fee;

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

        final miles = (km * 0.621371).toStringAsFixed(1);

        items.add(
          SpeedyDeliveries(
            id: m['id'] as int,
            userId: userId,
            email: _norm(m['email'] ?? vendor['vendor_email']),
            linkedMenuItem:
                (m['linked_menu_item']
                    as int), // <-- keep linked menu id if your model supports it
            title: _norm(m['title'] ?? m['offers']),
            description: _norm(m['description']),
            imageUrl: _norm(m['image_url']),
            discountValue: _norm(
              m['discount_value'] ?? m['discount_value_free'] ?? '0',
            ),
            startDate: DateTime.parse(m['start_date'].toString()),
            endDate: DateTime.parse(m['end_date'].toString()),
            redemptionType: redem,
            dealType: normalizedDealType,
            maxCouponsTotal: (m['max_coupons_total'] ?? 0) as int,
            maxCouponsPerCustomer: (m['max_coupons_per_customer'] ?? 0) as int,
            deliveryCosts: rawCosts
                .map((e) => DeliveryCostBN.fromJson(e as Map<String, dynamic>))
                .toList(),
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

        (_dealsByUserId[userId] ??= []).add(m);
      }

      // sort by fastest ETA, then distance
      items.sort((a, b) {
        final c = a.deliveryTimeMinutes.compareTo(b.deliveryTimeMinutes);
        if (c != 0) return c;
        final da = double.tryParse(a.distanceMiles) ?? 0;
        final db = double.tryParse(b.distanceMiles) ?? 0;
        return da.compareTo(db);
      });

      final top = items.take(_nearLimit).toList();

      _allSpeedy
        ..clear()
        ..addAll(top);

      _applyFilters();
    } catch (e) {
      debugPrint('Error fetching speedy deliveries: $e');
    }
  }

  // ---------------- Filter + sort pipeline ----------------

  void _applyFilters() {
    // If search active, keep search-selected lists, don't override them
    if (searchMode.value != SearchMode.none &&
        _lc(currentQuery.value).isNotEmpty) {
      return;
    }

    // Start from masters
    var beyond = List<BeyondNeighbourhood>.from(_allBeyond);
    var near = List<NearShops>.from(_allNear);
    var speedy = List<SpeedyDeliveries>.from(_allSpeedy);

    // Category filter first
    final int? catId = selectedCategoryId.value;
    if (catId != null) {
      bool vendorInCategory(int uid) {
        final vc = _vendorCategory[uid];
        return vc != null && vc == catId;
      }

      beyond = beyond.where((b) => vendorInCategory(b.userId)).toList();
      speedy = speedy.where((s) => vendorInCategory(s.userId)).toList();
      near = near.where((n) => n.category == catId).toList();
    }

    // 1) Pick-up
    if (filterPickup.value) {
      bool dealPass(Object? rt) => _isPickupOrBoth(rt);
      beyond = beyond.where((b) => dealPass(b.redemptionType)).toList();
      speedy = speedy.where((s) => dealPass(s.redemptionType)).toList();
      near = near.where((n) {
        final deals = _dealsByUserId[n.vendorId] ?? const [];
        return deals.any((d) => dealPass(d['redemption_type']));
      }).toList();
    }

    // 2) Offers
    if (filterOffers.value) {
      near = near.where((n) {
        final deals = _dealsByUserId[n.vendorId] ?? const [];
        return deals.any((d) => d['is_active'] == true);
      }).toList();
    }

    // 3) Under 30 mins
    int _etaForBeyond(BeyondNeighbourhood b) {
      final preset = b.deliveryTimeMinutes;
      if (preset != null) return preset;
      final km = _vendorDistanceKm[b.userId];
      if (km == null) return 999;
      return _estimateDeliveryMinutes(km);
    }

    if (filterUnder30.value) {
      beyond = beyond.where((b) => _etaForBeyond(b) < 30).toList();
      speedy = speedy.where((s) => s.deliveryTimeMinutes < 30).toList();

      near = near.where((n) {
        final status = vendorStatus[n.vendorId];
        if (status != null) {
          final min = _minFromStatus(status);
          if (min != null) return min < 30;
        }
        final km = _vendorDistanceKm[n.vendorId];
        if (km == null) return false;
        final eta = _estimateDeliveryMinutes(km);
        return eta < 30;
      }).toList();
    }

    // 4) Delivery Fee sort
    num _feeOfBeyond(BeyondNeighbourhood b) {
      final f = _tryParseDouble(b.deliveryFee, fallback: double.nan);
      if (!f.isNaN) return f;
      return _feeForVendor(b.userId);
    }

    num _feeOfSpeedy(SpeedyDeliveries s) {
      final f = _tryParseDouble(s.deliveryFee, fallback: double.nan);
      if (!f.isNaN) return f;
      return _feeForVendor(s.userId);
    }

    num _feeOfNear(NearShops n) {
      return _feeForVendor(n.vendorId);
    }

    final ascending = !deliveryHighToLow.value;
    int _asc(num a, num b) => a.compareTo(b);
    int _desc(num a, num b) => b.compareTo(a);

    if (ascending) {
      beyond.sort((a, b) => _asc(_feeOfBeyond(a), _feeOfBeyond(b)));
      speedy.sort((a, b) => _asc(_feeOfSpeedy(a), _feeOfSpeedy(b)));
      near.sort((a, b) => _asc(_feeOfNear(a), _feeOfNear(b)));
    } else {
      beyond.sort((a, b) => _desc(_feeOfBeyond(a), _feeOfBeyond(b)));
      speedy.sort((a, b) => _desc(_feeOfSpeedy(a), _feeOfSpeedy(b)));
      near.sort((a, b) => _desc(_feeOfNear(a), _feeOfNear(b)));
    }

    // Push to UI
    beyondNeighbourhood.assignAll(beyond);
    speedyDeliveries.assignAll(speedy);
    nearShops.assignAll(near);
  }

  // ---------------- SEARCH PIPELINE (UPDATED: returns bool) ----------------
  Future<bool> runSearch(String query) async {
    currentQuery.value = query;
    final q = _lc(query);
    if (q.isEmpty) {
      // Clear search → show normal filtered lists
      searchMode.value = SearchMode.none;
      _applyFilters();
      return false; // not a "successful search"
    }

    searching.value = true;

    try {
      // 1) Vendor name match
      final vendorMatches = <int>{};
      for (final n in _allNear) {
        if (_contains(_lc(n.name), q)) vendorMatches.add(n.vendorId);
      }
      final Map<int, String> vendorNameMap = {};
      for (final n in _allNear) {
        vendorNameMap[n.vendorId] = n.name;
      }
      for (final b in _allBeyond) {
        if (b.name.isNotEmpty) vendorNameMap[b.userId] = b.name;
      }
      for (final s in _allSpeedy) {
        if (s.name.isNotEmpty) vendorNameMap[s.userId] = s.name;
      }
      vendorNameMap.forEach((vid, name) {
        if (_contains(_lc(name), q)) vendorMatches.add(vid);
      });

      if (vendorMatches.isNotEmpty) {
        searchMode.value = SearchMode.vendor;

        final near = _allNear
            .where((e) => vendorMatches.contains(e.vendorId))
            .toList();
        final beyond = _allBeyond
            .where((e) => vendorMatches.contains(e.userId))
            .toList();
        final speedy = _allSpeedy
            .where((e) => vendorMatches.contains(e.userId))
            .toList();

        beyondNeighbourhood.assignAll(beyond);
        nearShops.assignAll(near);
        speedyDeliveries.assignAll(speedy);
        return true;
      }

      // 2) Deal title match
      final beyondDealMatches = _allBeyond
          .where((e) => _contains(_lc(e.offers), q))
          .toList();
      final speedyDealMatches = _allSpeedy
          .where((e) => _contains(_lc(e.offers), q))
          .toList();

      if (beyondDealMatches.isNotEmpty || speedyDealMatches.isNotEmpty) {
        searchMode.value = SearchMode.deal;

        final vendorIds = <int>{};
        for (final e in beyondDealMatches) {
          vendorIds.add(e.userId);
        }
        for (final e in speedyDealMatches) {
          vendorIds.add(e.userId);
        }

        final near = _allNear
            .where((e) => vendorIds.contains(e.vendorId))
            .toList();

        beyondNeighbourhood.assignAll(beyondDealMatches);
        speedyDeliveries.assignAll(speedyDealMatches);
        nearShops.assignAll(near);
        return true;
      }

      // 3) Menu name search
      searchMode.value = SearchMode.menu;

      final matchedVendorIds = <int>{};
      final matchedMenuIds = <int>{};

      final vendors = _knownVendorIds().toList();
      for (final vid in vendors) {
        await _ensureMenusLoadedForVendor(vid);
        final mids = _vendorMenuIds[vid];
        if (mids == null || mids.isEmpty) continue;
        bool vendorHasMatch = false;
        for (final mid in mids) {
          final name = _lc(_menuNameById[mid]);
          if (name.isNotEmpty && _contains(name, q)) {
            vendorHasMatch = true;
            matchedMenuIds.add(mid);
          }
        }
        if (vendorHasMatch) matchedVendorIds.add(vid);
      }

      if (matchedVendorIds.isNotEmpty || matchedMenuIds.isNotEmpty) {
        final near = _allNear
            .where((e) => matchedVendorIds.contains(e.vendorId))
            .toList();

        final beyond = _allBeyond.where((e) {
          if ((e.linkedMenuItem ?? 0) > 0) {
            return matchedMenuIds.contains(e.linkedMenuItem!);
          }
          return matchedVendorIds.contains(e.userId);
        }).toList();

        final speedy = _allSpeedy.where((e) {
          if ((e.linkedMenuItem ?? 0) > 0) {
            return matchedMenuIds.contains(e.linkedMenuItem!);
          }
          return matchedVendorIds.contains(e.userId);
        }).toList();

        beyondNeighbourhood.assignAll(beyond);
        nearShops.assignAll(near);
        speedyDeliveries.assignAll(speedy);
        return true;
      }

      // No matches anywhere → clear lists
      beyondNeighbourhood.clear();
      nearShops.clear();
      speedyDeliveries.clear();
      return false;
    } finally {
      searching.value = false;
    }
  }

  // --- helpers for search ---
  Future<void> _ensureMenusLoadedForVendor(int vendorId) async {
    if (_vendorMenuIds[vendorId]?.isNotEmpty == true) return;

    try {
      final headers = await BaseClient.authHeaders();
      final uri = Uri.parse(
        'http://10.10.13.99:8090/vendors/deals/?user_id=$vendorId',
      );
      final res = await BaseClient.getRequest(
        api: uri.toString(),
        headers: headers,
      );
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final List list = jsonDecode(res.body) as List;
        final ids = <int>{};
        for (final raw in list) {
          final m = raw as Map<String, dynamic>;
          final mid = (m['id'] ?? m['linked_menu_item'] ?? 0) as int;
          final title = (m['title'] ?? '').toString();
          if (mid > 0 && title.isNotEmpty) {
            _menuNameById[mid] = title;
            ids.add(mid);
          }
        }
        if (ids.isNotEmpty) {
          _vendorMenuIds[vendorId] = ids;
        }
      }
    } catch (_) {
      /* ignore */
    }
  }

  Set<int> _knownVendorIds() {
    final s = <int>{};
    s.addAll(_vendorCategory.keys);
    s.addAll(_vendorDistanceKm.keys);
    for (final b in _allBeyond) {
      s.add(b.userId);
    }
    for (final sdy in _allSpeedy) {
      s.add(sdy.userId);
    }
    for (final n in _allNear) {
      s.add(n.vendorId);
    }
    return s;
  }

  // ---------------- Public actions ----------------
  void togglePickup() {
    filterPickup.toggle();
    _applyFilters();
  }

  void toggleOffers() {
    filterOffers.toggle();
    _applyFilters();
  }

  void toggleUnder30() {
    filterUnder30.toggle();
    _applyFilters();
  }

  void toggleDeliveryFeeSort() {
    sortTouched.value = true;
    deliveryHighToLow.value = !deliveryHighToLow.value;
    _applyFilters();
  }

  void onCategoryTap(int categoryId) {
    if (selectedCategoryId.value == categoryId) {
      selectedCategoryId.value = null; // deselect if same
    } else {
      selectedCategoryId.value = categoryId;
    }
    _applyFilters();
  }

  Future<void> refreshAll() async {
    // re-run the four feeds; run them concurrently
    await Future.wait([
      fetchVendorCategories(),
      fetchBeyondNeighbourhood(),
      fetchNearShops(),
      fetchSpeedyDeliveries(),
    ]).catchError((_) {});
    // statuses recompute on fetches; _applyFilters() already called in each
  }

  // ---------------- Lifecycle ----------------
  @override
  void onInit() {
    super.onInit();
    fetchVendorCategories();
    fetchBeyondNeighbourhood();
    fetchNearShops();
    fetchSpeedyDeliveries();
  }

  @override
  void onClose() {
    _statusTicker?.cancel();
    super.onClose();
  }
}

// Helper for near shops construction
class _NearTmp {
  final double distanceKm;
  final Map<String, dynamic> json;
  _NearTmp({required this.distanceKm, required this.json});
}

// Local Category class (unchanged)
class Category {
  final int id;
  final String name;
  final String imageUrl;

  Category({required this.id, required this.name, required this.imageUrl});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
    );
  }
}
