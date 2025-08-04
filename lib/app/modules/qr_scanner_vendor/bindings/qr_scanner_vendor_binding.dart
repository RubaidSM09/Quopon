import 'package:get/get.dart';

import '../controllers/qr_scanner_vendor_controller.dart';

class QrScannerVendorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QrScannerVendorController>(
      () => QrScannerVendorController(),
    );
  }
}
