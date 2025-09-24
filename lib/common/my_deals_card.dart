import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quopon/app/modules/vendor_deal_performance/views/vendor_deal_performance_view.dart';
import 'package:quopon/app/modules/vendor_deals/views/deals_options_view.dart';

class MyDealsCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final String statusText;

  const MyDealsCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.statusText,
  });

  String _fmt(DateTime dt) {
    // dd MMM yyyy
    final months = [
      'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'
    ];
    return '${dt.day.toString().padLeft(2, '0')} ${months[dt.month-1]} ${dt.year}';
  }

  Color _statusBg() {
    switch (statusText) {
      case 'Active': return const Color(0xFFECFDF5);
      case 'Upcoming': return const Color(0xFFEEF3FF);
      default: return const Color(0xFFFFEEEE);
    }
  }

  Color _statusFg() {
    switch (statusText) {
      case 'Active': return const Color(0xFF2ECC71);
      case 'Upcoming': return const Color(0xFF1E92FF);
      default: return const Color(0xFFD62828);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Container(
        width: 398.w,
        height: 82.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  imageUrl,
                  width: 58.w,
                  height: 58.h,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.local_offer),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: const Color(0xFF020711),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Valid: ',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: const Color(0xFFD62828),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${_fmt(startDate)} - ${_fmt(endDate)}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: const Color(0xFF6F7E8D),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              Container(
                height: 26.h,
                width: 58.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  color: _statusBg(),
                ),
                child: Center(
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: _statusFg(),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
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

class VendorDealCard extends GetView {
  final String image;
  final String title;
  final int views;
  final int redemptions;
  final String startValidTime;
  final String endValidTime;

  const VendorDealCard({
    required this.image,
    required this.title,
    required this.views,
    required this.redemptions,
    required this.startValidTime,
    required this.endValidTime,
    super.key,
  });

  String _formatDate(String dateStr) {
    try {
      final dt = DateTime.parse(dateStr);
      return DateFormat("dd MMM yyyy").format(dt);
    } catch (_) {
      return dateStr; // fallback if parsing fails
    }
  }

  @override
  Widget build(BuildContext context) {
    final start = _formatDate(startValidTime);
    final end = _formatDate(endValidTime);

    return GestureDetector(
      onTap: () {
        Get.to(VendorDealPerformanceView());
      },
      child: Container(
        padding: EdgeInsets.only(right: 12.w, left: 8.w, top: 8.h, bottom: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 80.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.network(image, fit: BoxFit.cover, scale: 4),
                  ),
                ),
                SizedBox(width: 10.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: const Color(0xFF020711),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${NumberFormat.decimalPattern().format(views)} Views    ',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: const Color(0xFF6F7E8D),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFCAD9E8),
                          ),
                          height: 5.h,
                          width: 5.w,
                        ),
                        Text(
                          '   ${NumberFormat.decimalPattern().format(redemptions)} Redemptions',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: const Color(0xFF6F7E8D),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Valid: ',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: const Color(0xFFD62828),
                          ),
                        ),
                        Text(
                          '$start - $end',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: const Color(0xFF6F7E8D),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Get.bottomSheet(DealsOptionsView());
              },
              child: const Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
    );
  }
}
