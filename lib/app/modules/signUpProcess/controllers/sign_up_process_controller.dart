// lib/app/modules/signUpProcess/controllers/sign_up_process_controller.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:quopon/app/modules/landing/views/landing_view.dart';

import '../../../data/api_client.dart';
import '../../../data/model/food_category.dart';

class SignUpProcessController extends GetxController {
  // ===== EXISTING =====
  final pageController = PageController();
  final currentPage = 0.obs;

  final addressController =
  TextEditingController(text: '9 Victoria Road London SE73 1XL');
  final marker = Rx<LatLng?>(LatLng(51.4769, 0.0005));
  final isGeocoding = false.obs;
  final geocodeError = RxnString();

  // ===== NEW: user context (set this from login or interim form) =====
  final userEmail = 'admin@gmail.com'.obs; // <- replace at runtime if you have it
  final fullName = ''.obs;
  final phoneNumber = ''.obs;
  final language = 'English'.obs;
  final country = ''.obs;
  final city = ''.obs;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  // ===== Page 1: food categories =====
  final categories = <FoodCategoryModel>[].obs;
  final selectedCategoryNames = <String>{}.obs;
  final isLoadingCategories = false.obs;
  final isSubmittingFavorites = false.obs;

  // ===== Page 2/3: update profile/address =====
  final isSubmittingProfile = false.obs;

  // 🔹 image picker state
  final ImagePicker _picker = ImagePicker();
  final Rxn<XFile> profileImage = Rxn<XFile>(); // null = not picked yet

  static const String _profileUploadPath = '/vendors/upload/';
  static const String _profileImageField = 'image'; // <-- must be "image"

  // ---------------- LIFECYCLE ----------------
  @override
  void onInit() {
    super.onInit();
    _fetchCategories(); // load for page 1
  }

  @override
  void onClose() {
    pageController.dispose();
    addressController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  // ---------------- UI callbacks ----------------
  void onPageChanged(int index) => currentPage.value = index;

  Future<void> nextPage() async {
    final idx = currentPage.value;

    // Gate each page transition with the required API call
    if (idx == 0) {
      final ok = await submitFavoriteCategories();
      if (!ok) return;
    } else if (idx == 1) {
      final ok = await updateAddressOnly();
      if (!ok) return;
    }

    if (idx < 2) {
      await pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Future<void> finishOnboarding() async {
    // before PUT, capture field values if you haven't already
    fullName.value = nameController.text.trim();
    phoneNumber.value = phoneController.text.trim();

    // 1) Upload image if any
    String? photoUrl;
    if (profileImage.value != null) {
      photoUrl = await _uploadProfileImageAndGetUrl();
      if (photoUrl == null) {
        // optional: let user proceed without image
        Get.snackbar('Profile picture', 'Using default picture (upload failed).');
      }
    }

    // 2) PUT profile with the URL (or null)
    final ok = await updateFullProfile(profileUrl: photoUrl);
    if (!ok) return;

    // 3) Navigate away
    Get.to(LandingView());
  }

  // ---------------- Map -> Reverse geocode (EXISTING) ----------------
  Future<void> onMapTap(LatLng latLng) async {
    marker.value = latLng;
    await _reverseGeocode(latLng);
  }

  Future<void> _reverseGeocode(LatLng latLng) async {
    isGeocoding.value = true;
    geocodeError.value = null;

    final uri = Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=${latLng.latitude}&lon=${latLng.longitude}');
    try {
      final res = await http.get(uri, headers: {
        'User-Agent': 'QuoponTestApp/1.0 (mailto:dev@example.com)',
        'Accept': 'application/json',
      });
      if (res.statusCode == 200) {
        final data = json.decode(res.body) as Map<String, dynamic>;
        final displayName = (data['display_name'] ?? '').toString();
        if (displayName.isNotEmpty) {
          addressController.text = displayName;
        } else {
          geocodeError.value = 'No address found for this point.';
        }
      } else {
        geocodeError.value = 'Reverse geocode failed (${res.statusCode}).';
      }
    } catch (e) {
      geocodeError.value = 'Network error: $e';
    } finally {
      isGeocoding.value = false;
    }
  }

  // ---------------- API: GET categories ----------------
  Future<void> _fetchCategories() async {
    isLoadingCategories.value = true;
    try {
      final r = await ApiClient.get('/food/food-categories/');
      print(r.statusCode);
      if (r.statusCode == 200) {
        final list = (json.decode(r.body) as List)
            .map((e) => FoodCategoryModel.fromJson(e))
            .toList();
        categories.assignAll(list);
      } else {
        Get.snackbar('Error', 'Failed to load categories (${r.statusCode})');
      }
    } catch (e) {
      Get.snackbar('Network', 'Failed to load categories: $e');
    } finally {
      isLoadingCategories.value = false;
    }
  }

  // ---------------- API: POST favorite categories ----------------
  Future<bool> submitFavoriteCategories() async {
    if (selectedCategoryNames.isEmpty) {
      // optional: allow empty, or block submit
      // return true;
    }
    isSubmittingFavorites.value = true;
    try {
      final body = {
        'user_email': userEmail.value,
        'favorite_category_names': selectedCategoryNames.toList(),
      };
      final r = await ApiClient.post('/food/user-fvt-categories/', body);
      if (r.statusCode == 200 || r.statusCode == 201) {
        // success response contains success_msg
        return true;
      } else {
        Get.snackbar('Error', 'Could not save favorites (${r.statusCode})');
        return false;
      }
    } catch (e) {
      Get.snackbar('Network', 'Could not save favorites: $e');
      return false;
    } finally {
      isSubmittingFavorites.value = false;
    }
  }

  // ---------------- API: PUT address only (page 2) ----------------
  Future<bool> updateAddressOnly() async {
    isSubmittingProfile.value = true;
    try {
      // build payload safely
      final Map<String, dynamic> body = {
        'email': userEmail.value.trim(),
        // send empty strings instead of nulls where serializer might disallow null
        'full_name': (fullName.value).trim(),           // '' if not set
        'phone_number': (phoneNumber.value).trim(),     // '' if not set
        'language': (language.value).trim().isEmpty ? 'English' : language.value.trim(),
        // backend sample accepts null here; keep null or '' if your server dislikes nulls
        'profile_picture_url': null,
        'country': country.value,                        // '' or 'bd'
        'city': city.value,                              // '' allowed
        'address': addressController.text.trim(),        // <- REQUIRED here
      };

      // remove keys with null values (keeps empty strings)
      body.removeWhere((k, v) => v == null);

      final r = await ApiClient.put('/food/my-profile/', body);

      if (r.statusCode == 200) {
        return true;
      }

      // surface server message so we know *why* it’s 400
      String msg = 'Could not update address (${r.statusCode}).';
      try {
        final j = json.decode(r.body);
        msg += '\n${j is Map ? j.toString() : r.body}';
      } catch (_) {
        msg += '\n${r.body}';
      }
      Get.snackbar('Error', msg, snackPosition: SnackPosition.BOTTOM);
      return false;

    } catch (e) {
      Get.snackbar('Network', 'Could not update address: $e', snackPosition: SnackPosition.BOTTOM);
      return false;
    } finally {
      isSubmittingProfile.value = false;
    }
  }

  Future<void> pickProfileImage() async {
    try {
      final XFile? img = await _picker.pickImage(

        source: ImageSource.gallery,
        imageQuality: 85, // smaller file size
      );
      if (img != null) {
        profileImage.value = img;
        // If your backend later needs an URL, you'll upload this file and set profile_picture_url
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  Future<String?> _uploadProfileImageAndGetUrl() async {
    final xfile = profileImage.value;
    if (xfile == null) return null;

    try {
      // read bytes
      final bytes = await xfile.readAsBytes();

      // guess mime from extension
      final lower = xfile.name.toLowerCase();
      final mime = lower.endsWith('.png')
          ? 'image/png'
          : lower.endsWith('.webp')
          ? 'image/webp'
          : 'image/jpeg';

      final streamed = await ApiClient.uploadMultipart(
        path: _profileUploadPath,
        fieldName: _profileImageField,
        bytes: bytes,
        filename: xfile.name,
        mimeType: mime,
        // Optionally add extra fields if your backend needs them
        // fields: {'folder': 'profile_pictures'},
      );

      final resp = await http.Response.fromStream(streamed);
      print(resp.statusCode);

      if (resp.statusCode >= 200 && resp.statusCode < 300) {
        final body = json.decode(resp.body);
        if (body is Map && body['image'] != null) {
          final url = body['image'].toString();
          return url;
        }
        Get.snackbar('Upload', 'Upload succeeded but no image URL found.');
        return null;
      } else {
        Get.snackbar('Upload failed', 'Status ${resp.statusCode}\n${resp.body}');
        return null;
      }
    } catch (e) {
      Get.snackbar('Upload error', e.toString());
      return null;
    }
  }

  // ---------------- API: PUT full profile (page 3) ----------------
  Future<bool> updateFullProfile({String? profileUrl}) async {
    isSubmittingProfile.value = true;
    try {
      final body = {
        'email': userEmail.value.trim(),
        'full_name': fullName.value,
        'phone_number': phoneNumber.value,
        'language': language.value,
        'profile_picture': profileUrl,
        'country': country.value,
        'city': city.value,
        'address': addressController.text,
      };

      // Remove nulls (keeps empty strings)
      body.removeWhere((k, v) => v == null);

      final r = await ApiClient.put('/food/my-profile/', body);
      if (r.statusCode == 200) {
        return true;
      } else {
        Get.snackbar('Error', 'Profile update failed (${r.statusCode})\n${r.body}');
        return false;
      }
    } catch (e) {
      Get.snackbar('Network', 'Profile update failed: $e');
      return false;
    } finally {
      isSubmittingProfile.value = false;
    }
  }
}
