import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/discover/views/discover_filter_view.dart';

import '../../Search/views/search_view.dart';
import '../controllers/discover_controller.dart';

class DiscoverMapView extends GetView<DiscoverController> {
  const DiscoverMapView({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Map
        Stack(
          children: [
            Positioned(
              top: 0.h,
              left: 0.w,
              child: Image.asset(
                'assets/images/discover/map.png',
                scale: 4,
              ),
            ),
            Positioned(
              top: 203.h,
              left: 26.w,
              child: Image.asset(
                'assets/images/discover/pinpoint.png',
                scale: 4,
              ),
            ),
            Positioned(
              top: 0.h,
              left: 0.w,
              child: Image.asset(
                'assets/images/discover/upper_rect.png',
                scale: 4,
              ),
            ),
          ],
        ),

        Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 60.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Location',
                            style: TextStyle(
                              color: Color(0xFF6F7E8D),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(width: 4.w,),
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 14.sp,
                            color: Color(0xFF6F7E8D),
                          )
                        ],
                      ),
                      SizedBox(height: 6.h,),
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/Home/Location.png',
                          ),
                          SizedBox(width: 8.w,),
                          Text(
                            'Elizabeth City',
                            style: TextStyle(
                              color: Color(0xFF020711),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(SearchView());
                        },
                        child: Image.asset(
                          'assets/images/discover/Search.png',
                          scale: 4,
                        ),
                      ),
                      SizedBox(width: 16.w,),
                      GestureDetector(
                        onTap: () {
                          Get.dialog(DiscoverFilterView());
                        },
                        child: Image.asset(
                          'assets/images/discover/filter.png',
                          scale: 4,
                        ),
                      ),
                      SizedBox(width: 16.w,),
                      GestureDetector(
                        onTap: () {
                          if (controller.isMap.value) {
                            controller.isMap.value = !controller.isMap.value;
                          }
                        },
                        child: Image.asset(
                          'assets/images/discover/List View.png',
                          scale: 4,
                        ),
                      ),
                    ],
                  )
                ],
              ),

              SizedBox(height: 20.h,),

              Obx(() {
                return Container(
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
                          if (!controller.isDelivery.value) {
                            controller.isDelivery.value = !controller.isDelivery.value;
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                          decoration: BoxDecoration(
                            color: controller.isDelivery.value ? Color(0xFFD62828) : Colors.transparent,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: SizedBox(
                            width: 161.w,
                            child: Center(
                              child: Text(
                                'Delivery',
                                style: TextStyle(
                                  color: controller.isDelivery.value ? Colors.white : Color(0xFF6F7E8D),
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
                          if (controller.isDelivery.value) {
                            controller.isDelivery.value = !controller.isDelivery.value;
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                          decoration: BoxDecoration(
                            color: !controller.isDelivery.value ? Color(0xFFD62828) : Colors.transparent,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: SizedBox(
                            width: 161.w,
                            child: Center(
                              child: Text(
                                'Pickup',
                                style: TextStyle(
                                  color: !controller.isDelivery.value ? Colors.white : Color(0xFF6F7E8D),
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
                );
              }),
            ],
          ),
        )
      ],
    );
  }
}
