import 'package:get/get.dart';

import '../controllers/vendor_deal_performance_controller.dart';

class VendorDealPerformanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorDealPerformanceController>(
      () => VendorDealPerformanceController(),
    );
  }
}
