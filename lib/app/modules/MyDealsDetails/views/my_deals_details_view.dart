import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quopon/common/deal_card.dart';
import 'package:quopon/common/my_deals_card.dart';

class MyDealsDetailsView extends StatefulWidget {
  const MyDealsDetailsView({super.key});

  @override
  State<MyDealsDetailsView> createState() => _MyDealsDetailsViewState();
}

class _MyDealsDetailsViewState extends State<MyDealsDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      appBar: AppBar(
        backgroundColor: Color(0xFFF9FBFC),
        title: Center(child: Text('Deal Details', style: TextStyle(fontSize: 20.sp))),
        actions: [Icon(Icons.favorite_rounded, color: Color(0xFFD62828),), SizedBox(width: 12.w,) ,Image.asset("assets/images/MyDealsDetails/Upload.png")],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w), // Making padding responsive
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r), // Making radius responsive
                    child: Image.asset(
                      'assets/images/MyDealsDetails/Starbucks.png',
                      fit: BoxFit.cover,
                      width: 398.w, // Using responsive width
                      height: 220.h, // Using responsive height
                    ),
                  ),
                  Positioned(
                    top: 12.h,
                    right: 5.w,
                    child: Container(
                      width: 92.w,
                      height: 24.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          color: Color(0xFFD62828)
                      ),
                      child: Center(
                        child: Text(
                          "Expire in 21 hours",
                          style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10.h),
              // Title Row with Text centered
              SizedBox(
                width: 398.w, // Responsive width
                child: Row(
                  children: [
                    Text(
                      "50% Off Any Grande Beverage",
                      style: TextStyle(
                        fontSize: 18.sp, // Responsive font size
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 26.h,
                      width: 58.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.r),
                        color: Color(0xFFECFDF5),
                      ),
                      child: Center(
                        child: Text(
                          'Active',
                          style: TextStyle(
                            color: Color(0xFF2ECC71),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6F7E8D), // Default color for the text
                  ),
                  children: [
                    TextSpan(
                      text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book ",
                    ),
                    TextSpan(
                      text: "Read more...",
                      style: TextStyle(
                        color: Color(0xFFD62828), // Red color for "Read more..."
                        fontWeight: FontWeight.bold, // Optional: Make it bold
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Handle tap action
                          print("Read more clicked!");
                        },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              // Align "Vendor" to left
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Vendor",
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                ),
              ),
              SizedBox(height: 5.h),
              DealCard(
                brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
                dealStoreName: 'Starbucks',
                dealValidity: '11:59 PM, May 31',
              ),
              SizedBox(height: 10.h),
              // Align "Redemption Method" to left
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Redemption Method",
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                ),
              ),
              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 92.h,
                    width: 195.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: Colors.white,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        // Handle onTap action
                      },
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/MyDealsDetails/Pickup Icon.png',
                              height: 24.h,
                              width: 24.w,
                            ),
                            SizedBox(height: 2.5.h),
                            Text(
                              "Pickup",
                              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp, color: Color(0xFF020711)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                      height: 92.h,
                      width: 195.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/MyDealsDetails/Delivery Icon.png',
                              height: 24.h,
                              width: 24.w,
                            ),
                            SizedBox(height: 2.5.h),
                            Text(
                              "Delivery",
                              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp, color: Color(0xFF020711)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              // Align "Location" to left
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Location",
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Container(
                width: 398.w,
                height: 140.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Image.asset(
                  'assets/images/MyDealsDetails/Location.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
