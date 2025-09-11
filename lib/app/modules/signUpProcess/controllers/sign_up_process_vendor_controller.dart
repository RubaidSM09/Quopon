import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quopon/app/data/model/vendor_category.dart';

import '../../../data/base_client.dart';
import '../../../data/model/business_hour.dart';

class SignUpProcessVendorController extends GetxController {
  // Form data controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController kvkNumberController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  var selectedCategory = ''.obs; // Observing the selected category

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

      final apiUrl = 'http://10.10.13.52:7000/vendors/vendor-categories/';
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

  // Function to fetch business hours from the server
  Future<void> fetchBusinessHours() async {
    try {
      String? userId = await BaseClient.getUserId();

      if (userId == null) {

        

        throw "User ID not found. Please log in again.";
      }

      final apiUrl = 'http://10.10.13.52:7000/home/users/$userId/business-hours/';
      final headers = await BaseClient.authHeaders();

      final response = await BaseClient.getRequest(api: apiUrl, headers: headers);

      if (response.statusCode >= 200 && response.statusCode <= 210) {
        final responseBody = json.decode(response.body);
        BusinessHour businessHour = BusinessHour.fromJson(responseBody);

        businessSchedule.value = businessHour.schedule;

        startTimes.assignAll(
          businessHour.schedule.map((s) => s.openTime.obs).toList(),
        );

        endTimes.assignAll(
          businessHour.schedule.map((s) => s.closeTime.obs).toList(),
        );

        print(" length ====== > ${businessHour.schedule.length}");
        print(" length ====== > ${endTimes.length}");
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

      final apiUrl = 'http://10.10.13.52:7000/home/users/$userId/business-hours/';
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

      final requestBody = {
        "name": nameController.text,
        "kvk_number": kvkNumberController.text,
        "phone_number": phoneController.text,
        "address": addressController.text,
        "category": selectedCategoryId.value, // Use the category id
      };

      final headers = await BaseClient.authHeaders();

      final response = await BaseClient.postRequest(
        api: 'http://10.10.13.52:7000/vendors/business-profile/',
        body: json.encode(requestBody),
        headers: headers,
      );

      final responseBody = json.decode(response.body);

      if (response.statusCode == 200) {
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
