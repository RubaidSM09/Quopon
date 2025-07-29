import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';  // Import ScreenUtil
import 'package:quopon/app/modules/dealDetail/views/deal_detail_view.dart';
import 'package:quopon/common/restaurant_card.dart';

import '../../MyDeals/views/my_deals_view.dart';
import '../../Profile/views/profile_view.dart';
import '../../QRScanner/views/q_r_scanner_view.dart';
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
        child: Stack(
          children: [
            // Main content with padding
            Column(
              children: [
                // ========== ✅ Transparent Custom AppBar (inside Stack) ==========
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),  // Use ScreenUtil for padding
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left side
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Deliver to',
                            style: TextStyle(
                              fontSize: 12.sp,  // Use ScreenUtil for font size
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Row(
                            children: [
                              Image.asset('assets/images/Home/Location.png', height: 16.h, width: 16.w, color: Colors.black),
                              SizedBox(width: 4.w),
                              Text(
                                'Elizabeth City',
                                style: TextStyle(
                                  fontSize: 14.sp,  // Use ScreenUtil for font size
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Right side
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
                      ),
                    ],
                  ),
                ),

                // ========== ✅ Actual Content ==========
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 16.h),  // Use ScreenUtil for padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search bar
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),  // Use ScreenUtil for padding
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
                                decoration: InputDecoration(
                                  hintText: 'Search food, store, deals...',
                                  hintStyle: TextStyle(color: Colors.grey[500]),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Icon(Icons.search, color: Colors.grey[500]),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),  // Use ScreenUtil for height spacing

                      // Filter options
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildFilterChip('Food & Drink'),
                            SizedBox(width: 8.w),  // Use ScreenUtil for width spacing
                            _buildFilterChip('Shopping'),
                            SizedBox(width: 8.w),  // Use ScreenUtil for width spacing
                            _buildFilterChip('Leisure activities'),
                            SizedBox(width: 8.w),  // Use ScreenUtil for width spacing
                            _buildFilterChip('Under 30 mins'),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),  // Use ScreenUtil for height spacing

                      // Banner
                      Center(
                        child: Container(
                          width: 398.w,  // Use ScreenUtil for width
                          height: 170.h,  // Use ScreenUtil for height
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),  // Use ScreenUtil for radius
                          ),
                          child: Image.asset('assets/images/deals/Banner.png'),
                        ),
                      ),
                      SizedBox(height: 20.h),  // Use ScreenUtil for height spacing

                      // Offers Near You section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Offers Near You',
                            style: TextStyle(
                              fontSize: 18.sp,  // Use ScreenUtil for font size
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'See All',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Shop icons
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,  // Number of items per row
                          mainAxisSpacing: 0.h,  // Space between rows
                          crossAxisSpacing: 0.w,  // Space between columns
                          childAspectRatio: 0.825,  // Control card aspect ratio
                        ),
                        itemCount: 8,  // Number of items in the grid
                        shrinkWrap: true,  // Makes GridView take only the required height
                        physics: NeverScrollableScrollPhysics(),  // Prevent scrolling (since it's inside a SingleChildScrollView)
                        itemBuilder: (context, index) {
                          switch (index) {
                            case 0:
                              return GestureDetector(
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
                              );
                          // Add more cases as needed for other items
                            default:
                              return Container(); // Handle unexpected cases
                          }
                        },
                      ),
                      SizedBox(height: 20.h),  // Use ScreenUtil for height spacing
                    ],
                  ),
                ),
              ],
            ),
          ],
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
