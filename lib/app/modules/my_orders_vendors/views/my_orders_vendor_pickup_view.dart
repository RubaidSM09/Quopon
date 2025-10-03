import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/my_orders_vendors/views/my_orders_vendor_card_view.dart';
import 'package:quopon/app/modules/my_orders_vendors/views/pickup/picked_up_view.dart';
import 'package:quopon/app/modules/my_orders_vendors/views/pickup/pickup_cancelled_view.dart';
import 'package:quopon/app/modules/my_orders_vendors/views/pickup/pickup_completed_view.dart';
import 'package:quopon/app/modules/my_orders_vendors/views/pickup/pickup_in_preparation_view.dart';
import 'package:quopon/app/modules/my_orders_vendors/views/pickup/pickup_order_recieved_view.dart';
import 'package:quopon/app/modules/my_orders_vendors/views/pickup/ready_for_pickup_view.dart';

import '../controllers/my_orders_vendor_pickup_controller.dart';
import '../controllers/my_orders_vendors_controller.dart';

class MyOrdersVendorPickupView extends GetView<MyOrdersVendorPickupController> {

  const MyOrdersVendorPickupView({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    Get.put(MyOrdersVendorPickupController());

    return Obx(() {
      return Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    for (int i=0; i<6; i++) {
                      controller.filters[i].value = false;
                    }
                    controller.filters[0].value = true;
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: controller.filters[0].value ? Color(0xFFD62828) : Colors.white,
                      boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 12.r)],
                    ),
                    child: Text(
                      'Order Received (${Get.find<MyOrdersVendorsController>().orders.where((o) => o.deliveryType != "DELIVERY" && (o.status == "PENDING_PAYMENT" || o.status == "RECEIVED")).length})',
                      style: TextStyle(
                        color: controller.filters[0].value ? Colors.white : Color(0xFF6F7E8D),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 8.w,),

                GestureDetector(
                  onTap: () {
                    for (int i=0; i<6; i++) {
                      controller.filters[i].value = false;
                    }
                    controller.filters[1].value = true;
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: controller.filters[1].value ? Color(0xFFD62828) : Colors.white,
                      boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 12.r)],
                    ),
                    child: Text(
                      'In Preparation (${Get.find<MyOrdersVendorsController>().orders.where((o) => o.deliveryType != "DELIVERY" && o.status == "PREPARING").length})',
                      style: TextStyle(
                        color: controller.filters[1].value ? Colors.white : Color(0xFF6F7E8D),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 8.w,),

                GestureDetector(
                  onTap: () {
                    for (int i=0; i<6; i++) {
                      controller.filters[i].value = false;
                    }
                    controller.filters[2].value = true;
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: controller.filters[2].value ? Color(0xFFD62828) : Colors.white,
                      boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 12.r)],
                    ),
                    child: Text(
                      'Ready for Pickup (${Get.find<MyOrdersVendorsController>().orders.where((o) => o.deliveryType != "DELIVERY" && o.status == "READY_FOR_PICKUP").length})',
                      style: TextStyle(
                        color: controller.filters[2].value ? Colors.white : Color(0xFF6F7E8D),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 8.w,),

                GestureDetector(
                  onTap: () {
                    for (int i=0; i<6; i++) {
                      controller.filters[i].value = false;
                    }
                    controller.filters[3].value = true;
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: controller.filters[3].value ? Color(0xFFD62828) : Colors.white,
                      boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 12.r)],
                    ),
                    child: Text(
                      'Picked Up (${Get.find<MyOrdersVendorsController>().orders.where((o) => o.deliveryType != "DELIVERY" && o.status == "PICKED_UP").length})',
                      style: TextStyle(
                        color: controller.filters[3].value ? Colors.white : Color(0xFF6F7E8D),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 8.w,),

                GestureDetector(
                  onTap: () {
                    for (int i=0; i<6; i++) {
                      controller.filters[i].value = false;
                    }
                    controller.filters[4].value = true;
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: controller.filters[4].value ? Color(0xFFD62828) : Colors.white,
                      boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 12.r)],
                    ),
                    child: Text(
                      'Completed (${Get.find<MyOrdersVendorsController>().orders.where((o) => o.deliveryType != "DELIVERY" && o.status == "COMPLETED").length})',
                      style: TextStyle(
                        color: controller.filters[4].value ? Colors.white : Color(0xFF6F7E8D),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 8.w,),

                GestureDetector(
                  onTap: () {
                    for (int i=0; i<6; i++) {
                      controller.filters[i].value = false;
                    }
                    controller.filters[5].value = true;
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: controller.filters[5].value ? Color(0xFFD62828) : Colors.white,
                      boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 12.r)],
                    ),
                    child: Text(
                      'Cancelled (${Get.find<MyOrdersVendorsController>().orders.where((o) => o.deliveryType != "DELIVERY" && o.status == "CANCELLED").length})',
                      style: TextStyle(
                        color: controller.filters[5].value ? Colors.white : Color(0xFF6F7E8D),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h,),

          controller.filters[0].value ? PickupOrderRecievedView()
              : controller.filters[1].value ? PickupInPreparationView()
              : controller.filters[2].value ? ReadyForPickupView()
              : controller.filters[3].value ? PickedUpView()
              : controller.filters[4].value ? PickupCompletedView()
              : PickupCancelledView(),
        ],
      );
    });
  }
}
