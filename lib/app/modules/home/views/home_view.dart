import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quopon/app/modules/MyDeals/views/my_deals_view.dart';
import 'package:quopon/app/modules/Notifications/views/notifications_view.dart';
import 'package:quopon/app/modules/Profile/views/profile_view.dart';
import 'package:quopon/app/modules/QRScanner/views/q_r_scanner_view.dart';
import 'package:quopon/app/modules/Search/views/search_view.dart';
import 'package:quopon/common/restaurant_card.dart';

import '../../Cart/views/cart_view.dart';
import '../../deals/views/deals_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x00F5F5F5),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              color: Colors.white,
              height: 1225,
            ),
            // Background image (scrolls with content)
            Column(
              children: [
                Image.asset(
                  'assets/images/Home/Rectangle 2074.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 220, // Adjust height as needed
                ),
                Container(
                  height: 500, // Extend the column height to match your content
                  color: Colors.transparent,
                ),
              ],
            ),

            // Main content with padding
            Column(
              children: [
                // ========== ✅ Transparent Custom AppBar (inside Stack) ==========
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Row(
                            children: [
                              Image.asset('assets/images/Home/Location.png', height: 16, width: 16, color: Colors.black),
                              SizedBox(width: 4),
                              Text(
                                'Elizabeth City',
                                style: TextStyle(
                                  fontSize: 14,
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
                            onPressed: () {
                              Get.to(NotificationsView());
                            },
                          ),
                          IconButton(
                            icon: Image.asset('assets/images/Home/Cart.png'),
                            onPressed: () {
                              Get.to(() => CartView());
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ========== ✅ Actual Content ==========
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hungry text
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Hungry? ',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            TextSpan(
                              text: 'See What\'s Cooking\nNear You',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),

                      // Search bar
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SearchView()),
                          );
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
                              Icon(Icons.search, color: Colors.grey[500]),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Food categories
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildCategoryItem('assets/images/Home/Breakfast.png', 'Breakfast', Colors.orange),
                            SizedBox(width: 16),
                            _buildCategoryItem('assets/images/Home/Coffee.png', 'Coffee', Colors.brown),
                            SizedBox(width: 16),
                            _buildCategoryItem('assets/images/Home/Grocery.png', 'Grocery', Colors.green),
                            SizedBox(width: 16),
                            _buildCategoryItem('assets/images/Home/Fast Food.png', 'Fast Food', Colors.red),
                            SizedBox(width: 16),
                            _buildCategoryItem('assets/images/Home/Wings.png', 'Wings', Colors.orange),
                            SizedBox(width: 16),
                            _buildCategoryItem('assets/images/Home/Pizza.png', 'Pizza', Colors.red),
                            SizedBox(width: 16),
                            _buildCategoryItem('assets/images/Home/Sweets.png', 'Sweets', Colors.red),
                            SizedBox(width: 16),
                            _buildCategoryItem('assets/images/Home/Chinese.png', 'Chinese', Colors.red),
                            SizedBox(width: 16),
                            _buildCategoryItem('assets/images/Home/BBQ.png', 'BBQ', Colors.red),
                            SizedBox(width: 16),
                            _buildCategoryItem('assets/images/Home/American.png', 'American', Colors.red),
                            SizedBox(width: 16),
                            _buildCategoryItem('assets/images/Home/Mexican.png', 'Mexican', Colors.red),
                            SizedBox(width: 16),
                            _buildCategoryItem('assets/images/Home/Sandwich.png', 'Sandwich', Colors.red),
                            SizedBox(width: 16),
                            _buildCategoryItem('assets/images/Home/Seafood.png', 'Seafood', Colors.red),
                            SizedBox(width: 16),
                            _buildCategoryItem('assets/images/Home/Bakery.png', 'Bakery', Colors.red),
                            SizedBox(width: 16),
                            _buildCategoryItem('assets/images/Home/Burger.png', 'Burger', Colors.red),
                            SizedBox(width: 16),
                            _buildCategoryItem('assets/images/Home/Smoothies.png', 'Smoothies', Colors.red),
                            SizedBox(width: 16),
                            _buildCategoryItem('assets/images/Home/Soup.png', 'Soup', Colors.red),
                            SizedBox(width: 16),
                            _buildCategoryItem('assets/images/Home/Desserts.png', 'Desserts', Colors.red),
                            SizedBox(width: 16),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      // Filter options
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildFilterChip(Icons.store, 'Pick-up'),
                            SizedBox(width: 8),
                            _buildFilterChip(Icons.local_offer, 'Offers'),
                            SizedBox(width: 8),
                            _buildFilterChip(Icons.delivery_dining, 'Delivery Fee'),
                            SizedBox(width: 8),
                            _buildFilterChip(Icons.access_time, 'Under 30 min'),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      // Beyond Your Neighbourhood section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Beyond Your Neighbourhood',
                            style: TextStyle(
                              fontSize: 18,
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
                      SizedBox(height: 12),

                      // Restaurant and Coupon cards in a row
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            // Sonic card
                            RestaurantCard(discountTxt: '', restaurantImg: 'assets/images/Home/Restaurants/Image.png', restaurantName: 'Domino\'s', deliveryFee: 'US\$0 Delivery Free', distance: '16 mi', rating: '4.0', reviewCount: '65', deliveryTime: '20 min',),

                            // Coupon section
                            RestaurantCardBlur(restaurantImg: 'assets/images/Home/Restaurants/Image.png', restaurantName: 'Sonic', deliveryFee: 'US\$0 Delivery Free', distance: '16 mi', rating: '4.5', reviewCount: '12', deliveryTime: '45 min',),

                            // Starbucks card
                            RestaurantCard(discountTxt: 'Spend \$15, Save \$3', restaurantImg: 'assets/images/Home/Restaurants/Starbucks.jpg', restaurantName: 'Starbucks', deliveryFee: 'US\$0 Delivery Free', distance: '16 mi', rating: '4.5', reviewCount: '27', deliveryTime: '15 min',),

                            // City Grille card
                            RestaurantCard(discountTxt: '', restaurantImg: 'assets/images/Home/Restaurants/City Grille.jpg', restaurantName: 'City Grille', deliveryFee: 'US\$2.19 Free', distance: '16 mi', rating: '4.5', reviewCount: '27', deliveryTime: '15 min',),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      // Shops Near You section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Shops Near You',
                            style: TextStyle(
                              fontSize: 18,
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
                      SizedBox(height: 12),

                      // Shop icons
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildShopItem('7-Eleven', '10 min', 'assets/images/Home/Shops/image.png'),
                            SizedBox(width: 15,),
                            _buildShopItem('Speedway', '15 min', 'assets/images/Home/Shops/image-1.png'),
                            SizedBox(width: 15,),
                            _buildShopItem('Lowe\'s', '20 min', 'assets/images/Home/Shops/image-2.png'),
                            SizedBox(width: 15,),
                            _buildShopItem('Wawa', '10 min', 'assets/images/Home/Shops/image-3.png'),
                            SizedBox(width: 15,),
                            _buildShopItem('Pet Supp...', 'Closed', 'assets/images/Home/Shops/image-4.png'),
                            SizedBox(width: 15,),
                            _buildShopItem('Petco', 'Closed', 'assets/images/Home/Shops/Petco.png'),
                            SizedBox(width: 15,),
                            _buildShopItem('GNC', '11:00 AM', 'assets/images/Home/Shops/GNC.png'),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      // Speedy Deliveries section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Speedy Deliveries',
                            style: TextStyle(
                              fontSize: 18,
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

                      SizedBox(height: 12),

                      // Restaurant and Coupon cards in a row
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            // Sonic card
                            RestaurantCard(discountTxt: '', restaurantImg: 'assets/images/Home/Restaurants/Image.png', restaurantName: 'Sonic', deliveryFee: 'US\$0 Delivery Free', distance: '16 mi', rating: '4.5', reviewCount: '12', deliveryTime: '45 min',),

                            // Coupon section
                            RestaurantCardBlur(restaurantImg: 'assets/images/Home/Restaurants/Image.png', restaurantName: 'Sonic', deliveryFee: 'US\$0 Delivery Free', distance: '16 mi', rating: '4.5', reviewCount: '12', deliveryTime: '45 min',),

                            // Starbucks card
                            RestaurantCard(discountTxt: 'Spend \$15, Save \$3', restaurantImg: 'assets/images/Home/Restaurants/Starbucks.jpg', restaurantName: 'Starbucks', deliveryFee: 'US\$0 Delivery Free', distance: '16 mi', rating: '4.5', reviewCount: '27', deliveryTime: '15 min',),

                            // City Grille card
                            RestaurantCard(discountTxt: '', restaurantImg: 'assets/images/Home/Restaurants/City Grille.jpg', restaurantName: 'City Grille', deliveryFee: 'US\$2.19 Free', distance: '16 mi', rating: '4.5', reviewCount: '27', deliveryTime: '15 min',),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFFFFFFF),
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

            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DealsView()),
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
            icon: Image.asset('assets/images/BottomNavigation/Home Active.png'),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/BottomNavigation/Deals.png'),
            label: 'Deals',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
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

  Widget _buildCategoryItem(String icon, String label, Color color) {
    return Column(
      children: [
        Image.asset(icon, height: 60, width: 60,),
        SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShopItem(String name, String time, String logo) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(logo),
        ),
        SizedBox(height: 6),
        Text(
          name,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          time,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}