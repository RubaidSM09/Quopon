import 'package:get/get.dart';

import '../controllers/vendor_edit_deal_controller.dart';

class VendorEditDealBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorEditDealController>(
      () => VendorEditDealController(),
    );
  }
}
