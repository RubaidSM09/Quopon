import 'package:get/get.dart';

import '../controllers/my_deals_details_controller.dart';

class MyDealsDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyDealsDetailsController>(
      () => MyDealsDetailsController(),
    );
  }
}
