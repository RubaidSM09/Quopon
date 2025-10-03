import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/customTextButton.dart';

class QRSuccessView extends StatelessWidget {
  final String dealTitle;
  final String vendorName;
  final String brandLogoUrl;
  final String time;

  const QRSuccessView({
    super.key,
    required this.dealTitle,
    required this.vendorName,
    required this.brandLogoUrl,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Get.back,
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.0),
        body: Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: 398.w,
              height: 451.h,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FBFC),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8.r,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/QR/confetti 1.png'),
                  SizedBox(height: 20.h),
                  Text(
                    'Congratulations! Deal Redeemed',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF020711),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "You've successfully redeemed the deal at $vendorName",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF020711),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipOval(
                                child: SizedBox(
                                  height: 44.w,
                                  width: 44.w,
                                  child: Image.network(
                                    brandLogoUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                    const Icon(Icons.local_offer),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dealTitle,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Row(
                                      children: [
                                        Text(
                                          'Redeemed at ',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        Icon(Icons.circle,
                                            color: Colors.grey[300], size: 10.sp),
                                        Text(
                                          ' $time',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Container(
                            height: 40.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: const Color(0xFFECFDF5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.check, color: Color(0xFF2ECC71)),
                                SizedBox(width: 6.w),
                                Text(
                                  'Verified Redemption',
                                  style: TextStyle(
                                    color: const Color(0xFF2ECC71),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  GradientButton(
                    text: 'Done',
                    onPressed: Get.back,
                    colors: const [Color(0xFFD62828), Color(0xFFC21414)],
                    boxShadow: const [BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)],
                    child: Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
