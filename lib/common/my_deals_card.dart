import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quopon/app/modules/vendor_deal_performance/views/vendor_deal_performance_view.dart';
import 'package:quopon/app/modules/vendor_deals/views/deals_options_view.dart';

class MyDealsCard extends StatefulWidget {
  const MyDealsCard({super.key});

  @override
  State<MyDealsCard> createState() => _MyDealsCardState();
}

class _MyDealsCardState extends State<MyDealsCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h), // Use ScreenUtil for bottom padding
      child: Container(
        width: 398.w, // Use ScreenUtil for width
        height: 82.h, // Use ScreenUtil for height
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r), // Use ScreenUtil for radius
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(12.w), // Use ScreenUtil for padding
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                  'assets/images/MyDeals/StarBucks.png'
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '50% Off Any Grande Beverage',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp, // Use ScreenUtil for font size
                      color: Color(0xFF020711),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Valid: ',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp, // Use ScreenUtil for font size
                          color: Color(0xFFD62828),
                        ),
                      ),
                      Text(
                        '28 May 2025 - 10 Jun 2025',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp, // Use ScreenUtil for font size
                          color: Color(0xFF6F7E8D),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                height: 26.h, // Use ScreenUtil for height
                width: 58.w, // Use ScreenUtil for width
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r), // Use ScreenUtil for radius
                  color: Color(0xFFECFDF5),
                ),
                child: Center(
                  child: Text(
                    'Active',
                    style: TextStyle(color: Color(0xFF2ECC71), fontSize: 12.sp, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VendorDealCard extends GetView {
  final String image;
  final String title;
  final int views;
  final int redemptions;
  final String startValidTime;
  final String endValidTime;

  const VendorDealCard({
    required this.image,
    required this.title,
    required this.views,
    required this.redemptions,
    required this.startValidTime,
    required this.endValidTime,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(VendorDealPerformanceView());
      },
      child: Container(
        padding: EdgeInsets.only(right: 12.w, left: 8.w, top: 8.h, bottom: 8.h), // Use ScreenUtil for padding
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r), // Use ScreenUtil for radius
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(image),
                SizedBox(width: 10.w), // Use ScreenUtil for spacing
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp, // Use ScreenUtil for font size
                        color: Color(0xFF020711),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${NumberFormat.decimalPattern().format(views)} Views    ',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp, // Use ScreenUtil for font size
                            color: Color(0xFF6F7E8D),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFCAD9E8),
                          ),
                          height: 5.h, // Use ScreenUtil for height
                          width: 5.w, // Use ScreenUtil for width
                        ),
                        Text(
                          '   ${NumberFormat.decimalPattern().format(redemptions)} Redemptions',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp, // Use ScreenUtil for font size
                            color: Color(0xFF6F7E8D),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Valid: ',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp, // Use ScreenUtil for font size
                            color: Color(0xFFD62828),
                          ),
                        ),
                        Text(
                          '$startValidTime - $endValidTime',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp, // Use ScreenUtil for font size
                            color: Color(0xFF6F7E8D),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Get.bottomSheet(DealsOptionsView());
              },
              child: Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
    );
  }
}
