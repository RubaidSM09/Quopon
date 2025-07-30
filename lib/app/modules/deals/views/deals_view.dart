import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';  // Import ScreenUtil
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quopon/app/modules/dealDetail/views/deal_detail_view.dart';
import 'package:quopon/common/Filter.dart';
import 'package:quopon/common/deal_card.dart';
import 'package:quopon/common/restaurant_card.dart';

import '../../Cart/views/cart_view.dart';
import '../../MyDeals/views/my_deals_view.dart';
import '../../Notifications/views/notifications_view.dart';
import '../../Profile/views/profile_view.dart';
import '../../QRScanner/views/q_r_scanner_view.dart';
import '../../Search/views/search_view.dart';
import '../../home/views/home_view.dart';

class DealsView extends StatefulWidget {
  const DealsView({super.key});

  @override
  _DealsViewState createState() => _DealsViewState();
}

class _DealsViewState extends State<DealsView> {
  int _selectedIndex = 1;

  // A helper method to show the deal details in a popup
  void _showDealDetails(BuildContext context, String dealImage, String dealTitle, String dealDescription, String dealValidity, String dealStoreName, String brandLogo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: DealDetailView(
            dealImage: dealImage,
            dealTitle: dealTitle,
            dealDescription: dealDescription,
            dealValidity: dealValidity,
            dealStoreName: dealStoreName,
            brandLogo: brandLogo,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 44.w, bottom: 16.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Deliver to',
                            style: TextStyle(color: Color(0xFF6F7E8D), fontSize: 12.sp, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(width: 4.w,),
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 14.r,
                            color: Color(0xFF6F7E8D),
                          )
                        ],
                      ),
                      SizedBox(height: 6.h,),
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/Home/Location.png',
                            height: 16.h,
                            width: 16.w,
                          ),
                          SizedBox(width: 8.w,),
                          Text(
                            'Elizabeth City',
                            style: TextStyle(color: Color(0xFF020711), fontSize: 16.sp, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(NotificationsView());
                        },
                        child: Image.asset(
                          'assets/images/Home/Notification.png',
                          height: 24.h,
                          width: 24.w,
                        ),
                      ),
                      SizedBox(width: 16.w,),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => CartView());
                        },
                        child: Image.asset(
                          'assets/images/Home/Cart.png',
                          height: 24.h,
                          width: 24.w,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 20.h,),

              // Search bar
              GestureDetector(
                onTap: () {
                  Get.to(SearchView());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),  // Use ScreenUtil for padding
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),  // Use ScreenUtil for border radius
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

              SizedBox(height: 20.h,),
              
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterCard(filterName: 'Food & Drink', isSortable: false,),
                    SizedBox(width: 8.w,),
                    FilterCard(filterName: 'Shopping', isSortable: false,),
                    SizedBox(width: 8.w,),
                    FilterCard(filterName: 'Leisure activities', isSortable: false,),
                    SizedBox(width: 8.w,),
                    FilterCard(filterName: 'Under 30 mins', isSortable: false,),
                  ],
                ),
              ),

              SizedBox(height: 20.h,),

              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.asset(
                      'assets/images/Home/Rectangle 2074.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 170.h, // Use ScreenUtil for height
                    ),
                  ),
                  Positioned(
                    left: 192.w,
                    child: Image.asset(
                      'assets/images/deals/FastFood.png',
                      width: 205.78945922851562.w,
                      height: 170.h,
                    ),
                  ),
                  Positioned(
                    top: 31.h,
                    left: 16.w,
                    child: SizedBox(
                      height: 108.h,
                      width: 202.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Get 25% OFF Your First Order',
                            style: TextStyle(color: Color(0xFF020711), fontSize: 24.sp, fontWeight: FontWeight.w600),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Color(0xFFD62828)
                            ),
                            child: Text(
                              'ORDER NOW',
                              style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),

              SizedBox(height: 20.h,),

              SizedBox(
                width: double.infinity,
                child: Text(
                  'Offers Near You',
                  style: TextStyle(color: Color(0xFF020711), fontSize: 18.sp, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 12.h,),
              GestureDetector(
                onTap: () {
                  _showDealDetails(
                      context,
                      'assets/images/deals/Pizza.jpg',
                      '20% Discount',
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                      '11:59 PM, May 31',
                      'Pizzeria Bella Italia',
                      'assets/images/deals/details/Starbucks_Logo.png'
                  );
                  },
                child: RestaurantCard(
                  discountTxt: '20% Discount',
                  restaurantImg: 'assets/images/deals/Pizza.jpg',
                  restaurantName: 'Pizzeria Bella Italia',
                  deliveryFee: 'US\$0 Delivery Free',
                  distance: '12 mi',
                  rating: '4.2',
                  reviewCount: '500+',
                  deliveryTime: '10 min',
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFFFFFFF),
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 2) {
            // Navigate to scanner screen without changing selected index
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const QRScannerView()),
            );
          } else {
            setState(() {
              _selectedIndex = index;
            });

            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeView()),
              );
            }

            if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyDealsView()),
              );
            }

            if (index == 4) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileView()),
              );
            }

            // Add more conditions if needed for other indexes
          }
        },
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/BottomNavigation/Home.png'),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/BottomNavigation/Deals Active.png'),
            label: 'Deals',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(8.h),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Image.asset('assets/images/BottomNavigation/QR.png'),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/BottomNavigation/My Deals.png'),
            label: 'My Deals',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/BottomNavigation/Profile.png'),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),  // Use ScreenUtil for padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),  // Use ScreenUtil for radius
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,  // Use ScreenUtil for font size
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
