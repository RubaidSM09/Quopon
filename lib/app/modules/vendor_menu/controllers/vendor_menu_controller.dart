import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/base_client.dart';
import '../../../data/model/menu_item.dart';

class VendorMenuController extends GetxController {
  // Loading & error
  final RxBool loading = false.obs;
  final RxString error = ''.obs;

  // categoryTitle -> List<MenuItem>
  final RxMap<String, List<MenuItem>> menusByCategory =
      <String, List<MenuItem>>{}.obs;
  final RxMap<String, List<MenuItem>> filteredMenusByCategory =
      <String, List<MenuItem>>{}.obs; // New: filtered by search query
  final searchQuery = ''.obs; // To store search input

  @override
  void onInit() {
    super.onInit();
    fetchMenus();
  }

  Future<void> fetchMenus() async {
    loading.value = true;
    error.value = '';
    menusByCategory.clear();
    filteredMenusByCategory.clear();

    try {
      final userId = await BaseClient.getUserId();
      if (userId == null || userId.isEmpty) {
        throw 'User ID not found. Please log in again.';
      }

      final headers = await BaseClient.authHeaders();
      final res = await BaseClient.getRequest(
        api: 'https://doctorless-stopperless-turner.ngrok-free.dev/vendors/deals/',
        params: {'user_id': userId},
        headers: headers,
      );

      final data = await BaseClient.handleResponse(res);

      final List<MenuItem> items = (data as List<dynamic>)
          .map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
          .toList();

      // Group by category title
      final map = <String, List<MenuItem>>{};
      for (final mi in items) {
        final catTitle = mi.category.categoryTitle.isNotEmpty
            ? mi.category.categoryTitle
            : 'Uncategorized';
        map.putIfAbsent(catTitle, () => <MenuItem>[]);
        map[catTitle]!.add(mi);
      }

      menusByCategory.assignAll(map);
      filteredMenusByCategory.assignAll(map); // Initialize filtered list
    } catch (e) {
      error.value = e.toString();
    } finally {
      loading.value = false;
    }
  }

  // Search function to filter menu items by title, category, or description
  void searchMenus(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredMenusByCategory.assignAll(menusByCategory);
    } else {
      final filteredMap = <String, List<MenuItem>>{};
      menusByCategory.forEach((category, items) {
        final filteredItems = items.where((item) {
          final queryLower = query.toLowerCase();
          return item.title.toLowerCase().contains(queryLower) ||
              category.toLowerCase().contains(queryLower) ||
              item.description.toLowerCase().contains(queryLower);
        }).toList();
        if (filteredItems.isNotEmpty) {
          filteredMap[category] = filteredItems;
        }
      });
      filteredMenusByCategory.assignAll(filteredMap);
    }
  }

  // Delete a menu item
  Future<void> deleteMenu(int menuId) async {
    try {
      loading.value = true;
      error.value = '';

      final headers = await BaseClient.authHeaders();
      final res = await BaseClient.deleteRequest(
        api: 'https://doctorless-stopperless-turner.ngrok-free.dev/vendors/deals/$menuId/',
        headers: headers,
      );

      await BaseClient.handleResponse(res); // Handle response to check for errors

      // Refresh the menu list after deletion
      await fetchMenus();

      // Show success message
      Get.snackbar(
        'Success',
        'Menu item deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      error.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to delete menu item: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      loading.value = false;
    }
  }
}