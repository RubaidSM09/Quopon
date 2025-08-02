import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/ChooseRedemptionDeal/views/choose_redemption_deal_view.dart';

import '../../../../common/deal_card.dart';

class PickupView extends GetView {
  final String dealImage;
  final String dealTitle;
  final String dealDescription;
  final String dealValidity;
  final String dealStoreName;
  final String brandLogo;

  const PickupView({
    super.key,
    required this.dealImage,
    required this.dealTitle,
    required this.dealDescription,
    required this.dealValidity,
    required this.dealStoreName,
    required this.brandLogo
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);  // Close the detail view on tapping outside
      },
      child: Dialog(
        backgroundColor: Colors.black.withOpacity(0.0),
        child: Center(
          child: GestureDetector(
            onTap: () {},
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
                            child: Icon(Icons.close, size: 24.r,)
                        )
                      ],
                    ),
                    SizedBox(height: 16.h,),
                    Divider(
                      color: Color(0xFFEAECED),
                      thickness: 1,
                    ),
                    SizedBox(height: 16.h,),
                    Column(
                      children: [
                        Text(
                          "Show this QR at the counter. If it doesn’t scan, use the 6-digit code below.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp, color: Color(0xFF6F7E8D)),
                        ),
                        SizedBox(height: 24.h,),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r)
                          ),
                          child: ClipRRect(
                            child: Image.asset(
                              "assets/images/Pickup/QR Code.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 51.h,
                              width: 51.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: Color(0xFFF9FBFC),
                                border: Border.all(color: Color(0xFFEFF1F2), width: 1)
                              ),
                              child: Center(
                                child: Text(
                                  '8',
                                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600, color: Color(0xFF020711)),
                                ),
                              ),
                            ),

                            Container(
                              height: 51.h,
                              width: 51.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: Color(0xFFF9FBFC),
                                  border: Border.all(color: Color(0xFFEFF1F2), width: 1)
                              ),
                              child: Center(
                                child: Text(
                                  '2',
                                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600, color: Color(0xFF020711)),
                                ),
                              ),
                            ),

                            Container(
                              height: 51.h,
                              width: 51.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: Color(0xFFF9FBFC),
                                  border: Border.all(color: Color(0xFFEFF1F2), width: 1)
                              ),
                              child: Center(
                                child: Text(
                                  '0',
                                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600, color: Color(0xFF020711)),
                                ),
                              ),
                            ),

                            Container(
                              height: 51.h,
                              width: 51.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: Color(0xFFF9FBFC),
                                  border: Border.all(color: Color(0xFFEFF1F2), width: 1)
                              ),
                              child: Center(
                                child: Text(
                                  '1',
                                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600, color: Color(0xFF020711)),
                                ),
                              ),
                            ),

                            Container(
                              height: 51.h,
                              width: 51.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: Color(0xFFF9FBFC),
                                  border: Border.all(color: Color(0xFFEFF1F2), width: 1)
                              ),
                              child: Center(
                                child: Text(
                                  '7',
                                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600, color: Color(0xFF020711)),
                                ),
                              ),
                            ),

                            Container(
                              height: 51.h,
                              width: 51.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: Color(0xFFF9FBFC),
                                  border: Border.all(color: Color(0xFFEFF1F2), width: 1)
                              ),
                              child: Center(
                                child: Text(
                                  '5',
                                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600, color: Color(0xFF020711)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h,),
                        DealCard(
                          brandLogo: brandLogo,
                          dealStoreName: dealStoreName,
                          dealValidity: dealValidity,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ),
          ),
        ),
      ),
    );
  }
}
