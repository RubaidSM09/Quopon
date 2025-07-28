import 'package:get/get.dart';

import '../controllers/vendor_add_menu_controller.dart';

class VendorAddMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorAddMenuController>(
      () => VendorAddMenuController(),
    );
  }
}
