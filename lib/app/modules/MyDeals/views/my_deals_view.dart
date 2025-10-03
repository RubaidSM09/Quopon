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
    final c = Get.put(MyDealsController()); // or bind via AppPages

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFC),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 398.w, // Use ScreenUtil for width
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('My Deals', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp)), // Use ScreenUtil for font size
                      Text('Quick access to your claimed deals.', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12.sp)),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Image.asset('assets/images/Home/Notification.png'),
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
            SizedBox(height: 20.h), // Use ScreenUtil for height spacing
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r), // Use ScreenUtil for radius
                color: const Color(0xFFF1F3F4),
              ),
              width: 398.w, // Use ScreenUtil for width
              height: 48.h, // Use ScreenUtil for height
              child: Padding(
                padding: EdgeInsets.all(4.w), // Use ScreenUtil for padding
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 40.h, // Use ScreenUtil for height
                      width: 127.33.w, // Use ScreenUtil for width
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r), // Use ScreenUtil for radius
                        color: const Color(0xFFD62828),
                      ),
                      child: Center(
                        child: Text('Active', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.white)),
                      ),
                    ),
                    Container(
                      height: 40.h, // Use ScreenUtil for height
                      width: 127.33.w, // Use ScreenUtil for width
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r), // Use ScreenUtil for radius
                        color: const Color(0xFFF1F3F4),
                      ),
                      child: Center(
                        child: Text('Used', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D))),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 40.h, // Use ScreenUtil for height
                        width: 127.33.w, // Use ScreenUtil for width
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r), // Use ScreenUtil for radius
                          color: const Color(0xFFF1F3F4),
                        ),
                        child: Center(
                          child: Text('Expired', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20.h),
            Obx(() => Text(
              'Total Deals: ${c.deals.length}',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF6F7E8D),
              ),
            )),
            SizedBox(height: 20.h),

            Expanded(
              child: Obx(() {
                if (c.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (c.deals.isEmpty) {
                  return const Center(child: Text('No deals yet'));
                }

                return RefreshIndicator(
                  onRefresh: () => c.fetchMyDeals(),
                  child: ListView.builder(
                    itemCount: c.deals.length,
                    itemBuilder: (_, i) {
                      final d = c.deals[i];
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
