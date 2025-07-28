import 'package:flutter/material.dart';

import 'package:get/get.dart';
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
          padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
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
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Color(0xFF020711)),
                      ),
                      Text(
                        'Manage your currently active deals.',
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xFF6F7E8D)),
                      ),
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

              SizedBox(height: 20,),

              // Search bar
              GestureDetector(
                onTap: () {
                  Get.to(SearchView());
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
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
                          readOnly: true, // <<— prevent actual editing and avoid focus issues
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

              SizedBox(height: 15,),

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

          if (index == 0) {
            Get.to(VendorDashboardView());
          }

          if (index == 3) {
            Get.to(VendorMenuView());
          }
          if (index == 4) {

          }
        },
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/BottomNavigation/Dashboard.png'),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/BottomNavigation/Deals Active.png'),
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
