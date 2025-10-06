import 'package:get/get.dart';

import '../controllers/vendor_edit_menu_controller.dart';

class VendorEditMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorEditMenuController>(
      () => VendorEditMenuController(menuId: 0),
    );
  }
}
