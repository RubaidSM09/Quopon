import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/my_orders_vendors/views/my_orders_vendor_delivery_view.dart';
import 'package:quopon/app/modules/my_orders_vendors/views/my_orders_vendor_pickup_view.dart';

import '../controllers/my_orders_vendors_controller.dart';

class MyOrdersVendorsView extends GetView<MyOrdersVendorsController> {
  const MyOrdersVendorsView({super.key});
  @override
  Widget build(BuildContext context) {
    RxBool isPickup = true.obs;

    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 60.h, bottom: 22.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(Icons.arrow_back, color: Color(0xFF020711), size: 24.sp,),
                  ),
                  Text(
                    'My Orders',
                    style: TextStyle(
                      color: Color(0xFF020711),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox.shrink(),
                ],
              ),

              SizedBox(height: 24.h,),

              Obx(() {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: Color(0xFFF1F3F4),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (!isPickup.value) {
                                isPickup.value = !isPickup.value;
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: isPickup.value ? Color(0xFFD62828) : Colors.transparent,
                              ),
                              child: SizedBox(
                                width: 161.w,
                                child: Center(
                                  child: Text(
                                    'Pickup',
                                    style: TextStyle(
                                      color: isPickup.value ? Colors.white : Color(0xFF6F7E8D),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (isPickup.value) {
                                isPickup.value = !isPickup.value;
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: !isPickup.value ? Color(0xFFD62828) : Colors.transparent,
                              ),
                              child: SizedBox(
                                width: 161.w,
                                child: Center(
                                  child: Text(
                                    'Delivery',
                                    style: TextStyle(
                                      color: !isPickup.value ? Colors.white : Color(0xFF6F7E8D),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h,),

                    isPickup.value ? MyOrdersVendorPickupView() : MyOrdersVendorDeliveryView(),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
