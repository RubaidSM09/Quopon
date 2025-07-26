import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/vendor_create_deal/views/send_push_notifications_view.dart';
import 'package:quopon/app/modules/vendor_create_deal/views/vendor_create_deal_view.dart';
import 'package:quopon/common/customTextButton.dart';

class DealPublishView extends GetView {
  const DealPublishView({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Color(0xFFFFFFFF),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/CreateDeals/Deal Publish.gif',
                  height: 80,
                  width: 80,
                ),
                SizedBox(height: 20,),
                Column(
                  children: [
                    Text(
                      'Deal Published Successfully',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                    ),
                    Text(
                      'Your deal is now live on Qoupon. You can now notify your followers or manage the deal anytime.',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                GradientButton(
                  text: 'Send Push Notification',
                  onPressed: () {
                    Get.back();
                    Get.dialog(SendPushNotificationsView());
                  },
                  colors: [Color(0xFFD62828), Color(0xFFC21414)],
                ),
                SizedBox(height: 10,),
                GradientButton(
                  text: 'Skip for Now',
                  onPressed: () {
                    Get.to(VendorCreateDealView());
                  },
                  colors: [Color(0xFFF4F5F6), Color(0xFFEEF0F3)],
                  borderColor: Color(0xFFEEF0F3),
                  boxShadow: [BoxShadow(color: Color(0xFFDFE4E9), spreadRadius: 1)],
                  child: Text(
                    'Skip for Now',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
