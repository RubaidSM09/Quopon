import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PickupView extends GetView {
  final String qRCodeImage;
  final String verificationCOde;

  const PickupView({
    required this.qRCodeImage,
    required this.verificationCOde,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Split the verification code into individual characters
    final codeDigits = verificationCOde.split('').take(6).toList();

    return GestureDetector(
      onTap: () {
        Navigator.pop(context); // Close the dialog on tapping outside
      },
      child: Dialog(
        backgroundColor: Colors.black.withOpacity(0.0),
        child: Center(
          child: GestureDetector(
            onTap: () {}, // Prevent dialog from closing when tapping inside
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8.r,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox.shrink(),
                        Text(
                          "QR Code is Ready",
                          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close, size: 24.r),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Divider(
                      color: Color(0xFFEAECED),
                      thickness: 1,
                    ),
                    SizedBox(height: 16.h),
                    Column(
                      children: [
                        Text(
                          "Show this QR at the counter. If it doesn’t scan, use the 6-digit code below.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                              color: Color(0xFF6F7E8D)),
                        ),
                        SizedBox(height: 24.h),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: Image.network(
                              qRCodeImage.startsWith('http')
                                  ? qRCodeImage
                                  : 'http://10.10.13.99:8090$qRCodeImage',
                              fit: BoxFit.cover,
                              width: 200.w,
                              height: 200.h,
                              errorBuilder: (context, error, stackTrace) => Icon(
                                Icons.broken_image,
                                size: 100.w,
                                color: Color(0xFF6F7E8D),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            6,
                                (index) => Container(
                              height: 51.h,
                              width: 51.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: Color(0xFFF9FBFC),
                                border: Border.all(color: Color(0xFFEFF1F2), width: 1),
                              ),
                              child: Center(
                                child: Text(
                                  codeDigits.length > index ? codeDigits[index] : '-',
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF020711)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}