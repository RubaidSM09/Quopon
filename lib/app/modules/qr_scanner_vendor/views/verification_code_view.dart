import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/qr_scanner_vendor/views/qr_success_vendor_view.dart';

import '../../../../common/customTextButton.dart';
import '../controllers/qr_scanner_vendor_controller.dart';

class VerificationCodeView extends GetView<QrScannerVendorController> {
  VerificationCodeView({super.key}) {
    Get.put(QrScannerVendorController());
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox.shrink(),
                  Text(
                    'Enter 6-Digit Verification Code',
                    style: TextStyle(
                      color: Color(0xFF020711),
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Divider(color: Color(0xFFEAECED)),
              SizedBox(height: 16.h),
              // Info Text
              Text(
                'If the QR code can’t be scanned, enter the 6-digit code provided by the customer to verify the pickup.',
                style: TextStyle(fontSize: 16.sp, color: Color(0xFF6F7E8D)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              // Input boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 45.w,
                    height: 55.h,
                    child: TextField(
                      controller: controller.controllers[index],
                      focusNode: controller.focusNodes[index],
                      onChanged: (value) =>
                          controller.onDigitEntered(index, value),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      maxLength: 1,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF020711),
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: Color(0xFFEAECED)),
                        ),
                        filled: true,
                        fillColor: Color(0xFFF4F6F7),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 24.h),
              // Verify Button
              SizedBox(
                width: double.infinity,
                child: GradientButton(
                  text: 'Verify',
                  onPressed: () {
                    print("Verification Code: ${controller.code}");
                    // Do your verification logic here...
                    Get.back(); // close dialog
                    Get.delete<QrScannerVendorController>();
                    Get.dialog(QrSuccessVendorView(dealTitle: '50% Off Any Grande Beverage', dealStoreName: 'Starbucks', brandLogo: 'assets/images/deals/details/Starbucks_Logo.png', time: '01:05 AM'));
                  },
                  colors: [const Color(0xFFD62828), const Color(0xFFC21414)],
                  boxShadow: [
                    const BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1),
                  ],
                  child: Text(
                    'Verify',
                    style: TextStyle(
                      fontSize: 16.sp, // Use ScreenUtil for font size
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
