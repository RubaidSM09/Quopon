import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quopon/app/modules/vendor_create_deal/views/vendor_create_deal_view.dart';
import 'package:quopon/app/modules/vendor_dashboard/views/dashboard_view.dart';
import 'package:quopon/app/modules/vendor_deals/views/vendor_deals_view.dart';
import 'package:quopon/app/modules/vendor_menu/views/vendor_menu_view.dart';
import 'package:quopon/common/deal_card.dart';
import 'package:quopon/common/my_deals_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil

import '../controllers/vendor_dashboard_controller.dart';

class VendorDashboardView extends GetView<VendorDashboardController> {
  const VendorDashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;

    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 16.h),  // Use ScreenUtil for padding
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20.r,  // Use ScreenUtil for radius
                        backgroundImage: AssetImage('assets/images/Vendor/Dashboard/Starbucks.png'),
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, Good Evening!',
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: Color(0xFF020711)),  // Use ScreenUtil for font size
                          ),
                          Text(
                            'Starbucks',
                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Color(0xFF6F7E8D)),  // Use ScreenUtil for font size
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.w),  // Use ScreenUtil for padding
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16)]
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(VendorCreateDealView());
                          },
                          child: Icon(Icons.add),
                        ),
                      ),
                      SizedBox(width: 12.w,),
                      Container(
                        padding: EdgeInsets.all(8.r),  // Use ScreenUtil for padding
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16)]
                        ),
                        child: Image.asset('assets/images/Home/Notification.png'),
                      ),
                    ],
                  )
                ],
              ),

              SizedBox(height: 15.h),

              Row(
                children: [
                  Text(
                    'Dashboard',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp, color: Color(0xFF020711)),  // Use ScreenUtil for font size
                  ),
                  SizedBox.shrink()
                ],
              ),

              SizedBox(height: 5.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      DashboardView(
                        title: 'Total Deals Published',
                        count: 54,
                        isImproved: true,
                        change: 12.8,
                      ),
                      SizedBox(height: 10.h),
                      DashboardView(
                        title: 'Redemption Rate (%)',
                        count: 39,
                        isRate: true,
                        isImproved: false,
                        change: 12.8,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      DashboardView(
                        title: 'Total Redemptions',
                        count: 1283,
                        isImproved: false,
                        change: 12.8,
                      ),
                      SizedBox(height: 10.h),
                      DashboardView(
                        title: 'Pushes Sent',
                        count: 2872,
                        isImproved: true,
                        change: 12.8,
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              Row(
                children: [
                  Text(
                    'Push History',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp, color: Color(0xFF020711)),  // Use ScreenUtil for font size
                  ),
                  SizedBox.shrink(),
                ],
              ),

              SizedBox(height: 5.h),

              VendorDealCard(
                image: 'assets/images/MyDeals/StarBucks.png',
                title: '50% Off Any Grande Beverage',
                views: 1245,
                redemptions: 412,
                startValidTime: '28 May 2025',
                endValidTime: '10 Jun 2025',
              ),
              SizedBox(height: 7.5.h),
              VendorDealCard(
                image: 'assets/images/MyDeals/StarBucks.png',
                title: '50% Off Any Grande Beverage',
                views: 1245,
                redemptions: 412,
                startValidTime: '28 May 2025',
                endValidTime: '10 Jun 2025',
              ),
              SizedBox(height: 7.5.h),
              VendorDealCard(
                image: 'assets/images/MyDeals/StarBucks.png',
                title: '50% Off Any Grande Beverage',
                views: 1245,
                redemptions: 412,
                startValidTime: '28 May 2025',
                endValidTime: '10 Jun 2025',
              ),
              SizedBox(height: 7.5.h),
              VendorDealCard(
                image: 'assets/images/MyDeals/StarBucks.png',
                title: '50% Off Any Grande Beverage',
                views: 1245,
                redemptions: 412,
                startValidTime: '28 May 2025',
                endValidTime: '10 Jun 2025',
              ),
              SizedBox(height: 7.5.h),
              VendorDealCard(
                image: 'assets/images/MyDeals/StarBucks.png',
                title: '50% Off Any Grande Beverage',
                views: 1245,
                redemptions: 412,
                startValidTime: '28 May 2025',
                endValidTime: '10 Jun 2025',
              ),
              SizedBox(height: 7.5.h),
              VendorDealCard(
                image: 'assets/images/MyDeals/StarBucks.png',
                title: '50% Off Any Grande Beverage',
                views: 1245,
                redemptions: 412,
                startValidTime: '28 May 2025',
                endValidTime: '10 Jun 2025',
              ),
              SizedBox(height: 7.5.h),
              VendorDealCard(
                image: 'assets/images/MyDeals/StarBucks.png',
                title: '50% Off Any Grande Beverage',
                views: 1245,
                redemptions: 412,
                startValidTime: '28 May 2025',
                endValidTime: '10 Jun 2025',
              ),
              SizedBox(height: 7.5.h),
              VendorDealCard(
                image: 'assets/images/MyDeals/StarBucks.png',
                title: '50% Off Any Grande Beverage',
                views: 1245,
                redemptions: 412,
                startValidTime: '28 May 2025',
                endValidTime: '10 Jun 2025',
              ),
              SizedBox(height: 7.5.h),
              VendorDealCard(
                image: 'assets/images/MyDeals/StarBucks.png',
                title: '50% Off Any Grande Beverage',
                views: 1245,
                redemptions: 412,
                startValidTime: '28 May 2025',
                endValidTime: '10 Jun 2025',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
