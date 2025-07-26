import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/vendor_edit_deal/views/vendor_edit_deal_view.dart';

import '../../../../common/profileCard.dart';

class DealsOptionsView extends GetView {
  const DealsOptionsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        color: Colors.white
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox.shrink(),
              Text(
                'Deal Options',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Color(0xFF020711)),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(Icons.close),
              )
            ],
          ),
          Divider(color: Color(0xFFEAECED),),

          SizedBox(height: 10,),

          GestureDetector(
            onTap: () {
              Get.back();
              Get.to(VendorEditDealView());
            },
            child: ProfileCard(icon: 'assets/images/DealOptions/Edit Deal.png', title: 'Edit Deal'),
          ),

          SizedBox(height: 10,),

          GestureDetector(
            onTap: () {

            },
            child: ProfileCard(icon: 'assets/images/DealOptions/Deactivate Deal.png', title: 'Deactivate Deal'),
          ),

          SizedBox(height: 10,),

          GestureDetector(
            onTap: () {

            },
            child: ProfileCard(icon: 'assets/images/DealOptions/Delete Deal.png', title: 'Delete Deal'),
          ),
        ],
      ),
    );
  }
}
