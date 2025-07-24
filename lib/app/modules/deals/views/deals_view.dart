import 'dart:ui';
import 'package:flutter/material.dart';
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
          child: /*Container(
            height: 20,
            width: 20,
            color: Colors.white,
          )*/
          DealDetailView(
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
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search bar
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
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
                      SizedBox(height: 20),

                      // Filter options
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildFilterChip('Food & Drink'),
                            SizedBox(width: 8),
                            _buildFilterChip('Shopping'),
                            SizedBox(width: 8),
                            _buildFilterChip('Leisure activities'),
                            SizedBox(width: 8),
                            _buildFilterChip('Under 30 mins'),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      // Banner
                      Center(
                        child: Container(
                          width: 398,
                          height: 170,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.asset('assets/images/deals/Banner.png'),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Offers Near You section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Offers Near You',
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

                      // Shop icons
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,  // Number of items per row
                          mainAxisSpacing: 0,  // Space between rows
                          crossAxisSpacing: 0,  // Space between columns
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
                            case 1:
                              return GestureDetector(
                                onTap: () {
                                  _showDealDetails(
                                    context,
                                    'assets/images/Home/Restaurants/Image.png',
                                    'Unlock with Quopon+',
                                    'Get full access to exclusive deals, early releases, and premium perks.',
                                    '11:59 PM, May 31',
                                    'Qoupon+',
                                    'assets/images/deals/details/Starbucks_Logo.png'
                                  );
                                },
                                child: RestaurantCardBlur(
                                  restaurantImg: 'assets/images/Home/Restaurants/Image.png',
                                  restaurantName: 'Sonic',
                                  deliveryFee: 'US\$0 Delivery Free',
                                  distance: '16 mi',
                                  rating: '4.5',
                                  reviewCount: '12',
                                  deliveryTime: '45 min',
                                ),
                              );
                            case 2:
                              return GestureDetector(
                                onTap: () {
                                  _showDealDetails(
                                      context,
                                      'assets/images/Home/Restaurants/Image.png',
                                      'Unlock with Quopon+',
                                      'Get full access to exclusive deals, early releases, and premium perks.',
                                      '11:59 PM, May 31',
                                      'Qoupon+',
                                      'assets/images/deals/details/Starbucks_Logo.png'
                                  );
                                },
                                child: RestaurantCardBlur(
                                  restaurantImg: 'assets/images/Home/Restaurants/Image.png',
                                  restaurantName: 'Sonic',
                                  deliveryFee: 'US\$0 Delivery Free',
                                  distance: '16 mi',
                                  rating: '4.5',
                                  reviewCount: '12',
                                  deliveryTime: '45 min',
                                ),
                              );
                            case 3:
                              return GestureDetector(
                                onTap: () {
                                  _showDealDetails(
                                      context,
                                      'assets/images/deals/Fashion.jpg',
                                      '\$10 OFF Discount',
                                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                                      '11:59 PM, May 31',
                                      'Fashion Store Chic',
                                      'assets/images/deals/details/Starbucks_Logo.png'
                                  );
                                },
                                child: RestaurantCard(
                                  discountTxt: '\$10 OFF Discount',
                                  restaurantImg: 'assets/images/deals/Fashion.jpg',
                                  restaurantName: 'Fashion Store Chic',
                                  deliveryFee: 'US\$0 Delivery Free',
                                  distance: '12 mi',
                                  rating: '4.2',
                                  reviewCount: '500+',
                                  deliveryTime: '10 min',
                                ),
                              );
                            case 4:
                              return GestureDetector(
                                onTap: () {
                                  _showDealDetails(
                                      context,
                                      'assets/images/deals/BigMac.jpg',
                                      '\$10 OFF Discount',
                                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                                      '11:59 PM, May 31',
                                      'Fashion Store Chic',
                                      'assets/images/deals/details/Starbucks_Logo.png'
                                  );
                                },
                                child: RestaurantCard(
                                  discountTxt: '\$10 OFF Discount',
                                  restaurantImg: 'assets/images/deals/BigMac.jpg',
                                  restaurantName: 'Fashion Store Chic',
                                  deliveryFee: 'US\$0 Delivery Free',
                                  distance: '12 mi',
                                  rating: '4.2',
                                  reviewCount: '500+',
                                  deliveryTime: '10 min',
                                ),
                              );
                            case 5:
                              return GestureDetector(
                                onTap: () {
                                  _showDealDetails(
                                      context,
                                      'assets/images/deals/BigMac.jpg',
                                      '\$10 OFF Discount',
                                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                                      '11:59 PM, May 31',
                                      'Fashion Store Chic',
                                      'assets/images/deals/details/Starbucks_Logo.png'
                                  );
                                },
                                child: RestaurantCard(
                                  discountTxt: '\$10 OFF Discount',
                                  restaurantImg: 'assets/images/deals/BigMac.jpg',
                                  restaurantName: 'Fashion Store Chic',
                                  deliveryFee: 'US\$0 Delivery Free',
                                  distance: '12 mi',
                                  rating: '4.2',
                                  reviewCount: '500+',
                                  deliveryTime: '10 min',
                                ),
                              );
                            case 6:
                              return GestureDetector(
                                onTap: () {
                                  _showDealDetails(
                                      context,
                                      'assets/images/Home/Restaurants/Image.png',
                                      'Unlock with Quopon+',
                                      'Get full access to exclusive deals, early releases, and premium perks.',
                                      '11:59 PM, May 31',
                                      'Qoupon+',
                                      'assets/images/deals/details/Starbucks_Logo.png'
                                  );
                                },
                                child: RestaurantCardBlur(
                                  restaurantImg: 'assets/images/deals/Fashion.jpg',
                                  restaurantName: 'Fashion Store Chic',
                                  deliveryFee: 'US\$0 Delivery Free',
                                  distance: '12 mi',
                                  rating: '4.2',
                                  reviewCount: '500+',
                                  deliveryTime: '10 min',
                                ),
                              );
                            case 7:
                              return GestureDetector(
                                onTap: () {
                                  _showDealDetails(
                                      context,
                                      'assets/images/deals/Fashion.jpg',
                                      '\$10 OFF Discount',
                                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                                      '11:59 PM, May 31',
                                      'Fashion Store Chic',
                                      'assets/images/deals/details/Starbucks_Logo.png'
                                  );
                                },
                                child: RestaurantCard(
                                  discountTxt: '\$10 OFF Discount',
                                  restaurantImg: 'assets/images/deals/Fashion.jpg',
                                  restaurantName: 'Fashion Store Chic',
                                  deliveryFee: 'US\$0 Delivery Free',
                                  distance: '12 mi',
                                  rating: '4.2',
                                  reviewCount: '500+',
                                  deliveryTime: '10 min',
                                ),
                              );
                            default:
                              return Container(); // Handle unexpected cases
                          }
                        },
                      ),
                      SizedBox(height: 20),
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
              padding: EdgeInsets.all(8),
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
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}


Widget _buildFilterChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ]
      )
    );
  }

  Widget _buildShopItem(String name, String time, String logo) {
    return Column(
      children: [
        Image.asset(logo, height: 60, width: 60),
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

Widget _buildRestaurantCard({
  required String image,
  required String name,
  required String discount,
  required String rating,
  required String reviewCount,
  required String deliveryFee,
  required String distance,
  required String deliveryTime,
}) {
  return Container(
    width: 195,
    height: 206,
    // margin: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Coffee image with red promo badge and heart icon
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 120,
                  width: 179,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            // Red promo badge if any
            discount.isEmpty
                ? Container()
                : Positioned(
              top: 16,
              left: 12,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5.5),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  discount,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            // Heart icon
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.25),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
        // Restaurant details
        Padding(
          padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Restaurant name
              Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4),
              // Delivery fee and distance
              Row(
                children: [
                  Text(
                    deliveryFee,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    distance,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              // Rating and delivery time
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                    size: 14,
                  ),
                  SizedBox(width: 4),
                  Text(
                    '$rating ($reviewCount)',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    deliveryTime,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildRestaurantCardBlur({
  required String image,
  required String name,
  required String discount,
  required String rating,
  required String reviewCount,
  required String deliveryFee,
  required String distance,
  required String deliveryTime,
}) {
  return Container(
    width: 220,
    margin: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Coffee image with red promo badge and heart icon
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    child: Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                // Heart icon
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.25),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
            // Restaurant details
            Padding(
              padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Restaurant name
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  // Delivery fee and distance
                  Row(
                    children: [
                      Text(
                        deliveryFee,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        distance,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  // Rating and delivery time
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 14,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '$rating ($reviewCount)',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        deliveryTime,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        // Blur overlay with Qoupon+ Exclusive design
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              width: 220.0,
              height: 215.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.8),
                    Colors.grey.shade100.withOpacity(0.9),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Qoupon+ Exclusive badge
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Qoupon+ Exclusive',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  // Diamond icon
                  Image.asset(
                    'assets/images/Home/Language.png',
                    height: 48,
                    width: 48,
                  ),
                  SizedBox(height: 8),
                  // Main title
                  Text(
                    'Unlock with Qoupon+',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  // Subtitle
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Get full access to exclusive deals,\nearly releases, and premium perks.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
