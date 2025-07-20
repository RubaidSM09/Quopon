import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quopon/common/VendorCard.dart';

class FollowVendorsView extends GetView {
  const FollowVendorsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF9FBFC),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                    Text(
                      "Follow Vendors",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    SizedBox(),
                  ],
                )
              ],
            ),

            SizedBox(height: 25,),

            // Search bar
            GestureDetector(
              onTap: () {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchView()),
                );*/
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

            Column(
              children: [
              VendorCard(
                brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
                dealStoreName: 'Starbucks',
                dealType: 'Food & Beverage',
                activeDeals: 3,
              ),
                VendorCard(
                  brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
                  dealStoreName: 'Starbucks',
                  dealType: 'Food & Beverage',
                  activeDeals: 3,
                ),
                VendorCard(
                  brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
                  dealStoreName: 'Starbucks',
                  dealType: 'Food & Beverage',
                  activeDeals: 3,
                ),
                VendorCard(
                  brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
                  dealStoreName: 'Starbucks',
                  dealType: 'Food & Beverage',
                  activeDeals: 3,
                ),
                VendorCard(
                  brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
                  dealStoreName: 'Starbucks',
                  dealType: 'Food & Beverage',
                  activeDeals: 3,
                ),
                VendorCard(
                  brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
                  dealStoreName: 'Starbucks',
                  dealType: 'Food & Beverage',
                  activeDeals: 3,
                ),
                VendorCard(
                  brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
                  dealStoreName: 'Starbucks',
                  dealType: 'Food & Beverage',
                  activeDeals: 3,
                ),
                VendorCard(
                  brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
                  dealStoreName: 'Starbucks',
                  dealType: 'Food & Beverage',
                  activeDeals: 3,
                ),
                VendorCard(
                  brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
                  dealStoreName: 'Starbucks',
                  dealType: 'Food & Beverage',
                  activeDeals: 3,
                ),
                VendorCard(
                  brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
                  dealStoreName: 'Starbucks',
                  dealType: 'Food & Beverage',
                  activeDeals: 3,
                ),
                VendorCard(
                  brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
                  dealStoreName: 'Starbucks',
                  dealType: 'Food & Beverage',
                  activeDeals: 3,
                ),
                VendorCard(
                  brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
                  dealStoreName: 'Starbucks',
                  dealType: 'Food & Beverage',
                  activeDeals: 3,
                ),
                VendorCard(
                  brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
                  dealStoreName: 'Starbucks',
                  dealType: 'Food & Beverage',
                  activeDeals: 3,
                ),
                VendorCard(
                  brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
                  dealStoreName: 'Starbucks',
                  dealType: 'Food & Beverage',
                  activeDeals: 3,
                ),
                VendorCard(
                  brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
                  dealStoreName: 'Starbucks',
                  dealType: 'Food & Beverage',
                  activeDeals: 3,
                ),
                VendorCard(
                  brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
                  dealStoreName: 'Starbucks',
                  dealType: 'Food & Beverage',
                  activeDeals: 3,
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}
