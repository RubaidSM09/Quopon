import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/vendor_create_deal/views/vendor_create_deal_view.dart';
import 'package:quopon/app/modules/vendor_dashboard/views/dashboard_view.dart';
import 'package:quopon/app/modules/vendor_deals/views/vendor_deals_view.dart';
import 'package:quopon/common/deal_card.dart';
import 'package:quopon/common/my_deals_card.dart';

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
          padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('assets/images/Vendor/Dashboard/Starbucks.png'),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, Good Evening!',
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Color(0xFF020711)),
                          ),
                          Text(
                            'Starbucks',
                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xFF6F7E8D)),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16)]
                    ),
                    child: Image.asset('assets/images/Home/Notification.png'),
                  )
                ],
              ),

              SizedBox(height: 15,),

              Row(
                children: [
                  Text(
                    'Dashboard',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Color(0xFF020711)),
                  ),
                  SizedBox.shrink()
                ],
              ),

              SizedBox(height: 5,),

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
                      SizedBox(height: 10,),
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
                      SizedBox(height: 10,),
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

              SizedBox(height: 20,),

              Row(
                children: [
                  Text(
                    'Push History',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Color(0xFF020711)),
                  ),
                  SizedBox.shrink(),
                ],
              ),

              SizedBox(height: 5,),

              VendorDealCard(
                image: 'assets/images/MyDeals/StarBucks.png',
                title: '50% Off Any Grande Beverage',
                views: 1245,
                redemptions: 412,
                startValidTime: '28 May 2025',
                endValidTime: '10 Jun 2025',
              ),
              SizedBox(height: 7.5,),
              VendorDealCard(
                image: 'assets/images/MyDeals/StarBucks.png',
                title: '50% Off Any Grande Beverage',
                views: 1245,
                redemptions: 412,
                startValidTime: '28 May 2025',
                endValidTime: '10 Jun 2025',
              ),
              SizedBox(height: 7.5,),
              VendorDealCard(
                image: 'assets/images/MyDeals/StarBucks.png',
                title: '50% Off Any Grande Beverage',
                views: 1245,
                redemptions: 412,
                startValidTime: '28 May 2025',
                endValidTime: '10 Jun 2025',
              ),
              SizedBox(height: 7.5,),
              VendorDealCard(
                image: 'assets/images/MyDeals/StarBucks.png',
                title: '50% Off Any Grande Beverage',
                views: 1245,
                redemptions: 412,
                startValidTime: '28 May 2025',
                endValidTime: '10 Jun 2025',
              ),
              SizedBox(height: 7.5,),
              VendorDealCard(
                image: 'assets/images/MyDeals/StarBucks.png',
                title: '50% Off Any Grande Beverage',
                views: 1245,
                redemptions: 412,
                startValidTime: '28 May 2025',
                endValidTime: '10 Jun 2025',
              ),
              SizedBox(height: 7.5,),
              VendorDealCard(
                image: 'assets/images/MyDeals/StarBucks.png',
                title: '50% Off Any Grande Beverage',
                views: 1245,
                redemptions: 412,
                startValidTime: '28 May 2025',
                endValidTime: '10 Jun 2025',
              ),
              SizedBox(height: 7.5,),
              VendorDealCard(
                image: 'assets/images/MyDeals/StarBucks.png',
                title: '50% Off Any Grande Beverage',
                views: 1245,
                redemptions: 412,
                startValidTime: '28 May 2025',
                endValidTime: '10 Jun 2025',
              ),
              SizedBox(height: 7.5,),
              VendorDealCard(
                image: 'assets/images/MyDeals/StarBucks.png',
                title: '50% Off Any Grande Beverage',
                views: 1245,
                redemptions: 412,
                startValidTime: '28 May 2025',
                endValidTime: '10 Jun 2025',
              ),
              SizedBox(height: 7.5,),
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

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFFFFFFF),
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 2) {
            Get.to(VendorCreateDealView());
          }

          if (index == 1) {
            Get.to(VendorDealsView());
          }

          if (index == 3) {

          }
          if (index == 4) {

          }
        },
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/BottomNavigation/Dashboard Active.png'),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/BottomNavigation/Deals.png'),
            label: 'Deals',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/BottomNavigation/Create Deal.png'),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/BottomNavigation/Menu.png'),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/BottomNavigation/Profile.png'),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
