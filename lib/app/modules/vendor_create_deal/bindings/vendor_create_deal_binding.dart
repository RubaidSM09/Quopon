import 'package:get/get.dart';

import '../controllers/vendor_create_deal_controller.dart';

class VendorCreateDealBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorCreateDealController>(
      () => VendorCreateDealController(),
    );
  }
}
