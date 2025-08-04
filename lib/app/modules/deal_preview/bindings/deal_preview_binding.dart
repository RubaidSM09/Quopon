import 'package:get/get.dart';

import '../controllers/deal_preview_controller.dart';

class DealPreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DealPreviewController>(
      () => DealPreviewController(),
    );
  }
}
