import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/api/profile_api.dart';
import '../../../data/base_client.dart';
import '../../../data/model/business_hour.dart';

class VendorSideProfileController extends GetxController {
  // Business Profile Data (raw map for quick UI reads)
  var profileData = {}.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController(); // read-only display
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController kvkController = TextEditingController();

  // 🔹 image picker state
  final ImagePicker _picker = ImagePicker();
  final Rxn<XFile> profileImage = Rxn<XFile>(); // null = not picked yet

  final profilePictureUrl = ''.obs;

  static const String _profileUploadPath = '/vendors/upload/';
  static const String _profileImageField = 'image'; // <-- must be "image"

  final RxInt selectedCategoryId = 0.obs;
  final RxList<String> categoryNames = <String>[].obs;
  final RxMap<String, int> nameToId = <String, int>{}.obs;
  final RxString selectedCategoryName = 'Select'.obs;
  void setCategoryId(int id) => selectedCategoryId.value = id;

  // Business hours (UNCHANGED)
  RxString startTime = '08:00'.obs;
  RxString endTime = '17:00'.obs;
  RxList<Schedule> businessSchedule = <Schedule>[].obs;
  RxList<RxString> startTimes = [''.obs].obs;
  RxList<RxString> endTimes = [''.obs].obs;

  bool _hydratedControllers = false;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
    fetchVendorCategories();
    fetchBusinessHours(); // keep your behavior
  }

  Future<void> refreshAll() async {
    await Future.wait([
      fetchProfile(),
      fetchVendorCategories(),
      fetchBusinessHours(),
    ]).catchError((_) {});
    // do not auto-upload; leave picked image as-is
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

  Future<void> fetchProfile() async {
    try {
      // Use API helper (handles list/map)
      final p = await VendorProfileApi.fetch();

      // store raw (helpful for hints/placeholders)
      profileData.value = {
        'id': p.id,
        'vendor_email': p.vendorEmail,
        'vendor_id': p.vendorId,
        'name': p.name,
        'logo_image': p.logoImage,
        'kvk_number': p.kvkNumber,
        'phone_number': p.phoneNumber,
        'address': p.address,
        'category': p.category,
      };

      if (!_hydratedControllers) {
        nameController.text = p.name;
        emailController.text = p.vendorEmail;
        phoneController.text = p.phoneNumber;
        addressController.text = p.address;
        kvkController.text = p.kvkNumber;
        selectedCategoryId.value = p.category;

        _hydratedControllers = true;
      }

      // ✅ hydrate avatar observable so UI shows current logo
      profilePictureUrl.value = p.logoImage ?? '';
    } catch (e) {
      debugPrint('Error fetching vendor profile: $e');
      Get.snackbar('Error', 'Failed to load business profile');
    }
  }

  Future<void> updateProfile() async {
    try {
      // 1) Upload only if user picked a new file
      String? uploadedUrl;
      if (profileImage.value != null) {
        uploadedUrl = await _uploadProfileImageAndGetUrl();
        if (uploadedUrl == null) {
          Get.snackbar('Profile picture', 'Upload failed. Keeping previous picture.');
        }
      }

      // 2) Build PATCH body with text fields only
      final Map<String, dynamic> body = {
        'name': nameController.text.trim(),
        'kvk_number': kvkController.text.trim(),
        'phone_number': phoneController.text.trim(),
        'address': addressController.text.trim(),
        'category': selectedCategoryId.value,
      };

      // 3) Include logo_image ONLY if we actually uploaded a new image
      if (uploadedUrl != null && uploadedUrl.isNotEmpty) {
        // tiny hardening: strip whitespace
        final clean = uploadedUrl.replaceAll(RegExp(r'\s+'), '');
        body['logo'] = clean;
      }

      // Debug (to verify what hits the server)
      debugPrint('PATCH vendor body => ${jsonEncode(body)}');

      // 4) Send exactly this body
      await VendorProfileApi.patchRaw(body);

      // 5) Reflect locally
      if (uploadedUrl != null && uploadedUrl.isNotEmpty) {
        profilePictureUrl.value = uploadedUrl;
      }

      Get.snackbar('Success', 'Business profile updated');

      // 6) Refresh + clear temp pick
      await fetchProfile();
      profileImage.value = null;
    } catch (e) {
      debugPrint('Error updating vendor profile: $e');
      Get.snackbar('Error', 'Failed to update profile');
    }
  }

  // ==== Categories (unchanged, but make sure your API keys match) ====
  Future<void> fetchVendorCategories() async {
    try {
      final headers = await BaseClient.authHeaders();
      final res = await BaseClient.getRequest(
        api: 'https://intensely-optimal-unicorn.ngrok-free.app/vendors/vendor-categories/',
        headers: headers,
      );
      final data = await BaseClient.handleResponse(res) as List<dynamic>;

      final localMap = <String, int>{};
      final localNames = <String>[];

      for (final item in data) {
        final id = item['id'] as int;
        final name = (item['name'] ?? '').toString();
        if (name.isNotEmpty) {
          localMap[name] = id;
          localNames.add(name);
        }
      }

      nameToId.assignAll(localMap);
      categoryNames.assignAll(localNames);

      if (selectedCategoryName.value == 'Select' && localNames.isNotEmpty) {
        // try to set the selected name based on current category id
        final currentId = selectedCategoryId.value;
        final match = localMap.entries.firstWhere(
              (e) => e.value == currentId,
          orElse: () => localMap.entries.first,
        );
        selectedCategoryName.value = match.key;
        selectedCategoryId.value = match.value;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // ==== Business hours code (UNCHANGED) ====
  String _weekdayFromIndex(int i) {
    const names = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
    return (i >= 0 && i < names.length) ? names[i] : 'Monday';
  }

  String _toHHmm(String? v) {
    if (v == null || v.isEmpty) return '';
    if (v.length >= 5) return v.substring(0, 5);
    return v;
  }

  Future<void> fetchBusinessHours() async {
    try {
      String? userId = await BaseClient.getUserId();
      if (userId == null) throw "User ID not found. Please log in again.";

      final apiUrl = 'https://intensely-optimal-unicorn.ngrok-free.app/home/users/$userId/business-hours/';
      final headers = await BaseClient.authHeaders();
      final response = await BaseClient.getRequest(api: apiUrl, headers: headers);

      if (response.statusCode >= 200 && response.statusCode <= 210) {
        final responseBody = json.decode(response.body);
        final businessHour = BusinessHour.fromJson(responseBody);

        businessSchedule.value = businessHour.schedule;
        for (int i = 0; i < businessSchedule.length; i++) {
          final label = _weekdayFromIndex(i);
          businessSchedule[i].day = label;
          businessSchedule[i].dayDisplay = label;
        }

        startTimes.assignAll(businessSchedule.map((s) => _toHHmm(s.openTime).obs).toList());
        endTimes.assignAll(businessSchedule.map((s) => _toHHmm(s.closeTime).obs).toList());
      } else {
        final responseBody = json.decode(response.body);
        throw responseBody['message'] ?? 'Failed to fetch business hours';
      }
    } catch (error) {
      Get.snackbar('Error', error.toString());
    }
  }

  void setIsClosed(int index, bool isClosed) {
    if (index < 0 || index >= businessSchedule.length) return;
    businessSchedule[index].isClosed = isClosed;
    update();
  }

  void setEndTime(int index, String value) {
    if (index < 0 || index >= endTimes.length) return;
    endTimes[index].value = value;
    if (index < businessSchedule.length) businessSchedule[index].closeTime = value;
    update();
  }

  void setStartTime(int index, String value) {
    if (index < 0 || index >= startTimes.length) return;
    startTimes[index].value = value;
    if (index < businessSchedule.length) businessSchedule[index].openTime = value;
    update();
  }

  Future<void> patchBusinessHours() async {
    try {
      final String? userId = await BaseClient.getUserId();
      if (userId == null) throw "User ID not found. Please log in again.";

      final apiUrl = 'https://intensely-optimal-unicorn.ngrok-free.app/home/users/$userId/business-hours/';
      final headers = await BaseClient.authHeaders();
      headers['Content-Type'] = 'application/json';

      final n = businessSchedule.length;
      if (n > 0) {
        final bool hasStart = (startTimes.length == n);
        final bool hasEnd = (endTimes.length == n);

        for (int i = 0; i < n; i++) {
          if (hasStart) {
            final st = startTimes[i].value;
            if (st.isNotEmpty) businessSchedule[i].openTime = st;
          }
          if (hasEnd) {
            final et = endTimes[i].value;
            if (et.isNotEmpty) businessSchedule[i].closeTime = et;
          }
        }
      }

      final List<Map<String, dynamic>> requestBody = [];
      for (int i = 0; i < businessSchedule.length; i++) {
        final s = businessSchedule[i];
        requestBody.add({
          'day': i.toString(),
          'open_time': s.openTime,
          'close_time': s.closeTime,
          'is_closed': s.isClosed,
        });
      }

      final response = await http.patch(Uri.parse(apiUrl), headers: headers, body: json.encode(requestBody));

      if ((response.statusCode >= 200 && response.statusCode <= 210) || response.statusCode == 204) {
        Get.snackbar('Success', 'Business hours updated successfully!');
      } else {
        try {
          final resp = json.decode(response.body);
          throw resp['message'] ?? 'Failed to update business hours';
        } catch (_) {
          throw 'Failed to update business hours (HTTP ${response.statusCode})';
        }
      }
    } catch (error) {
      Get.snackbar('Error', error.toString());
    }
  }
}
