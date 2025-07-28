import 'package:get/get.dart';

import '../controllers/vendor_menu_controller.dart';

class VendorMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorMenuController>(
      () => VendorMenuController(),
    );
  }
}
