// lib/app/modules/MyDeals/views/my_deals_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quopon/app/modules/MyDealsDetails/views/my_deals_details_view.dart';
import 'package:quopon/common/my_deals_card.dart';
import '../controllers/my_deals_controller.dart';

class MyDealsView extends GetView<MyDealsController> {
  const MyDealsView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(MyDealsController());

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFC),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 398.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('My Deals',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16.sp)),
                      Text('Quick access to your claimed deals.',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 12.sp)),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon:
                        Image.asset('assets/images/Home/Notification.png'),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Image.asset('assets/images/Home/Cart.png'),
                        onPressed: () {},
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // Tabs: Active / Used / Expired
            Obx(() {
              final sel = c.selectedTab.value;
              Color tabBg(int i) =>
                  sel == i ? const Color(0xFFD62828) : const Color(0xFFF1F3F4);
              Color tabFg(int i) =>
                  sel == i ? Colors.white : const Color(0xFF6F7E8D);
              FontWeight tabW(int i) => sel == i ? FontWeight.w500 : FontWeight.w400;

              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: const Color(0xFFF1F3F4),
                ),
                width: 398.w,
                height: 48.h,
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => c.selectedTab.value = 0,
                        child: Container(
                          height: 40.h,
                          width: 127.33.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: tabBg(0),
                          ),
                          child: Center(
                            child: Text('Active',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: tabW(0),
                                    color: tabFg(0))),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => c.selectedTab.value = 1,
                        child: Container(
                          height: 40.h,
                          width: 127.33.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: tabBg(1),
                          ),
                          child: Center(
                            child: Text('Used',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: tabW(1),
                                    color: tabFg(1))),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => c.selectedTab.value = 2,
                          child: Container(
                            height: 40.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: tabBg(2),
                            ),
                            child: Center(
                              child: Text('Expired',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: tabW(2),
                                      color: tabFg(2))),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            SizedBox(height: 20.h),

            // Count label reflects the selected tab's list length
            Obx(() {
              final sel = c.selectedTab.value;
              final count = sel == 0
                  ? c.activeDeals.length
                  : sel == 1
                  ? c.usedDeals.length
                  : c.expiredDeals.length;
              return Text(
                'Total Deals: $count',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF6F7E8D),
                ),
              );
            }),

            SizedBox(height: 20.h),

            // Body
            Expanded(
              child: Obx(() {
                if (c.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Choose list based on selected tab
                final sel = c.selectedTab.value;
                final List<MyDealViewData> items = sel == 0
                    ? c.activeDeals
                    : sel == 1
                    ? c.usedDeals
                    : c.expiredDeals;

                if (items.isEmpty) {
                  return Center(
                    child: Text(
                      sel == 0
                          ? 'No active deals'
                          : sel == 1
                          ? 'No used deals'
                          : 'No expired deals',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF6F7E8D),
                      ),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () => c.fetchMyDeals(),
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (_, i) {
                      final d = items[i];
                      return GestureDetector(
                        onTap: () {
                          Get.to(MyDealsDetailsView(data: d));
                        },
                        child: MyDealsCard(
                          imageUrl: d.imageUrl,
                          title: d.title,
                          startDate: d.startDate,
                          endDate: d.endDate,
                          statusText: d.statusText,
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
