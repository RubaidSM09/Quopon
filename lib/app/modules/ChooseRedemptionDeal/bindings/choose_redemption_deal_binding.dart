import 'package:get/get.dart';

import '../controllers/choose_redemption_deal_controller.dart';

class ChooseRedemptionDealBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseRedemptionDealController>(
      () => ChooseRedemptionDealController(),
    );
  }
}
