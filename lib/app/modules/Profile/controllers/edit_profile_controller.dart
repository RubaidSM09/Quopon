// lib/app/modules/Profile/controllers/edit_profile_controller.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quopon/app/data/api/profile_api.dart';
import 'package:quopon/app/data/model/user_profile.dart';
import '../../../data/api_client.dart';
import '../../../data/base_client.dart';
import 'country_city_controller.dart';

class EditProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final fullNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final addressCtrl = TextEditingController();

  final profilePictureUrl = ''.obs;
  final subscriptionStatus = ''.obs;

  // 🔹 image picker state
  final ImagePicker _picker = ImagePicker();
  final Rxn<XFile> profileImage = Rxn<XFile>(); // null = not picked yet

  static const String _profileUploadPath = '/vendors/upload/';
  static const String _profileImageField = 'image'; // <-- must be "image"

  final isLoading = false.obs;
  final isSaving = false.obs;
  final error = RxnString();

  late final CountryCityController cc;

  @override
  void onInit() {
    super.onInit();
    cc = Get.put(CountryCityController(), permanent: true);
    loadProfile();
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
      final headers = await BaseClient.authHeaders(); // includes token if needed
      final uri = Uri.parse('https://intensely-optimal-unicorn.ngrok-free.app/vendors/upload/');
      final req = http.MultipartRequest('POST', uri);

      // Important: DO NOT set 'Content-Type' manually here; http will set multipart boundary.
      req.headers.addAll(headers);

      final lower = xfile.name.toLowerCase();
      final mime = lower.endsWith('.png')
          ? 'image/png'
          : lower.endsWith('.webp')
          ? 'image/webp'
          : 'image/jpeg';

      req.files.add(await http.MultipartFile.fromPath(
        'image',          // <-- backend field name
        xfile.path,
        contentType: MediaType.parse(mime), // import 'package:http_parser/http_parser.dart';
        filename: xfile.name,
      ));

      final streamed = await req.send();
      final resp = await http.Response.fromStream(streamed);

      if (resp.statusCode >= 200 && resp.statusCode < 300) {
        final body = json.decode(resp.body);
        // Accept common keys: {image: "..."} or {url: "..."} or {profile_picture_url: "..."}
        final url = (body['image'] ?? body['url'] ?? body['profile_picture_url'])?.toString();
        if (url != null && url.isNotEmpty) return url;

        Get.snackbar('Upload', 'Upload succeeded but URL not found in response.');
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

  Future<void> loadProfile() async {
    try {
      isLoading.value = true;
      error.value = null;
      final p = await ProfileApi.fetch();

      fullNameCtrl.text = p.fullName;
      emailCtrl.text = p.email;
      phoneCtrl.text = p.phoneNumber;
      addressCtrl.text = p.address;
      profilePictureUrl.value = p.profilePictureUrl;
      subscriptionStatus.value = p.subscriptionStatus;

      cc.hydrateFromProfile(
        country: p.country.isEmpty ? 'United States of America' : p.country,
        city: p.city,
      );
    } catch (e) {
      error.value = e.toString();
      Get.snackbar('Error', 'Failed to load profile');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> save() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    try {
      isSaving.value = true;
      error.value = null;

      // 1) Upload only if the user picked a new file
      String? uploadedUrl;
      if (profileImage.value != null) {
        uploadedUrl = await _uploadProfileImageAndGetUrl();
        if (uploadedUrl == null) {
          Get.snackbar('Profile picture', 'Upload failed. Keeping previous picture.');
        }
      }

      // 2) Decide the final photo URL for PUT (do NOT mutate/trim it)
      //    - If a new one uploaded, use it
      //    - Else keep exactly what you hydrated from server
      final String finalPhotoUrl = (uploadedUrl != null && uploadedUrl.isNotEmpty)
          ? uploadedUrl
          : profilePictureUrl.value; // keep as-is

      // 3) Build the payload for PUT (only trim human-entered fields)
      final p = UserProfile(
        email: emailCtrl.text.trim(),
        fullName: fullNameCtrl.text.trim(),
        phoneNumber: phoneCtrl.text.trim(),
        profilePictureUrl: finalPhotoUrl, // unchanged unless new upload
        country: cc.selectedCountry.value.trim(),
        city: cc.selectedCity.value.trim(),
        address: addressCtrl.text.trim(),
        subscriptionStatus: subscriptionStatus.value, // keep as-is
      );

      await ProfileApi.update(p);

      // 4) Reflect locally
      profilePictureUrl.value = finalPhotoUrl;
      Get.snackbar('Success', 'Profile updated');

      // Clear temp picked file
      profileImage.value = null;
    } catch (e) {
      error.value = e.toString();
      Get.snackbar('Error', 'Could not save profile');
    } finally {
      isSaving.value = false;
    }
  }

  @override
  void onClose() {
    fullNameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    addressCtrl.dispose();
    super.onClose();
  }
}
