import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:get/get.dart';
import 'package:quopon/app/modules/SupportFAQ/views/faq_view.dart';
import 'package:quopon/app/modules/SupportFAQ/views/get_in_touch_view.dart';
import 'package:quopon/app/modules/SupportFAQ/views/help_center_view.dart';
import 'package:quopon/app/modules/SupportFAQ/views/report_problem_view.dart';

import '../../../../common/customTextButton.dart';
import '../controllers/support_f_a_q_controller.dart';

class SupportFAQView extends GetView<SupportFAQController> {
  const SupportFAQView({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isFAQ = false.obs;

    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 16.h), // Use ScreenUtil for padding
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back, size: 24.sp),
                  ),
                  Text(
                    'Support / FAQ',
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                  ),
                  SizedBox(),
                ],
              ),

              SizedBox(height: 20.h),

              Obx(() {
                return Column(
                  children: [
                    Container(
                      height: 48.h,
                      width: 398.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: Color(0xFFF1F3F4)
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(4.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if(isFAQ.value) {
                                  isFAQ.value = !isFAQ.value;
                                }
                              },
                              child: Container(
                                height: 40.h,
                                width: 185.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: isFAQ.value ? Color(0xFFF1F3F4) : Color(0xFFD62828),
                                ),
                                child: Center(
                                  child: Text(
                                    'Help Center',
                                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: isFAQ.value ? Color(0xFF6F7E8D) : Color(0xFFFFFFFF)),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if(!isFAQ.value) {
                                  isFAQ.value = !isFAQ.value;
                                }
                              },
                              child: Container(
                                height: 40.h,
                                width: 185.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: !isFAQ.value ? Color(0xFFF1F3F4) : Color(0xFFD62828)
                                ),
                                child: Center(
                                  child: Text(
                                    'FAQ',
                                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: !isFAQ.value ? Color(0xFF6F7E8D) : Color(0xFFFFFFFF)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    !isFAQ.value ? HelpCenterView() : FaqView(),
                  ],
                );
              }),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
          child: GradientButton(
            onPressed: () {
              Get.dialog(ReportProblemView());
            },
            text: "Follow",
            colors: [Color(0xFFF4F5F6), Color(0xFFEEF0F3)],
            width: 195.w,
            height: 44.h,
            borderRadius: 12.r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/images/SupportFAQ/Report.png"),
                SizedBox(width: 10.w),
                Text(
                  "Report a Problem",
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
