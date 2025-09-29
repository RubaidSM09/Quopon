import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:quopon/app/modules/QuoponPlus/views/quopon_plus_benifits_view.dart';
import '../../../../common/customTextButton.dart';
import '../controllers/quopon_plus_controller.dart';

class QuoponPlusView extends GetView<QuoponPlusController> {
  const QuoponPlusView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(QuoponPlusController());

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16.r),
          topLeft: Radius.circular(16.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox.shrink(),
                  Text('Qoupon+',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp)),
                  GestureDetector(onTap: () => Get.back(), child: const Icon(Icons.close)),
                ],
              ),
              SizedBox(height: 5.h),
              const Divider(),
              SizedBox(height: 10.h),

              Text('Unlock Exclusive Benefits',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24.sp)),
              Text(
                'Access exclusive deals, enhanced savings, and premium member benefits with Qoupon+.',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp, color: const Color(0xFF6F7E8D)),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 16.h),

              // Loading / Error
              Obx(() {
                if (ctrl.isLoading.value) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 18.h, width: 18.w, child: const CircularProgressIndicator(strokeWidth: 2)),
                        SizedBox(width: 8.w),
                        Text('Fetching latest plans...',
                            style: TextStyle(fontSize: 14.sp, color: const Color(0xFF6F7E8D))),
                      ],
                    ),
                  );
                }
                if (ctrl.error.value != null) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Column(
                      children: [
                        Text('Couldn’t load plans. Please try again.',
                            style: TextStyle(fontSize: 14.sp, color: Colors.red),
                            textAlign: TextAlign.center),
                        SizedBox(height: 6.h),
                        GestureDetector(
                          onTap: ctrl.fetchPlans,
                          child: Text('Retry',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 14.sp,
                                  color: const Color(0xFFD62828))),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),

              // Benefits (unchanged)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: const Color(0xFFF9FBFC),
                  border: Border.all(color: const Color(0xFFEFF1F2)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: Column(
                  children: [
                    QuoponPlusBenifitsView(
                      icon: 'assets/images/QuoponPlus/Access.png',
                      title: 'Access premium-only deals',
                      subTitle: 'Lorem Ipsum is simply dummy text of the printing industry.',
                    ),
                    SizedBox(height: 10.h),
                    QuoponPlusBenifitsView(
                      icon: 'assets/images/QuoponPlus/EarlyAccess.png',
                      title: 'Early access to limited offers',
                      subTitle: 'Lorem Ipsum is simply dummy text of the printing industry.',
                    ),
                    SizedBox(height: 10.h),
                    QuoponPlusBenifitsView(
                      icon: 'assets/images/QuoponPlus/Cashback.png',
                      title: 'Extra cashback on select vendors',
                      subTitle: 'Lorem Ipsum is simply dummy text of the printing industry.',
                    ),
                    SizedBox(height: 10.h),
                    QuoponPlusBenifitsView(
                      icon: 'assets/images/QuoponPlus/MonthlySurprise.png',
                      title: 'Monthly surprise deals',
                      subTitle: 'Lorem Ipsum is simply dummy text of the printing industry.',
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // Plans row (now dynamic)
              Obx(() {
                final monthly = ctrl.monthlyPlan;
                final yearly = ctrl.yearlyPlan;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Monthly card
                    GestureDetector(
                      onTap: () => ctrl.isMonthly.value = true,
                      child: Container(
                        width: 185.w,
                        height: 112.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: ctrl.isMonthly.value ? const Color(0xFFD62828) : const Color(0xFFEAECED),
                            width: 1.6,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Monthly',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400, fontSize: 14.sp, color: const Color(0xFF6F7E8D))),
                                  ctrl.isMonthly.value
                                      ? Container(
                                    height: 16.h,
                                    width: 16.w,
                                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFD62828)),
                                    child: Center(child: Icon(Icons.check, color: Colors.white, size: 12.sp)),
                                  )
                                      : Container(
                                    height: 16.h,
                                    width: 16.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: const Color(0xFFEAECED)),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                monthly?.displayPrice ?? '--',
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: const Color(0xFF020711)),
                              ),
                              Text(
                                monthly?.billedText ?? 'Billed Monthly',
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: const Color(0xFF6F7E8D)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Yearly card
                    GestureDetector(
                      onTap: () => ctrl.isMonthly.value = false,
                      child: Container(
                        width: 185.w,
                        height: 112.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: ctrl.isMonthly.value ? const Color(0xFFEAECED) : const Color(0xFFD62828),
                            width: 1.6,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Yearly',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400, fontSize: 14.sp, color: const Color(0xFF6F7E8D))),
                                  ctrl.isMonthly.value
                                      ? Container(
                                    height: 16.h,
                                    width: 16.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: const Color(0xFFEAECED)),
                                    ),
                                  )
                                      : Container(
                                    height: 16.h,
                                    width: 16.w,
                                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFD62828)),
                                    child: Center(child: Icon(Icons.check, color: Colors.white, size: 12.sp)),
                                  ),
                                ],
                              ),
                              Text(
                                yearly?.displayPrice ?? '--',
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: const Color(0xFF020711)),
                              ),
                              Text(
                                yearly?.billedText ?? 'Billed Yearly',
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: const Color(0xFF6F7E8D)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),

              SizedBox(height: 30.h),

              // Upgrade button (uses selected plan)
              Obx(() {
                final selected = ctrl.isMonthly.value ? ctrl.monthlyPlan : ctrl.yearlyPlan;
                final btnText = selected == null
                    ? 'Upgrade Plan'
                    : 'Upgrade to ${selected.name} (${selected.currencySymbol}${selected.amount})';

                return AbsorbPointer(
                  absorbing: selected == null || ctrl.isSubscribing.value,
                  child: Opacity(
                    opacity: (selected == null || ctrl.isSubscribing.value) ? 0.5 : 1.0,
                    child: GradientButton(
                      text: btnText,
                      onPressed: () {
                        final sp = selected;
                        if (sp == null) return;
                        ctrl.subscribe(sp);                      // <-- call here
                      },
                      colors: const [Color(0xFFD62828), Color(0xFFC21414)],
                      boxShadow: const [BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)],
                      child: Obx(() => ctrl.isSubscribing.value
                          ? SizedBox(height: 18.h, width: 18.w, child: const CircularProgressIndicator(strokeWidth: 2))
                          : Text(btnText, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.white))),
                    ),
                  ),
                );
              }),

              SizedBox(height: 10.h),
              Text('Cancel anytime. Plan renews automatically',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: const Color(0xFF6F7E8D))),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}
