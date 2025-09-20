import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:quopon/app/data/base_client.dart';

import '../../../data/api_client.dart';

class ReportProblemController extends GetxController {
  // ---------- Static categories (label -> id) ----------
  static const List<String> categories = <String>[
    'Account & Profile',
    'Redeeming Deals',
    'Qoupon+ Membership',
    'Payment & Billing',
    'Location & Notifications',
  ];

  static const Map<String, int> _catToId = {
    'Account & Profile': 1,
    'Redeeming Deals': 2,
    'Qoupon+ Membership': 3,
    'Payment & Billing': 4,
    'Location & Notifications': 5,
  };

  // ---------- Form state ----------
  final selectedCategory = 'Account & Profile'.obs; // default
  final description = ''.obs;

  // 🔹 image picker state
  final ImagePicker _picker = ImagePicker();
  final Rxn<XFile> profileImage = Rxn<XFile>(); // null = not picked yet

  static const String _profileUploadPath = '/vendors/upload/';
  static const String _profileImageField = 'image'; // <-- must be "image"
  final isUploading = false.obs;

  // ---------- Submit state ----------
  final isSubmitting = false.obs;

  // ---------- UI setters ----------
  void setCategory(String name) => selectedCategory.value = name;
  void setDescription(String text) => description.value = text.trim();

  /// POST /vendors/upload/ (field: image)
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

  /// POST /support/report-issue/
  /// Expected fields:
  /// - issue_type (int)
  /// - description (string)
  /// - screenshot_url (string, optional)
  Future<bool> submitReport() async {
    if (isSubmitting.value) return false;

    // Upload image to get the URL
    final headers = await BaseClient.authHeaders();
    print(headers);

    final imageUrl = await _uploadProfileImageAndGetUrl();

    final issueTypeId = _catToId[selectedCategory.value] ?? 1;

    print(imageUrl);

    final body = <String, dynamic>{
      'issue_type': issueTypeId,              // ✅ correct key
      'description': description.value,
      if (imageUrl != null) 'screenshot': imageUrl,
    };

    print(body);

    isSubmitting.value = true;
    try {
      final res = await ApiClient.post('/support/report-issue/', body);
      print(res.statusCode);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return true;
      } else {
        Get.snackbar('Error', 'Submit failed (${res.statusCode})\n${res.body}');
        return false;
      }
    } catch (e) {
      Get.snackbar('Network', 'Submit failed: $e');
      return false;
    } finally {
      isSubmitting.value = false;

    }
  }
}
