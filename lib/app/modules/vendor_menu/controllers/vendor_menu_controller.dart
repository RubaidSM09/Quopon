import 'package:get/get.dart';

import '../../../data/base_client.dart';
import '../../../data/model/menu_item.dart';

class VendorMenuController extends GetxController {
  // Loading & error
  final RxBool loading = false.obs;
  final RxString error = ''.obs;

  // categoryTitle -> List<MenuItem>
  final RxMap<String, List<MenuItem>> menusByCategory = <String, List<MenuItem>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMenus();
  }

  Future<void> fetchMenus() async {
    loading.value = true;
    error.value = '';
    menusByCategory.clear();

    try {
      final userId = await BaseClient.getUserId();
      if (userId == null || userId.isEmpty) {
        throw 'User ID not found. Please log in again.';
      }

      final headers = await BaseClient.authHeaders();
      final res = await BaseClient.getRequest(
        api: 'https://intensely-optimal-unicorn.ngrok-free.app/vendors/deals/',
        params: {'user_id': userId},
        headers: headers,
      );

      final data = await BaseClient.handleResponse(res);

      final List<MenuItem> items = (data as List)
          .map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
          .toList();

      final map = <String, List<MenuItem>>{};
      for (final mi in items) {
        final catTitle = (mi.category.categoryTitle).isNotEmpty
            ? mi.category.categoryTitle
            : 'Uncategorized';
        map.putIfAbsent(catTitle, () => <MenuItem>[]);
        map[catTitle]!.add(mi);
      }

      menusByCategory.assignAll(map);
    } catch (e) {
      error.value = e.toString();
    } finally {
      loading.value = false;
    }
  }
}
