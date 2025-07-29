import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:get/get.dart';
import 'package:quopon/common/HelpCenterCard.dart';
import '../../SupportFAQ/views/get_in_touch_view.dart';

class HelpCenterView extends GetView {
  const HelpCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Help Center Section
        Container(
          height: 172.h, // Use ScreenUtil for height
          decoration: BoxDecoration(
            color: Color(0xFFF6EAEB),
            borderRadius: BorderRadius.circular(12.r), // Use ScreenUtil for radius
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.w, top: 32.h, bottom: 32.h), // Use ScreenUtil for padding
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How can we help?',
                      style: TextStyle(
                        fontSize: 16.sp, // Use ScreenUtil for font size
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF020711),
                      ),
                    ),
                    SizedBox(
                      width: 150.w, // Use ScreenUtil for width
                      child: Text(
                        'Find your queries answers from our various support features.',
                        style: TextStyle(
                          fontSize: 10.sp, // Use ScreenUtil for font size
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF6F7E8D),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.bottomSheet(GetInTouchView());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r), // Use ScreenUtil for border radius
                          color: Color(0xFFD62828),
                        ),
                        padding: EdgeInsets.only(
                            top: 8.h, bottom: 8.h, right: 16.w, left: 16.w), // Use ScreenUtil for padding
                        child: Text(
                          'Contact us',
                          style: TextStyle(
                            fontSize: 12.sp, // Use ScreenUtil for font size
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(12.r)), // Use ScreenUtil for border radius
                child: Image.asset('assets/images/SupportFAQ/Illustration.png'),
              ),
            ],
          ),
        ),

        SizedBox(height: 20.h), // Use ScreenUtil for height

        // Help Center Cards
        HelpCenterCard(
          title: 'Account & Profile',
          description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
        ),
        SizedBox(height: 15.h), // Use ScreenUtil for height
        HelpCenterCard(
          title: 'Redeeming Deals',
          description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
        ),
        SizedBox(height: 15.h), // Use ScreenUtil for height
        HelpCenterCard(
          title: 'Qoupon+ Membership',
          description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
        ),
        SizedBox(height: 15.h), // Use ScreenUtil for height
        HelpCenterCard(
          title: 'Payment & Billing',
          description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
        ),
        SizedBox(height: 15.h), // Use ScreenUtil for height
        HelpCenterCard(
          title: 'Location & Notifications',
          description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
        ),
      ],
    );
  }
}
