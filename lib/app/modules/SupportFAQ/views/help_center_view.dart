import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quopon/common/HelpCenterCard.dart';

class HelpCenterView extends GetView {
  const HelpCenterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 172,
          decoration: BoxDecoration(
            color: Color(0xFFF6EAEB),
            borderRadius: BorderRadius.circular(12)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.0, top: 32, bottom: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How can we help?',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF020711)),
                    ),
                    SizedBox(
                      width: 150,
                      child: Text(
                        'Find your queries answers from our various support features.',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {

                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color(0xFFD62828)
                        ),
                        padding: EdgeInsets.only(top: 8, bottom: 8, right: 16, left: 16),
                        child: Text(
                          'Contact us',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFFFFFFFF)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(12)),
                child: Image.asset('assets/images/SupportFAQ/Illustration.png'),
              )
            ],
          ),
        ),

        SizedBox(height: 20,),

        HelpCenterCard(
          title: 'Account & Profile',
          description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
        ),
        SizedBox(height: 15,),
        HelpCenterCard(
          title: 'Redeeming Deals',
          description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
        ),
        SizedBox(height: 15,),
        HelpCenterCard(
          title: 'Qoupon+ Membership',
          description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
        ),
        SizedBox(height: 15,),
        HelpCenterCard(
          title: 'Payment & Billing',
          description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
        ),
        SizedBox(height: 15,),
        HelpCenterCard(
          title: 'Location & Notifications',
          description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
        ),
      ],
    );
  }
}
