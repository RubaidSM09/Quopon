import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/my_orders/views/my_orders_active_view.dart';
import 'package:quopon/app/modules/my_orders/views/my_orders_cancelled_view.dart';
import 'package:quopon/app/modules/my_orders/views/my_orders_completed_view.dart';

import '../controllers/my_orders_controller.dart';

class MyOrdersView extends GetView<MyOrdersController> {
  const MyOrdersView({super.key});
  @override
  Widget build(BuildContext context) {
    RxList<RxBool> status = [true.obs, false.obs, false.obs].obs;

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
                              for (int i=0;i<3;i++) {
                                status[i].value = false;
                              }
                              status[0].value = true;
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: status[0].value ? Color(0xFFD62828) : Colors.transparent,
                              ),
                              child: SizedBox(
                                width: 103.33.w,
                                child: Center(
                                  child: Text(
                                    'Active (05)',
                                    style: TextStyle(
                                      color: status[0].value ? Colors.white : Color(0xFF6F7E8D),
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
                              for (int i=0;i<3;i++) {
                                status[i].value = false;
                              }
                              status[1].value = true;
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: status[1].value ? Color(0xFFD62828) : Colors.transparent,
                              ),
                              child: SizedBox(
                                width: 103.33.w,
                                child: Center(
                                  child: Text(
                                    'Completed (12)',
                                    style: TextStyle(
                                      color: status[1].value ? Colors.white : Color(0xFF6F7E8D),
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
                              for (int i=0;i<3;i++) {
                                status[i].value = false;
                              }
                              status[2].value = true;
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: status[2].value ? Color(0xFFD62828) : Colors.transparent,
                              ),
                              child: SizedBox(
                                width: 103.33.w,
                                child: Center(
                                  child: Text(
                                    'Cancelled (03)',
                                    style: TextStyle(
                                      color: status[2].value ? Colors.white : Color(0xFF6F7E8D),
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

                    status[0].value ? MyOrdersActiveView() : status[1].value ? MyOrdersCompletedView() : MyOrdersCancelledView(),
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
