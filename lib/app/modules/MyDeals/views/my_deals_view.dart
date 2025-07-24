import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/MyDealsDetails/views/my_deals_details_view.dart';
import 'package:quopon/common/my_deals_card.dart';

import '../../Profile/views/profile_view.dart';
import '../../QRScanner/views/q_r_scanner_view.dart';
import '../../deals/views/deals_view.dart';
import '../../home/views/home_view.dart';
import '../../MyDeals/controllers/my_deals_controller.dart';

class MyDealsView extends StatefulWidget {
  const MyDealsView({super.key});

  @override
  _MyDealsViewState createState() => _MyDealsViewState();
}

class _MyDealsViewState extends State<MyDealsView> {
  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 398,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('My Deals', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                      Text('Quick access to your claimed deals.', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12)),
                    ],
                  ),
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
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFF1F3F4),
              ),
              width: 398,
              height: 48,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 40,
                      width: 127.33,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xFFD62828),
                      ),
                      child: const Center(
                        child: Text('Active', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white)),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 127.33,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xFFF1F3F4),
                      ),
                      child: const Center(
                        child: Text('Used', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D))),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 40,
                        width: 127.33,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFFF1F3F4),
                        ),
                        child: const Center(
                          child: Text('Expired', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Total Deals: 23',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
            ),
            // const SizedBox(height: 10),

            /// ✅ Scrollable section starts here
            Expanded(
              child: ListView.builder(
                itemCount: 23,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyDealsDetailsView()),
                      );
                    },
                      child: const MyDealsCard()
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
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

            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DealsView()),
              );
            }

            if (index == 4) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileView()),
              );
            }

            // Add more conditions if needed for other indexes
          }},
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/BottomNavigation/Home.png'),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/BottomNavigation/Deals.png'),
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
            icon: Image.asset('assets/images/BottomNavigation/My Deals Active.png'),
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
}
