import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quopon/app/data/api_client.dart';

import '../../../data/api.dart'; // adjust to your project
import '../../../data/model/business_profile.dart';

class VendorPin {
  final BusinessProfile vendor;
  final LatLng position;
  final double distanceKm;

  VendorPin({required this.vendor, required this.position, required this.distanceKm});
}

class DiscoverController extends GetxController {
  // UI toggles you already had
  RxBool isMap = true.obs;
  RxBool isDelivery = true.obs;

  // Filters you already had (kept as-is, but unused in this step)
  RxList<RxBool> selectedCuisine = [false.obs, true.obs, false.obs, false.obs, false.obs, false.obs, true.obs, false.obs, false.obs].obs;
  RxList<RxBool> selectedDiet = [false.obs, true.obs, false.obs].obs;
  RxList<RxBool> selectedPrice = [false.obs, true.obs, false.obs].obs;
  RxList<RxBool> selectedRating = [false.obs, false.obs, true.obs, true.obs].obs;

  // Data/state
  final isLoading = false.obs;
  final error = RxnString();
  final allVendors = <BusinessProfile>[].obs;
  final nearbyPins = <VendorPin>[].obs;

  final userLocation = Rxn<LatLng>();
  final mapCenter = Rx<LatLng>(LatLng(23.7808875, 90.2792371)); // Dhaka default
  final mapZoom = 13.0.obs;

  // Config
  final radiusKm = 5.0.obs; // radius for "surroundings"

  // Simple in-memory geocode cache
  final Map<String, LatLng> _geocodeCache = {};

  @override
  void onReady() {
    super.onReady();
    _bootstrap();
  }

  Future<void> refreshAll() async {
    await _bootstrap(); // same sequence you already use on first load
  }

  Future<void> _bootstrap() async {
    isLoading.value = true;
    error.value = null;
    try {
      await _ensureLocationPermission();
      await _getUserLocation();
      await _fetchVendors();
      await _geocodeMissingVendors();
      _filterByRadius();
      _maybeFocusOnUser();
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _ensureLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled.';
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever || permission == LocationPermission.denied) {
      throw 'Location permission denied.';
    }
  }

  Future<void> _getUserLocation() async {
    final pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final ll = LatLng(pos.latitude, pos.longitude);
    userLocation.value = ll;
    mapCenter.value = ll;
  }

  Future<void> _fetchVendors() async {
    // Your API root helper; replace if needed
    final url = Uri.parse('${Api.baseUrl}/vendors/all-business-profile/'); // adjust Api.baseUrl
    final res = await http.get(url, headers: await ApiClient.authHeaders());
    print(res.statusCode);
    if (res.statusCode != 200) throw 'Failed to fetch vendors (${res.statusCode})';

    final List data = jsonDecode(res.body) as List;
    allVendors.assignAll(data.map((e) => BusinessProfile.fromJson(e)).toList());
  }

  Future<void> _geocodeMissingVendors() async {
    // IMPORTANT (PROD): Move geocoding server-side & store lat/lng.
    for (int i = 0; i < allVendors.length; i++) {
      final v = allVendors[i];
      // Already geocoded?
      if (v.lat != null && v.lng != null) continue;

      if (v.address.trim().isEmpty) continue;

      final cached = _geocodeCache[v.address];
      LatLng? pos;
      if (cached != null) {
        pos = cached;
      } else {
        pos = await _geocodeAddressNominatim(v.address);
        if (pos != null) _geocodeCache[v.address] = pos;
        // Be nice to Nominatim. Small delay helps if many addresses.
        await Future.delayed(const Duration(milliseconds: 250));
      }

      if (pos != null) {
        allVendors[i] = v.copyWith(lat: pos.latitude, lng: pos.longitude);
      }
    }
  }

  Future<LatLng?> _geocodeAddressNominatim(String address) async {
    // Very basic Nominatim usage (for dev/demo). Add country bias if you want.
    final encoded = Uri.encodeQueryComponent(address);
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/search?q=$encoded&format=json&limit=1',
    );
    final res = await http.get(url, headers: {
      'User-Agent': 'Quopon/1.0 (contact: youremail@example.com)',
      'Accept': 'application/json',
    });
    if (res.statusCode != 200) return null;
    final List j = jsonDecode(res.body);
    if (j.isEmpty) return null;
    final lat = double.tryParse(j[0]['lat'] ?? '');
    final lon = double.tryParse(j[0]['lon'] ?? '');
    if (lat == null || lon == null) return null;
    return LatLng(lat, lon);
  }

  void _filterByRadius() {
    final u = userLocation.value;
    if (u == null) return;

    final d = Distance();
    final pins = <VendorPin>[];
    for (final v in allVendors) {
      if (v.lat == null || v.lng == null) continue;
      final pos = LatLng(v.lat!, v.lng!);
      final meters = d(u, pos);
      final km = meters / 1000.0;
      if (km <= radiusKm.value) {
        pins.add(VendorPin(vendor: v, position: pos, distanceKm: double.parse(km.toStringAsFixed(2))));
      }
    }
    // Sort by nearest
    pins.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
    nearbyPins.assignAll(pins);
  }

  void _maybeFocusOnUser() {
    final u = userLocation.value;
    if (u != null) {
      mapCenter.value = u;
      mapZoom.value = 14.0;
    }
  }

  // Call when user toggles radius from a UI control (optional)
  void updateRadius(double km) {
    radiusKm.value = km;
    _filterByRadius();
  }
}
