// lib/app/modules/MyDealsDetails/views/my_deals_details_view.dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quopon/app/modules/VendorProfile/views/vendor_profile_view.dart';
import '../../MyDeals/controllers/my_deals_controller.dart';
import '../controllers/my_deals_details_controller.dart';

class MyDealsDetailsView extends StatelessWidget {
  final MyDealViewData data;
  const MyDealsDetailsView({super.key, required this.data});

  String _fmt(DateTime dt) => DateFormat('dd MMM yyyy').format(dt);

  String _expiresInText() {
    final now = DateTime.now();
    if (now.isAfter(data.endDate)) return 'Expired';
    final diff = data.endDate.difference(now);
    if (diff.inHours >= 24) {
      final days = diff.inDays;
      return 'Expires in $days day${days == 1 ? '' : 's'}';
    } else if (diff.inHours >= 1) {
      return 'Expires in ${diff.inHours} hour${diff.inHours == 1 ? '' : 's'}';
    } else {
      final mins = diff.inMinutes.clamp(1, 59);
      return 'Expires in $mins min';
    }
  }

  Color _statusBg(String status) {
    switch (status) {
      case 'Active':
        return const Color(0xFFECFDF5);
      case 'Upcoming':
        return const Color(0xFFEEF3FF);
      default:
        return const Color(0xFFFFEEEE);
    }
  }

  Color _statusFg(String status) {
    switch (status) {
      case 'Active':
        return const Color(0xFF2ECC71);
      case 'Upcoming':
        return const Color(0xFF1E92FF);
      default:
        return const Color(0xFFD62828);
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = data.statusText;
    final expiresText = status == 'Active' ? _expiresInText() : status;

    // Controller instance (scoped per wishlist row)
    final detailsC =
    Get.put(MyDealsDetailsController(), tag: 'wish_${data.wishlistId}');

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FBFC),
        centerTitle: true,
        title: Text('Deal Details', style: TextStyle(fontSize: 20.sp)),
        actions: [
          // ❤️ Heart -> delete from wishlist
          Obx(() {
            if (detailsC.isDeleting.value) {
              return Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              );
            }
            return IconButton(
              tooltip: 'Remove from My Deals',
              onPressed: () async {
                print(data.wishlistId);
                final ok =
                await detailsC.removeFromWishlist(data.wishlistId);
                if (ok) {
                  // Update the list reactively if the controller is in memory
                  if (Get.isRegistered<MyDealsController>()) {
                    final listC = Get.find<MyDealsController>();
                    listC.deals
                        .removeWhere((e) => e.wishlistId == data.wishlistId);
                  }
                  Get.back(); // Close details screen
                  Get.snackbar('Removed', 'Deal removed from My Deals');
                }
              },
              icon: const Icon(
                Icons.favorite_rounded,
                color: Color(0xFFD62828),
              ),
            );
          }),
          SizedBox(width: 12.w),
          Image.asset("assets/images/MyDealsDetails/Upload.png"),
          SizedBox(width: 8.w),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              // Hero image + expiry badge
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.network(
                      data.imageUrl,
                      fit: BoxFit.cover,
                      width: 398.w,
                      height: 220.h,
                      errorBuilder: (_, __, ___) => Container(
                        width: 398.w,
                        height: 220.h,
                        color: Colors.grey[200],
                        child: const Icon(Icons.local_offer, size: 48),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12.h,
                    right: 5.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      height: 24.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.r),
                        color: const Color(0xFFD62828),
                      ),
                      child: Center(
                        child: Text(
                          expiresText,
                          style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10.h),

              // Title + status
              SizedBox(
                width: 398.w,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        data.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      height: 26.h,
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.r),
                        color: _statusBg(status),
                      ),
                      child: Center(
                        child: Text(
                          status,
                          style: TextStyle(
                            color: _statusFg(status),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),

              // Description
              RichText(
                text: TextSpan(
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF6F7E8D)),
                  children: [
                    TextSpan(
                        text: data.description.isEmpty
                            ? 'No description available.'
                            : data.description),
                    TextSpan(
                      text: data.description.isEmpty ? '' : '  Read more...',
                      style: const TextStyle(
                          color: Color(0xFFD62828), fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),

              // Vendor section
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Vendor',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF020711))),
              ),
              SizedBox(height: 6.h),
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withAlpha(26), blurRadius: 20)
                  ],
                ),
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.network(
                        data.vendorLogoUrl ?? data.imageUrl,
                        width: 44.w,
                        height: 44.w,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.store),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data.vendorName,
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w500)),
                          Row(
                            children: [
                              Text('Valid Until: ',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFFD62828))),
                              Text(_fmt(data.endDate),
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[600])),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.r),
                        color: const Color(0xFFD62828),
                      ),
                      child: Text(
                        status == 'Active' ? 'LIVE' : status.toUpperCase(),
                        style:
                        TextStyle(color: Colors.white, fontSize: 12.sp),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12.h),

              // Redemption Method
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Redemption Method',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF020711))),
              ),
              SizedBox(height: 6.h),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 92.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.white,
                        border: Border.all(
                          color: data.redemptionType.toUpperCase() == 'PICKUP'
                              ? const Color(0xFFD62828)
                              : const Color(0xFFEFF1F2),
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                                'assets/images/MyDealsDetails/Pickup Icon.png',
                                height: 24.h,
                                width: 24.w),
                            SizedBox(height: 4.h),
                            Text('Pickup',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp,
                                    color: const Color(0xFF020711))),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(VendorProfileView(
                          vendorId: data.vendorId ?? 0,
                          logo: data.vendorLogoUrl ?? '',
                          name: data.vendorName,
                          type: '', // optional
                          address: '', // optional
                        ));
                      },
                      child: Container(
                        height: 92.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.white,
                          border: Border.all(
                            color: data.redemptionType.toUpperCase() ==
                                'DELIVERY'
                                ? const Color(0xFFD62828)
                                : const Color(0xFFEFF1F2),
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                  'assets/images/MyDealsDetails/Delivery Icon.png',
                                  height: 24.h,
                                  width: 24.w),
                              SizedBox(height: 4.h),
                              Text('Delivery',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.sp,
                                      color: const Color(0xFF020711))),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12.h),

              // Simple location placeholder (replace with real map if/when available)
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Text('Location',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF020711))),
                ),
              ),
              SizedBox(height: 6.h),
              Container(
                width: 398.w,
                height: 140.h,
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
                child: Image.asset('assets/images/MyDealsDetails/Location.png',
                    fit: BoxFit.cover),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
