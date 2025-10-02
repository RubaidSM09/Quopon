import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';  // Import ScreenUtil
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:quopon/app/modules/MyDeals/views/my_deals_view.dart';
import 'package:quopon/app/modules/Notifications/views/notifications_view.dart';
import 'package:quopon/app/modules/Profile/views/profile_view.dart';
import 'package:quopon/app/modules/QRScanner/views/q_r_scanner_view.dart';
import 'package:quopon/app/modules/QuoponPlus/views/quopon_plus_view.dart';
import 'package:quopon/app/modules/Search/views/search_view.dart';
import 'package:quopon/app/modules/VendorProfile/views/vendor_profile_view.dart';
import 'package:quopon/app/modules/dealDetail/views/deal_detail_view.dart';
import 'package:quopon/app/modules/home/controllers/home_controller.dart';
import 'package:quopon/common/Filter.dart';
import 'package:quopon/common/restaurant_card.dart';

import '../../../data/model/vendor_category.dart';
import '../../Cart/views/cart_view.dart';
import '../../deals/views/deals_view.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Background image (scrolls with content)
            Image.asset(
              'assets/images/Home/Rectangle 2074.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 234.h, // Use ScreenUtil for height
            ),

            // Main content with padding
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 60.h, bottom: 16.w),  // Use ScreenUtil for padding
              child: Column(
                children: [
                  SizedBox(
                    height: 200.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
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
                                    color: Color(0xFF6F7E8D),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/Home/Location.png',
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      'Elizabeth City',
                                      style: TextStyle(
                                        fontSize: 16.sp,  // Use ScreenUtil for font size
                                        color: Color(0xFF020711),
                                        fontWeight: FontWeight.w500,
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

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Hungry? ',
                                    style: TextStyle(
                                      fontSize: 22.sp,  // Use ScreenUtil for font size
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'See What\'s Cooking\nNear You',
                                    style: TextStyle(
                                      fontSize: 22.sp,  // Use ScreenUtil for font size
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox.shrink(),
                          ],
                        ),

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
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),  // Use ScreenUtil for height spacing

                  // Food categories
                  Column(
                    children: [
                      Obx(() {
                        // Check if categories are loaded
                        if (controller.vendorCategories.isEmpty) {
                          return Center(
                            child: CircularProgressIndicator(),  // Show loading spinner if categories are not fetched yet
                          );
                        } else {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: controller.vendorCategories.map((category) {
                                return _buildCategoryItem(category); // Use category object here
                              }).toList(),
                            ),
                          );
                        }
                      }),

                      SizedBox(height: 20,),

                      // Filter options
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            FilterCard(filterName: 'Pick-up', isSortable: false, filterIcon: 'assets/images/Home/Filters/Pick Up.svg',),
                            SizedBox(width: 8.w),
                            FilterCard(filterName: 'Offers', isSortable: false, filterIcon: 'assets/images/Home/Filters/Offers.svg',),
                            SizedBox(width: 8.w),
                            GestureDetector(
                              onTap: () {
                                controller.deliveryHighToLow.value = !controller.deliveryHighToLow.value;
                              },
                              child: FilterCard(filterName: 'Delivery Fee', filterIcon: 'assets/images/Home/Filters/Delivery Fee.svg',),
                            ),
                            SizedBox(width: 8.w),
                            FilterCard(filterName: 'Under 30 min', isSortable: false, filterIcon: 'assets/images/Home/Filters/Under 30 Min.svg',),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // Beyond Your Neighbourhood section
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Beyond Your Neighbourhood',
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

                          Obx(() {
                            // Check if categories are loaded
                            if (controller.beyondNeighbourhood.isEmpty) {
                              return Center(
                                child: CircularProgressIndicator(),  // Show loading spinner if categories are not fetched yet
                              );
                            } else {
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: controller.beyondNeighbourhood.map((beyondNeighbourhood) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                                      child: GestureDetector(
                                        onTap: () {
                                          !beyondNeighbourhood.isPremium ? Get.dialog(
                                              DealDetailView(
                                                dealId: beyondNeighbourhood.id,
                                                dealImage: beyondNeighbourhood.coverImageUrl!,
                                                dealTitle: beyondNeighbourhood.offers,
                                                dealDescription: beyondNeighbourhood.description,
                                                dealValidity: DateFormat('hh:mm a, MMM dd').format(DateTime.parse(beyondNeighbourhood.dealValidity)),
                                                dealStoreName: beyondNeighbourhood.name,
                                                brandLogo: beyondNeighbourhood.logoUrl!,
                                                redemptionType: beyondNeighbourhood.redemptionType,
                                                deliveryCost: beyondNeighbourhood.deliveryFee,
                                                minOrder: beyondNeighbourhood.minOrder,
                                              )
                                          ) : 
                                          Get.bottomSheet(QuoponPlusView());
                                        },
                                        child: HomeRestaurantCard(
                                          discountText: '',
                                          restaurantImg: beyondNeighbourhood.coverImageUrl!,
                                          restaurantName: beyondNeighbourhood.name,
                                          deliveryFee: beyondNeighbourhood.deliveryFee.toString(),
                                          distance: beyondNeighbourhood.distanceMiles,
                                          rating: beyondNeighbourhood.rating.toString(),
                                          reviewCount: beyondNeighbourhood.rating.toString(),
                                          deliveryTime: beyondNeighbourhood.deliveryTimeMinutes.toString(),
                                          isPremium: beyondNeighbourhood.isPremium,
                                        ),
                                      ),
                                    ); // Use category object here
                                  }).toList(),
                                ),
                              );
                            }
                          }),
                        ],
                      ),

                      SizedBox(height: 20.h),

                      // Shops Near You section
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Shops Near You',
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

                          Obx(() {
                            // Check if categories are loaded
                            if (controller.nearShops.isEmpty) {
                              return Center(
                                child: CircularProgressIndicator(),  // Show loading spinner if categories are not fetched yet
                              );
                            } else {
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: controller.nearShops.map((nearShops) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                                      child: GestureDetector(
                                        onTap: () {
                                          const placeholderLogo = 'https://via.placeholder.com/200x200.png?text=Logo';

                                          String categoryLabel(int? id) {
                                            switch (id) {
                                              case 1:
                                                return 'Restaurant';
                                              case 2:
                                                return 'Grocery';
                                              default:
                                                return 'Other';
                                            }
                                          }

                                          final safeLogo = (nearShops.logoImage != null &&
                                              nearShops.logoImage!.trim().isNotEmpty)
                                              ? nearShops.logoImage!
                                              : placeholderLogo;

                                          final safeType = categoryLabel(nearShops.category);

                                          print(nearShops.vendorId);

                                          Get.to(
                                            VendorProfileView(
                                              vendorId: nearShops.vendorId,
                                              logo: safeLogo,                 // <- never null
                                              name: nearShops.name,           // assuming non-null in model
                                              type: safeType,                 // readable label, never "null"
                                              address: nearShops.address,
                                            ),
                                          );
                                        },
                                        child: _buildShopItem(
                                          nearShops.name,
                                          controller.vendorStatus[nearShops.vendorId] ?? '—', // <-- status here
                                          nearShops.logoImage,
                                        ),
                                      ),
                                    ); // Use category object here
                                  }).toList(),
                                ),
                              );
                            }
                          }),
                        ],
                      ),

                      SizedBox(height: 20.h),

                      // Speedy Deliveries section
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Speedy Deliveries',
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

                          // Restaurant and Coupon cards in a row
                          Obx(() {
                            // Check if categories are loaded
                            if (controller.speedyDeliveries.isEmpty) {
                              return Center(
                                child: CircularProgressIndicator(),  // Show loading spinner if categories are not fetched yet
                              );
                            } else {
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: controller.speedyDeliveries.map((speedyDeliveries) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                                      child: GestureDetector(
                                        onTap: () {
                                          !speedyDeliveries.isPremium ? Get.dialog(
                                              DealDetailView(
                                                dealId: speedyDeliveries.id,
                                                dealImage: speedyDeliveries.coverImageUrl!,
                                                dealTitle: speedyDeliveries.offers,
                                                dealDescription: speedyDeliveries.description,
                                                dealValidity: DateFormat('hh:mm a, MMM dd').format(DateTime.parse(speedyDeliveries.dealValidity)),
                                                dealStoreName: speedyDeliveries.name,
                                                brandLogo: speedyDeliveries.logoUrl!,
                                                redemptionType: speedyDeliveries.redemptionType,
                                                deliveryCost: speedyDeliveries.deliveryFee,
                                                minOrder: speedyDeliveries.minOrder,
                                              )
                                          ) : Get.bottomSheet(QuoponPlusView());
                                        },
                                        child: HomeRestaurantCard(
                                          discountText: '',
                                          restaurantImg: speedyDeliveries.coverImageUrl!,
                                          restaurantName: speedyDeliveries.name,
                                          deliveryFee: speedyDeliveries.deliveryFee,
                                          distance: speedyDeliveries.distanceMiles,
                                          rating: speedyDeliveries.rating,
                                          reviewCount: speedyDeliveries.rating,
                                          deliveryTime: speedyDeliveries.deliveryTimeMinutes.toString(),
                                          isPremium: speedyDeliveries.isPremium,
                                        ),
                                      ),
                                    ); // Use category object here
                                  }).toList(),
                                ),
                              );
                            }
                          }),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(VendorCategory category) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
      child: Column(
        children: [
          // Display category image
          Image.network(
            category.imageUrl,
            height: 60.h,
            width: 60.w,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 6.h),  // Use ScreenUtil for height spacing
          Text(
            category.categoryTitle,
            style: TextStyle(
              fontSize: 12.sp,  // Use ScreenUtil for font size
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),  // Use ScreenUtil for padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),  // Use ScreenUtil for radius
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(15))],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.w, color: Colors.grey[600]),  // Use ScreenUtil for icon size
          SizedBox(width: 6.w),  // Use ScreenUtil for width spacing
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,  // Use ScreenUtil for font size
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShopItem(String name, String time, String? logo) {
    final hasLogo = (logo != null && logo.isNotEmpty);
    return Column(
      children: [
        CircleAvatar(
          radius: 30.w,
          backgroundImage: hasLogo ? NetworkImage(logo!) : null,
          child: hasLogo ? null : const Icon(Icons.store), // fallback icon
        ),
        SizedBox(height: 6.h),
        SizedBox(
          width: 66.w,
          child: Center(
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        Text(
          time,
          style: TextStyle(
            fontSize: 10.sp,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
