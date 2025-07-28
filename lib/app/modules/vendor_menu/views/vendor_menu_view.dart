import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/VendorProfile/views/vendor_profile_view.dart';
import 'package:quopon/app/modules/vendor_add_menu/views/vendor_add_menu_view.dart';
import 'package:quopon/app/modules/vendor_deals/views/vendor_deals_view.dart';
import 'package:quopon/app/modules/vendor_menu/views/menu_card_view.dart';
import 'package:quopon/app/modules/vendor_side_profile/views/vendor_side_profile_view.dart';

import '../../Search/views/search_view.dart';
import '../../vendor_create_deal/views/vendor_create_deal_view.dart';
import '../../vendor_dashboard/views/vendor_dashboard_view.dart';
import '../controllers/vendor_menu_controller.dart';

class VendorMenuView extends GetView<VendorMenuController> {
  const VendorMenuView({super.key});
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 3;

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
                        'Manage Your Menu',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Color(0xFF020711)),
                      ),
                      Text(
                        'Keep your menu updated and organized for your customers.',
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 11, color: Color(0xFF6F7E8D)),
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
                    child: GestureDetector(
                      onTap: () {
                        Get.to(VendorAddMenuView());
                      },
                      child: Icon(Icons.add),
                    ),
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
                            hintText: 'Search food...',
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

              Row(
                children: [
                  Text(
                    'Breakfast',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color(0xFF020711),
                    ),
                  ),
                  SizedBox.shrink(),
                ],
              ),
              SizedBox(height: 15,),
              MenuCardView(
                image: 'assets/images/Menu/Custom Chicken Steak Hoagie.png',
                title: 'Custom Chicken Steak Hoagie',
                description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                price: 5.29,
              ),
              SizedBox(height: 7.5,),
              MenuCardView(
                image: 'assets/images/Menu/Custom Chicken Steak Hoagie.png',
                title: 'Custom Chicken Steak Hoagie',
                description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                price: 5.29,
              ),
              SizedBox(height: 7.5,),
              MenuCardView(
                image: 'assets/images/Menu/Custom Chicken Steak Hoagie.png',
                title: 'Custom Chicken Steak Hoagie',
                description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                price: 5.29,
              ),

              SizedBox(height: 15,),

              Row(
                children: [
                  Text(
                    'Lunch',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color(0xFF020711),
                    ),
                  ),
                  SizedBox.shrink(),
                ],
              ),
              SizedBox(height: 15,),
              MenuCardView(
                image: 'assets/images/Menu/Custom Chicken Steak Hoagie.png',
                title: 'Custom Chicken Steak Hoagie',
                description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                price: 5.29,
              ),
              SizedBox(height: 7.5,),
              MenuCardView(
                image: 'assets/images/Menu/Custom Chicken Steak Hoagie.png',
                title: 'Custom Chicken Steak Hoagie',
                description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                price: 5.29,
              ),
              SizedBox(height: 7.5,),
              MenuCardView(
                image: 'assets/images/Menu/Custom Chicken Steak Hoagie.png',
                title: 'Custom Chicken Steak Hoagie',
                description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                price: 5.29,
              ),

              SizedBox(height: 15,),

              Row(
                children: [
                  Text(
                    'Dinner',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color(0xFF020711),
                    ),
                  ),
                  SizedBox.shrink(),
                ],
              ),
              SizedBox(height: 15,),
              MenuCardView(
                image: 'assets/images/Menu/Custom Chicken Steak Hoagie.png',
                title: 'Custom Chicken Steak Hoagie',
                description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                price: 5.29,
              ),
              SizedBox(height: 7.5,),
              MenuCardView(
                image: 'assets/images/Menu/Custom Chicken Steak Hoagie.png',
                title: 'Custom Chicken Steak Hoagie',
                description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                price: 5.29,
              ),
              SizedBox(height: 7.5,),
              MenuCardView(
                image: 'assets/images/Menu/Custom Chicken Steak Hoagie.png',
                title: 'Custom Chicken Steak Hoagie',
                description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                price: 5.29,
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

          if (index == 1) {
            Get.to(VendorDealsView());
          }
          if (index == 4) {
            Get.to(VendorSideProfileView());
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
            icon: Image.asset('assets/images/BottomNavigation/Deals.png'),
            label: 'Deals',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/BottomNavigation/Create Deal.png'),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/BottomNavigation/Menu Active.png'),
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
