import 'package:get/get.dart';

import '../controllers/vendor_deals_controller.dart';

class VendorDealsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorDealsController>(
      () => VendorDealsController(),
    );
  }
}
