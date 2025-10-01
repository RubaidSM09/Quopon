import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/Search/views/search_view.dart';
import 'package:quopon/app/modules/discover/views/discover_list_card_view.dart';

import '../controllers/discover_controller.dart';
import 'discover_filter_view.dart';

class DiscoverListView extends GetView<DiscoverController> {
  const DiscoverListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 16),
      child: SingleChildScrollView(
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
                        if (!controller.isMap.value) {
                          controller.isMap.value = !controller.isMap.value;
                        }
                      },
                      child: Image.asset(
                        'assets/images/discover/Map View.png',
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
        
            SizedBox(height: 20.h,),

            Obx(() {
              final pins = controller.nearbyPins;
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.error.value != null) {
                return Center(child: Text(controller.error.value!));
              }
              if (pins.isEmpty) {
                return Padding(
                  padding: EdgeInsets.only(top: 40.h),
                  child: Column(
                    children: [
                      const Icon(Icons.location_off, size: 48, color: Colors.grey),
                      SizedBox(height: 8.h),
                      const Text('No vendors near you within the selected radius.', textAlign: TextAlign.center),
                    ],
                  ),
                );
              }

              return Column(
                children: pins.map((p) {
                  // Your DiscoverListCardView requires: title, image, rating, review, distance, offer
                  // We don't have rating/review/offer yet from this API—so pass sane placeholders.
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0.h),
                    child: DiscoverListCardView(
                      title: p.vendor.name,
                      image: p.vendor.logoImage ?? '',
                      rating: 0.0,
                      review: 0,
                      distance: p.distanceKm,
                      offer: '0',
                    ),
                  );
                }).toList(),
              );
            }),
          ],
        ),
      ),
    );
  }
}
