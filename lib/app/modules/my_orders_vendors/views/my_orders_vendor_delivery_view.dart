import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/my_orders_vendors/controllers/my_orders_vendor_delivery_controller.dart';
import 'package:quopon/app/modules/my_orders_vendors/views/delivery/delivered_view.dart';
import 'package:quopon/app/modules/my_orders_vendors/views/delivery/delivery_cancelled_view.dart';
import 'package:quopon/app/modules/my_orders_vendors/views/delivery/delivery_completed_view.dart';
import 'package:quopon/app/modules/my_orders_vendors/views/delivery/delivery_in_preparation_view.dart';
import 'package:quopon/app/modules/my_orders_vendors/views/delivery/delivery_order_received_view.dart';
import 'package:quopon/app/modules/my_orders_vendors/views/delivery/out_for_delivery_view.dart';

import 'my_orders_vendor_card_view.dart';

class MyOrdersVendorDeliveryView extends GetView<MyOrdersVendorDeliveryController> {
  const MyOrdersVendorDeliveryView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(MyOrdersVendorDeliveryController());

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
                      'Order Received (03)',
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
                      'In Preparation (04)',
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
                      'Out for Delivery (03)',
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
                      'Delivered (02)',
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
                      'Completed (51)',
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
                      'Cancelled (05)',
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

          controller.filters[0].value ? DeliveryOrderReceivedView()
              : controller.filters[1].value ? DeliveryInPreparationView()
              : controller.filters[2].value ? OutForDeliveryView()
              : controller.filters[3].value ? DeliveredView()
              : controller.filters[4].value ? DeliveryCompletedView()
              : DeliveryCancelledView(),
        ],
      );
    });
  }
}
