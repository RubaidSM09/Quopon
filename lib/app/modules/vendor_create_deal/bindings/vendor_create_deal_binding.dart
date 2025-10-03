import 'package:get/get.dart';

import 'package:quopon/app/modules/vendor_create_deal/controllers/send_push_notifications_controller.dart';

import '../controllers/vendor_create_deal_controller.dart';

class VendorCreateDealBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SendPushNotificationsController>(
      () => SendPushNotificationsController(),
    );
    Get.lazyPut<VendorCreateDealController>(
      () => VendorCreateDealController(),
    );
  }
}
