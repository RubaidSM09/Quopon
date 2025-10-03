import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../data/base_client.dart';
import '../../../data/model/business_hour.dart';  // Assuming you have BaseClient for API calls

class VendorSideProfileController extends GetxController {
  // Business Profile Data
  var profileData = {}.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController kvkController = TextEditingController();

  final RxInt selectedCategoryId = 0.obs;
  final RxList<String> categoryNames = <String>[].obs;
  final RxMap<String, int> nameToId = <String, int>{}.obs;
  final RxString selectedCategoryName = 'Select'.obs;
  void setCategoryId(int id) => selectedCategoryId.value = id;

  // Observable variables for time (using RxString for reactivity)
  RxString startTime = '08:00'.obs;
  RxString endTime = '17:00'.obs;
  RxList<Schedule> businessSchedule = <Schedule>[].obs;
  RxList<RxString> startTimes = [''.obs,].obs;
  RxList<RxString> endTimes = [''.obs,].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
    fetchVendorCategories();
  }

  Future<void> fetchProfile() async {
    try {
      final headers = await BaseClient.authHeaders();
      final res = await http.get(
        Uri.parse('https://intensely-optimal-unicorn.ngrok-free.app/vendors/business-profile/'),
        headers: headers,
      );

      if (res.statusCode == 200) {
        // Parse the response to check if it's a list or a map
        final responseJson = json.decode(res.body);

        if (responseJson is List) {
          // If it's a list, use the first item (or handle accordingly)
          profileData.value = responseJson.isNotEmpty ? responseJson[0] : {};
        } else if (responseJson is Map) {
          // If it's a map, use it directly
          profileData.value = responseJson;
        } else {
          throw 'Unexpected response format';
        }
      } else {
        throw 'Failed to load business profile';
      }
    } catch (e) {
      print('Error fetching profile: $e');
    }
  }

  Future<void> updateProfile(String name, String kvkNumber, String phoneNumber, String address, int category) async {
    try {
      print(name);

      final headers = await BaseClient.authHeaders();
      final body = {
        'name': name,
        'kvk_number': kvkNumber,
        'phone_number': phoneNumber,
        'address': address,
        'category': category
      };

      print(body);

      final response = await http.patch(
        Uri.parse('https://intensely-optimal-unicorn.ngrok-free.app/vendors/businessh-profile/manage/'),
        headers: headers,
        body: json.encode({'data': body}),
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        if (responseJson['message'] == 'Your business profile has been updated successfully.') {
          Get.snackbar('Success', 'Profile updated successfully');
        } else {
          throw 'Failed to update profile';
        }
      } else {
        throw 'Failed to update profile (HTTP ${response.statusCode})';
      }
    } catch (e) {
      print('Error updating profile: $e');
      Get.snackbar('Error', 'Failed to update profile');
    }
  }

  // Fetch categories from the API
  Future<void> fetchVendorCategories() async {
    try {
      final headers = await BaseClient.authHeaders();

      final res = await BaseClient.getRequest(
        api: 'https://intensely-optimal-unicorn.ngrok-free.app/vendors/vendor-categories/',
        headers: headers,
      );

      // unify handling (throws on error codes)
      final data = await BaseClient.handleResponse(res) as List<dynamic>;

      // shape: [{ "id": 1, "category_title": "..." }, ...]
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

      // default selection if empty/unchosen
      if (selectedCategoryName.value == 'Select' && categoryNames.isNotEmpty) {
        selectedCategoryName.value = categoryNames.first;
        selectedCategoryId.value = nameToId[selectedCategoryName.value] ?? 0;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
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
          'https://intensely-optimal-unicorn.ngrok-free.app/home/users/$userId/business-hours/';
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

      final apiUrl = 'https://intensely-optimal-unicorn.ngrok-free.app/home/users/$userId/business-hours/';
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
}
