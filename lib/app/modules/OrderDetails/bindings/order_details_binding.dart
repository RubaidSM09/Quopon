import 'package:get/get.dart';

import 'package:quopon/app/modules/OrderDetails/controllers/track_order_controller.dart';

import '../controllers/order_details_controller.dart';

class OrderDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrackOrderController>(
      () => TrackOrderController(),
    );
    Get.lazyPut<OrderDetailsController>(
      () => OrderDetailsController(),
    );
  }
}
