import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil

import 'package:get/get.dart';
import 'package:quopon/app/modules/QuoponPlus/views/quopon_plus_benifits_view.dart';
import 'package:quopon/common/red_button.dart';

import '../../../../common/customTextButton.dart';
import '../controllers/quopon_plus_controller.dart';

class QuoponPlusView extends GetView<QuoponPlusController> {
  const QuoponPlusView({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isMonthly = true.obs;

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(16.r),
              topLeft: Radius.circular(16.r) // Use ScreenUtil for border radius
          )
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w), // Use ScreenUtil for padding
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox.shrink(),
                  Text(
                    'Qoupon+',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp), // Use ScreenUtil for font size
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.close),
                  )
                ],
              ),

              SizedBox(height: 5.h), // Use ScreenUtil for height

              Divider(),

              SizedBox(height: 10.h), // Use ScreenUtil for height

              Text(
                'Unlock Exclusive Benefits',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24.sp), // Use ScreenUtil for font size
              ),
              Text(
                'Access exclusive deals, enhanced savings, and premium member benefits with Qoupon+.',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp, color: Color(0xFF6F7E8D)),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 20.h), // Use ScreenUtil for height

              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r), // Use ScreenUtil for border radius
                    color: Color(0xFFF9FBFC)
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h), // Use ScreenUtil for padding
                child: Column(
                  children: [
                    QuoponPlusBenifitsView(
                      icon: 'assets/images/QuoponPlus/Access.png',
                      title: 'Access premium-only deals',
                      subTitle: 'Lorem Ipsum is simply dummy text of the printing industry.',
                    ),
                    SizedBox(height: 10.h), // Use ScreenUtil for height
                    QuoponPlusBenifitsView(
                      icon: 'assets/images/QuoponPlus/EarlyAccess.png',
                      title: 'Early access to limited offers',
                      subTitle: 'Lorem Ipsum is simply dummy text of the printing industry.',
                    ),
                    SizedBox(height: 10.h), // Use ScreenUtil for height
                    QuoponPlusBenifitsView(
                      icon: 'assets/images/QuoponPlus/Cashback.png',
                      title: 'Extra cashback on select vendors',
                      subTitle: 'Lorem Ipsum is simply dummy text of the printing industry.',
                    ),
                    SizedBox(height: 10.h), // Use ScreenUtil for height
                    QuoponPlusBenifitsView(
                      icon: 'assets/images/QuoponPlus/MonthlySurprise.png',
                      title: 'Monthly surprise deals',
                      subTitle: 'Lorem Ipsum is simply dummy text of the printing industry.',
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h), // Use ScreenUtil for height

              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if(!isMonthly.value){
                          isMonthly.value = !isMonthly.value;
                        }
                      },
                      child: Container(
                        width: 185.w, // Use ScreenUtil for width
                        height: 112.h, // Use ScreenUtil for height
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r), // Use ScreenUtil for border radius
                            border: Border.all(color: isMonthly.value ? Color(0xFFD62828) : Color(0xFFEAECED), width: 1.6)
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.w), // Use ScreenUtil for padding
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment : CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Monthly',
                                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Color(0xFF6F7E8D)),
                                  ),
                                  isMonthly.value ?
                                  Container(
                                    height: 16.h, // Use ScreenUtil for height
                                    width: 16.w, // Use ScreenUtil for width
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFFD62828)
                                    ),
                                    child: Center(child: Icon(Icons.check, color: Colors.white, size: 12.sp,)),
                                  ) :
                                  Container(
                                    height: 16.h, // Use ScreenUtil for height
                                    width: 16.w, // Use ScreenUtil for width
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Color(0xFFEAECED))
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                '\$4.99/Month',
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: Color(0xFF020711)),
                              ),
                              Text(
                                'Billed Monthly',
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Color(0xFF6F7E8D)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        if(isMonthly.value){
                          isMonthly.value = !isMonthly.value;
                        }
                      },
                      child: Container(
                        width: 185.w, // Use ScreenUtil for width
                        height: 112.h, // Use ScreenUtil for height
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r), // Use ScreenUtil for border radius
                            border: Border.all(color: isMonthly.value ? Color(0xFFEAECED) : Color(0xFFD62828), width: 1.6)
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.w), // Use ScreenUtil for padding
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment : CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Yearly',
                                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Color(0xFF6F7E8D)),
                                  ),
                                  isMonthly.value ?
                                  Container(
                                    height: 16.h, // Use ScreenUtil for height
                                    width: 16.w, // Use ScreenUtil for width
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Color(0xFFEAECED))
                                    ),
                                  ) :
                                  Container(
                                    height: 16.h, // Use ScreenUtil for height
                                    width: 16.w, // Use ScreenUtil for width
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFFD62828)
                                    ),
                                    child: Center(child: Icon(Icons.check, color: Colors.white, size: 12.sp,)),
                                  )
                                ],
                              ),
                              Text(
                                '\$49.99/year',
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: Color(0xFF020711)),
                              ),
                              Text(
                                'Billed Yearly',
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Color(0xFF6F7E8D)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),

              SizedBox(height: 30.h), // Use ScreenUtil for height

              GradientButton(
                text: 'Upgrade Plan',
                onPressed: () {},
                colors: [const Color(0xFFD62828), const Color(0xFFC21414)],
                boxShadow: [const BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)],
                child: Text(
                  'Upgrade Plan',
                  style: TextStyle(
                    fontSize: 16.sp,  // Use ScreenUtil for font size
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 10.h), // Use ScreenUtil for height

              Text(
                'Cancel anytime. Plan renews automatically',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Color(0xFF6F7E8D)),
              ),

              SizedBox(height: 5.h), // Use ScreenUtil for height
            ],
          ),
        ),
      ),
    );
  }
}
