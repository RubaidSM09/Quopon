import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/Get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:quopon/app/data/model/vendor_category.dart';

import '../../../data/api_client.dart';
import '../../../data/base_client.dart';
import '../../../data/model/business_hour.dart';

class SignUpProcessVendorController extends GetxController {
  // Form data controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController kvkNumberController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  var selectedCategory = ''.obs; // Observing the selected category

  // 🔹 image picker state
  final ImagePicker _picker = ImagePicker();
  final Rxn<XFile> profileImage = Rxn<XFile>(); // null = not picked yet

  static const String _profileUploadPath = '/vendors/upload/';
  static const String _profileImageField = 'image'; // <-- must be "image"

  var selectedCategoryId = RxInt(0);

  // Observable variables for time (using RxString for reactivity)
  RxString startTime = '08:00'.obs;
  RxString endTime = '17:00'.obs;

  // Observable list for the schedule
  RxList<Schedule> businessSchedule = <Schedule>[].obs;

  RxList<VendorCategory> vendorCategories = <VendorCategory>[].obs;

  RxList<RxString> startTimes = [''.obs,].obs;
  RxList<RxString> endTimes = [''.obs,].obs;

  Future<void> fetchVendorCategories() async {
    try {
      String? userId = await BaseClient.getUserId();

      if (userId == null) {
        throw "User ID not found. Please log in again.";
      }

      final apiUrl = 'https://doctorless-stopperless-turner.ngrok-free.dev/vendors/vendor-categories/';
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

  // Helper to convert "HH:mm:ss" -> "HH:mm" (and handle nulls safely)
  String _toHHmm(String? v) {
    if (v == null || v.isEmpty) return '';
    // Expect "HH:mm:ss" or "HH:mm"
    if (v.length >= 5) return v.substring(0, 5);
    return v;
  }

  String _weekdayFromIndex(int i) {
    const names = [
      'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'
    ];
    return (i >= 0 && i < names.length) ? names[i] : 'Monday';
  }

  Future<void> fetchBusinessHours() async {
    try {
      String? userId = await BaseClient.getUserId();
      if (userId == null) {
        throw "User ID not found. Please log in again.";
      }

      final apiUrl =
          'https://doctorless-stopperless-turner.ngrok-free.dev/home/users/$userId/business-hours/';
      final headers = await BaseClient.authHeaders();

      final response = await BaseClient.getRequest(api: apiUrl, headers: headers);

      print(response.statusCode);

      if (response.statusCode >= 200 && response.statusCode <= 210) {
        final responseBody = json.decode(response.body);

        final businessHour = BusinessHour.fromJson(responseBody);

        // Keep the raw model for patching later
        businessSchedule.value = businessHour.schedule;

        // 🚑 Normalize day labels using the row index (Mon..Sun)
        for (int i = 0; i < businessSchedule.length; i++) {
          final label = _weekdayFromIndex(i);
          businessSchedule[i].day = label;
          businessSchedule[i].dayDisplay = label;
        }

        // Feed the UI-friendly HH:mm strings (your TimePicker expects HH:mm)
        startTimes.assignAll(businessSchedule.map((s) => _toHHmm(s.openTime).obs).toList());
        endTimes.assignAll(businessSchedule.map((s) => _toHHmm(s.closeTime).obs).toList());

        // (Optional) log
        // print("Fetched ${businessHour.schedule.length} business hour rows");
      } else {
        final responseBody = json.decode(response.body);
        throw responseBody['message'] ?? 'Failed to fetch business hours';
      }
    } catch (error) {
      print(error.toString());
      Get.snackbar('Error', error.toString());
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

  void setIsClosed(int index, bool isClosed) {
    if (index < 0 || index >= businessSchedule.length) return;
    businessSchedule[index].isClosed = isClosed;
    update(); // keep any GetBuilder in sync
  }


  // Function to update the business hour times
  void setEndTime(int index, String value) {
    if (index < 0 || index >= endTimes.length) return;
    endTimes[index].value = value;
    // keep model in sync for PATCH
    if (index < businessSchedule.length) {
      businessSchedule[index].closeTime = value;
    }
    update(); // in case any GetBuilder widgets depend on it
  }

  void setStartTime(int index, String value) {
    if (index < 0 || index >= startTimes.length) return;
    startTimes[index].value = value;
    // keep model in sync for PATCH
    if (index < businessSchedule.length) {
      businessSchedule[index].openTime = value;
    }
    update(); // in case any GetBuilder widgets depend on it
  }

  // Function to patch business hours data (send updated data to server)
  Future<void> patchBusinessHours() async {
    try {
      final String? userId = await BaseClient.getUserId();
      if (userId == null) {
        throw "User ID not found. Please log in again.";
      }

      final apiUrl = 'https://doctorless-stopperless-turner.ngrok-free.dev/home/users/$userId/business-hours/';
      final headers = await BaseClient.authHeaders();
      headers['Content-Type'] = 'application/json';

      // --- Sync UI -> model before sending ---
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
          // also ensure isClosed is updated elsewhere when you toggle the switch
        }
      }

      // --- Build RAW LIST body with numeric day index as string ---
      final List<Map<String, dynamic>> requestBody = [];
      for (int i = 0; i < businessSchedule.length; i++) {
        final s = businessSchedule[i];
        requestBody.add({
          'day': i.toString(),              // 🔧 override with index
          'open_time': s.openTime,
          'close_time': s.closeTime,
          'is_closed': s.isClosed,
        });
      }

      // Debug
      print('PATCH payload => $requestBody');

      final response = await http.patch(
        Uri.parse(apiUrl),
        headers: headers,
        body: json.encode(requestBody),
      );

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

  // Function to make the API call for business profile
  Future<void> submitBusinessProfile() async {
    try {
      String? accessToken = await BaseClient.getAccessToken();

      if (accessToken == null) {
        throw "Unauthorized access. Please log in again.";
      }

      String? photoUrl;
      if (profileImage.value != null) {
        photoUrl = await _uploadProfileImageAndGetUrl();
        if (photoUrl == null) {
          // optional: let user proceed without image
          Get.snackbar('Profile picture', 'Using default picture (upload failed).');
        }
      }

      final requestBody = {
        "name": nameController.text,
        "kvk_number": kvkNumberController.text,
        "phone_number": phoneController.text,
        "address": addressController.text,
        "category": selectedCategoryId.value, // Use the category id
        'logo': photoUrl,
      };

      final headers = await BaseClient.authHeaders();

      final response = await BaseClient.postRequest(
        api: 'https://doctorless-stopperless-turner.ngrok-free.dev/vendors/business-profile/',
        body: json.encode(requestBody),
        headers: headers,
      );

      final responseBody = json.decode(response.body);

      print(responseBody.statusCode);

      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Business profile updated successfully');

        // Get.to(); // Example: Navigate to next page
      } else {
        throw responseBody['message'] ?? 'Something went wrong';
      }
    } catch (error) {
      Get.snackbar('Error', error.toString());
    }
  }
}
