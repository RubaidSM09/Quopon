import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quopon/app/modules/ChooseRedemptionDeal/views/choose_redemption_deal_view.dart';
import 'package:quopon/app/modules/ChooseRedemptionDeal/views/pickup_view.dart';
import 'package:quopon/app/modules/VendorProfile/views/vendor_profile_view.dart';

import '../../../../common/customTextButton.dart';
import '../../home/views/home_view.dart';
import '../controllers/deal_detail_controller.dart';

class DealDetailView extends GetView<DealDetailController> {
  final int dealId;
  final String dealImage;
  final String dealTitle;
  final String dealDescription;
  final String dealValidity;
  final String dealStoreName;
  final String brandLogo;
  final String redemptionType;
  final String deliveryCost;
  final int minOrder;

  const DealDetailView({
    super.key,
    required this.dealId,
    required this.dealImage,
    required this.dealTitle,
    required this.dealDescription,
    required this.dealValidity,
    required this.dealStoreName,
    required this.brandLogo,
    required this.redemptionType,
    required this.deliveryCost,
    required this.minOrder,
  });

  @override
  Widget build(BuildContext context) {
    // one controller per deal dialog, keyed by deal id
    final dealC = Get.put(DealDetailController(), tag: 'deal_$dealId');
    dealC.init(dealId); // preload saved state via GET /wish-deals

    RxBool isPickup = true.obs;

    return Dialog(
      child: Container(
        padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h, bottom: 20.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FBFC),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Close button (top-right)
              Stack(
                children: [
                  // Deal Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.network(
                      dealImage, // Image of the deal
                      width: double.infinity,
                      height: 220.h,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Positioned(
                    top: 12.h,
                    right: 12.w,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 36.h,
                        width: 36.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withAlpha(128),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12.h),

              // Deal Title
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          dealTitle,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),

                        /// ❤️ Heart — toggles add/remove
                        Obx(() {
                          final saved = dealC.isSaved.value;
                          final busy  = dealC.isSaving.value;

                          return GestureDetector(
                            onTap: busy
                                ? null
                                : () async {
                              final wasSaved = saved;
                              await dealC.toggleWishlist();
                              if (!wasSaved && dealC.isSaved.value && context.mounted) {
                                showTopSavedDealBanner(context);
                              } else if (wasSaved && !dealC.isSaved.value) {
                                Get.snackbar('Removed', 'Deal removed from My Deals');
                              }
                            },
                            child: busy
                                ? SizedBox(
                              height: 24, width: 24,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2, color: Color(0xFFD62828),
                              ),
                            )
                                : Icon(
                              saved
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_outline_rounded,
                              color: const Color(0xFFD62828),
                            ),
                          );
                        }),
                      ],
                    ),
                    SizedBox(height: 8.h),

                    // Deal Description
                    Text(
                      dealDescription,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 8.h),

                    Row(
                      spacing: 8.w,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: Color(0xFFF3F5F6),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            spacing: 8.w,
                            children: [
                              Image.asset(
                                'assets/images/deals/details/vendor_icon.png',
                                scale: 4,
                              ),

                              Text(
                                'Restaurant Mario',
                                style: TextStyle(
                                  color: Color(0xFF6F7E8D),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: Color(0xFFF3F5F6),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            spacing: 8.w,
                            children: [
                              Image.asset(
                                'assets/images/deals/details/vendor_location.png',
                                scale: 4,
                              ),

                              Text(
                                'Utrecht',
                                style: TextStyle(
                                  color: Color(0xFF6F7E8D),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),

                    // Deal Store Name and Validity
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(26),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        brandLogo,
                                        height: 44.h,
                                        width: 44.w,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          dealStoreName,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Valid Until: ',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xFFD62828),
                                              ),
                                            ),
                                            Text(
                                              dealValidity,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 63.w,
                                  height: 22.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: const Color(0xFFD62828),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '50% OFF',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const Divider(color: Color(0xFFF0F2F3)),

                            SizedBox(height: 6.h),

                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h,),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: const Color(0xFFB81EFF).withAlpha(20),
                                  ),
                                  child: Text(
                                    'Redemption: $redemptionType',
                                    style: TextStyle(
                                      color: const Color(0xFFB81EFF),
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ),

                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h,),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: const Color(0xFF1E92FF).withAlpha(20),
                                  ),
                                  child: Text(
                                    'Delivery Cost: \$$deliveryCost',
                                    style: TextStyle(
                                      color: const Color(0xFF1E92FF),
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ),

                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h,),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: const Color(0xFFFF8E24).withAlpha(20),
                                  ),
                                  child: Text(
                                    'Min. Order Amount: \$$minOrder',
                                    style: TextStyle(
                                      color: const Color(0xFFFF8E24),
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    GradientButton(
                      text: 'Order Now',
                      onPressed: () {
                        Get.to(
                          VendorProfileView(
                            vendorId: 0,
                            logo: brandLogo,
                            name: dealStoreName,
                            type: 'Cafe',
                            address: 'Downtown',
                          ),
                        );
                      },
                      colors: [const Color(0xFFD62828), const Color(0xFFC21414)],
                      boxShadow: [
                        const BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1),
                      ],
                      child: Text(
                        'Order Now',
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
            ],
          ),
        ),
      ),
    );
  }

  void showTopSavedDealBanner(BuildContext context) {
    final overlay = Overlay.of(context);

    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 24.h,
        left: 112.w,
        right: 112.w,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(26), blurRadius: 20),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.favorite_rounded, color: Color(0xFFD62828)),
                    SizedBox(width: 8.w),
                    Text(
                      "Saved to My Deals",
                      style: TextStyle(
                        color: const Color(0xFFD62828),
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => overlayEntry.remove(),
                  child: Icon(
                    Icons.close,
                    color: const Color(0xFFD62828),
                    size: 16.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Auto remove
    Future.delayed(const Duration(seconds: 3), () {
      if (overlayEntry.mounted) overlayEntry.remove();
    });
  }
}
