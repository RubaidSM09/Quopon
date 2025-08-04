import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/deal_preview_controller.dart';

class DealPreviewView extends GetView<DealPreviewController> {
  const DealPreviewView({super.key});
  @override
  Widget build(BuildContext context) {
    RxBool isPickup = true.obs;

    return Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox.shrink(),
                  Text(
                    'Deal Preview',
                    style: TextStyle(color: Color(0xFF020711), fontSize: 18.sp,),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.close),
                  )
                ],
              ),

              SizedBox(height: 20.h,),

              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset(
                  'assets/images/deals_preview/starbucks_shake.png',
                  scale: 4,
                ),
              ),

              SizedBox(height: 20.h,),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '50% Off Any Grande Beverage',
                        style: TextStyle(color: Color(0xFF020711), fontSize: 18.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(height: 8.h,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                        style: TextStyle(color: Color(0xFF6F7E8D), fontSize: 14.sp),
                      ),
                    ),

                    SizedBox(height: 16.h,),

                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [BoxShadow(color: Colors.black.withAlpha(26), blurRadius: 20.r)]
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/deals/details/Starbucks_Logo.png',
                                width: 44.w,
                                height: 44.h,
                              ),
                              SizedBox(width: 12.w,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Starbucks',
                                    style: TextStyle(color: Color(0xFF020711), fontSize: 14.sp, fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(height: 6.h,),
                                  SizedBox(
                                    width: 145.w,
                                    child: Text(
                                      '03 Aug 11:59 PM - 05 Aug 11:59 PM',
                                      style: TextStyle(color: Color(0xFF6F7E8D), fontSize: 12.sp, fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 12.w,),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  color: Color(0xFFD62828),
                                  borderRadius: BorderRadius.circular(6.r)
                                ),
                                child: Text(
                                  '50% OFF',
                                  style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),

                          SizedBox(height: 16.h,),

                          Divider(color: Color(0xFFF0F2F3),),

                          SizedBox(height: 16.h,),

                          Row(
                            children: [
                              SizedBox(
                                width: 121.w,
                                child: Text(
                                  'Max Coupons',
                                  style: TextStyle(color: Color(0xFF6F7E8D), fontSize: 14.sp, fontWeight: FontWeight.normal),
                                ),
                              ),
                              SizedBox(width: 16.w,),
                              Text(
                                ':',
                                style: TextStyle(color: Color(0xFF020711), fontSize: 14.sp, fontWeight: FontWeight.normal),
                              ),
                              SizedBox(width: 16.w,),
                              SizedBox(
                                width: 121.w,
                                child: Text(
                                  '50',
                                  style: TextStyle(color: Color(0xFF020711), fontSize: 14.sp, fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h,),
                          Row(
                            children: [
                              SizedBox(
                                width: 121.w,
                                child: Text(
                                  'Coupons Per Customer',
                                  style: TextStyle(color: Color(0xFF6F7E8D), fontSize: 14.sp, fontWeight: FontWeight.normal),
                                ),
                              ),
                              SizedBox(width: 16.w,),
                              Text(
                                ':',
                                style: TextStyle(color: Color(0xFF020711), fontSize: 14.sp, fontWeight: FontWeight.normal),
                              ),
                              SizedBox(width: 16.w,),
                              SizedBox(
                                width: 121.w,
                                child: Text(
                                  '01',
                                  style: TextStyle(color: Color(0xFF020711), fontSize: 14.sp, fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h,),
                          Row(
                            children: [
                              SizedBox(
                                width: 121.w,
                                child: Text(
                                  'Available Days',
                                  style: TextStyle(color: Color(0xFF6F7E8D), fontSize: 14.sp, fontWeight: FontWeight.normal),
                                ),
                              ),
                              SizedBox(width: 16.w,),
                              Text(
                                ':',
                                style: TextStyle(color: Color(0xFF020711), fontSize: 14.sp, fontWeight: FontWeight.normal),
                              ),
                              SizedBox(width: 16.w,),
                              SizedBox(
                                width: 121.w,
                                child: Text(
                                  'Monday to Friday',
                                  style: TextStyle(color: Color(0xFF020711), fontSize: 14.sp, fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Choose Order Method',
                          style: TextStyle(color: Color(0xFF020711), fontWeight: FontWeight.normal, fontSize: 14.sp),
                        ),
                        SizedBox.shrink()
                      ],
                    ),
                    SizedBox(height: 8.h,),
                    Obx(() {
                      return Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            color: Color(0xFFF1F3F4)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if(!isPickup.value) {
                                  isPickup.value = !isPickup.value;
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                                decoration: BoxDecoration(
                                  color: isPickup.value ? Color(0xFFD62828) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(100.r)
                                ),
                                child: SizedBox(
                                  width: 115.w,
                                  child: Center(
                                    child: Text(
                                      'Pickup',
                                      style: TextStyle(
                                        color: isPickup.value ? Colors.white : Color(0xFF6F7E8D),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                if(isPickup.value) {
                                  isPickup.value = !isPickup.value;
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                                decoration: BoxDecoration(
                                    color: isPickup.value ? Colors.transparent : Color(0xFFD62828),
                                    borderRadius: BorderRadius.circular(100.r)
                                ),
                                child: SizedBox(
                                  width: 115.w,
                                  child: Center(
                                    child: Text(
                                      'Delivery',
                                      style: TextStyle(
                                        color: isPickup.value ? Color(0xFF6F7E8D) : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
