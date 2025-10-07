import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quopon/app/modules/vendor_create_deal/views/vendor_create_deal_view.dart';
import 'package:quopon/common/my_deals_card.dart';
import '../../vendor_deal_performance/views/vendor_deal_performance_view.dart';
import '../controllers/vendor_deals_controller.dart';

class VendorDealsView extends GetView<VendorDealsController> {
  const VendorDealsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VendorDealsController());

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFC),
      body: RefreshIndicator(
        onRefresh: () => controller.fetchDeals(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 16.h),
            child: Column(
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Active Deals',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: const Color(0xFF020711),
                          ),
                        ),
                        Text(
                          'Manage your currently active deals.',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: const Color(0xFF6F7E8D),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(15),
                                blurRadius: 16,
                              )
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () => Get.to(() => VendorCreateDealView()),
                            child: const Icon(Icons.add),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Container(
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(15),
                                blurRadius: 16,
                              )
                            ],
                          ),
                          child: Image.asset('assets/images/Home/Notification.png'),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                // Search bar
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) => controller.searchDeals(value),
                          decoration: InputDecoration(
                            hintText: 'Search deals by title...',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Image.asset('assets/images/Home/Search.png'),
                    ],
                  ),
                ),

                SizedBox(height: 15.h),

                // Deals list
                Obx(() {
                  final list = controller.filteredActiveDeals;
                  if (list.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                      child: Center(
                        child: Text(
                          'No active deals found',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color(0xFF6F7E8D),
                          ),
                        ),
                      ),
                    );
                  }

                  return Column(
                    children: list.map((deal) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: VendorDealCard(
                          image: deal.imageUrl ?? '',
                          title: deal.title ?? 'Untitled Deal',
                          views: deal.viewCount,
                          redemptions: deal.redemptionCount,
                          startValidTime: deal.startDate ?? '',
                          endValidTime: deal.endDate ?? '',
                          onTap: () => Get.to(() => VendorDealPerformanceView(deal: deal)),
                        ),
                      );
                    }).toList(),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}