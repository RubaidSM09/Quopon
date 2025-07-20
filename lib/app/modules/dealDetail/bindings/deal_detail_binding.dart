import 'package:get/get.dart';

import '../controllers/deal_detail_controller.dart';

class DealDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DealDetailController>(
      () => DealDetailController(),
    );
  }
}
