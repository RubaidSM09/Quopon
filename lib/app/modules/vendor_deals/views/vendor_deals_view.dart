import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';  // Import ScreenUtil
import 'package:quopon/app/modules/Search/views/search_view.dart';
import 'package:quopon/app/modules/vendor_dashboard/views/vendor_dashboard_view.dart';

import '../../../../common/my_deals_card.dart';
import '../../vendor_create_deal/views/vendor_create_deal_view.dart';
import '../../vendor_menu/views/vendor_menu_view.dart';
import '../controllers/vendor_deals_controller.dart';

class VendorDealsView extends GetView<VendorDealsController> {
  const VendorDealsView({super.key});

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 1;

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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Active Deals',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: Color(0xFF020711)),  // Use ScreenUtil for font size
                      ),
                      Text(
                        'Manage your currently active deals.',
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Color(0xFF6F7E8D)),  // Use ScreenUtil for font size
                      ),
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

              SizedBox(height: 20.h),

              // Search bar
              GestureDetector(
                onTap: () {
                  Get.to(SearchView());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0),  // Use ScreenUtil for padding
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),  // Use ScreenUtil for radius
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          readOnly: true, // Prevent actual editing and avoid focus issues
                          decoration: InputDecoration(
                            hintText: 'Search food, store, deals...',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Image.asset('assets/images/Home/Search.png'),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 15.h),

              // Vendor Deal Cards
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
