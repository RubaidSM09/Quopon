import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../../common/customTextButton.dart';
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

                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h,),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: Color(0xFFB81EFF).withAlpha(20),
                                ),
                                child: Text(
                                  'Redemption: Delivery & Pickup',
                                  style: TextStyle(
                                    color: Color(0xFFB81EFF),
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),

                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h,),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: Color(0xFF1E92FF).withAlpha(20),
                                ),
                                child: Text(
                                  'Delivery Cost: \$1.99',
                                  style: TextStyle(
                                    color: Color(0xFF1E92FF),
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),

                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h,),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: Color(0xFFFF8E24).withAlpha(20),
                                ),
                                child: Text(
                                  'Min. Order Amount: \$20.00',
                                  style: TextStyle(
                                    color: Color(0xFFFF8E24),
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h,),

                    GradientButton(
                      text: 'Order Now',
                      onPressed: () {

                      },
                      colors: [const Color(0xFFD62828), const Color(0xFFC21414)],
                      boxShadow: [
                        const BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1),
                      ],
                      child: Text(
                        'Order Now',
                        style: TextStyle(
                          fontSize: 16.sp, // Use ScreenUtil for font size
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
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
