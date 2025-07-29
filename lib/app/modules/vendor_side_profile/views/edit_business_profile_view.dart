import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/vendor_side_profile/views/vendor_side_profile_view.dart';
import 'package:quopon/common/customTextButton.dart';
import 'package:quopon/common/custom_textField.dart';

import '../../../../common/ChooseField.dart';
import '../../../../common/EditProfileField.dart';
import '../../../../common/red_button.dart';
import '../../signUpProcess/views/vendor_business_hour_row_view.dart';

class EditBusinessProfileView extends GetView {
  const EditBusinessProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        "Edit Business Profile",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      SizedBox(),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage("assets/images/deals/details/Starbucks_Logo.png"),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withAlpha(100)
                      ),
                      child: Image.asset(
                        "assets/images/Profile/Upload.png",
                        height: 32,
                        width: 32,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    "Upload Logo",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ],
              ),
              Column(
                children: [
                  EditProfileField(label: 'Name', defaultText: 'Starbucks', hintText: 'Enter Name',),
                  EditProfileField(label: 'Email Address', defaultText: 'starbucks@email.com', hintText: 'Enter Email',),
                  EditProfileField(label: 'Phone Number', defaultText: '01234567890', hintText: 'Enter Phone Number',),
                  EditProfileField(label: 'Address', defaultText: 'Starbucks, 9737 Destiny USA Dr, Syracuse, NY 13290, USA', hintText: 'Enter Address',),
                  CustomCategoryField(fieldName: 'Category', isRequired: false, selectedCategory: 'Food & Beverage', categories: ['Food & Beverage'],),
                  SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Business Hours',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                      ),
                      SizedBox.shrink()
                    ],
                  ),
                  SizedBox(height: 8,),
                  VendorBusinessHourRowView(
                    isActive: true,
                    day: 'Mon',
                    startTime: '12:00 AM',
                    endTime: '12:00 AM',
                  ),
                  SizedBox(height: 15,),
                  VendorBusinessHourRowView(
                    isActive: true,
                    day: 'Tue',
                    startTime: '12:00 AM',
                    endTime: '12:00 AM',
                  ),
                  SizedBox(height: 15,),
                  VendorBusinessHourRowView(
                    isActive: true,
                    day: 'Wed',
                    startTime: '12:00 AM',
                    endTime: '12:00 AM',
                  ),
                  SizedBox(height: 15,),
                  VendorBusinessHourRowView(
                    isActive: true,
                    day: 'Thu',
                    startTime: '12:00 AM',
                    endTime: '12:00 AM',
                  ),
                  SizedBox(height: 15,),
                  VendorBusinessHourRowView(
                    isActive: true,
                    day: 'Fri',
                    startTime: '12:00 AM',
                    endTime: '12:00 AM',
                  ),
                  SizedBox(height: 15,),
                  VendorBusinessHourRowView(
                    isActive: false,
                    day: 'Sat',
                    startTime: '12:00 AM',
                    endTime: '12:00 AM',
                  ),
                  SizedBox(height: 15,),
                  VendorBusinessHourRowView(
                    isActive: false,
                    day: 'Sun',
                    startTime: '12:00 AM',
                    endTime: '12:00 AM',
                  ),

                  SizedBox(height: 20,),
                ],
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 32),
        height: 106,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16)]
        ),
        child:
        GradientButton(
          text: 'Save Changes',
          onPressed: () {
            Get.to(VendorSideProfileView());
          },
          colors: [Color(0xFFD62828), Color(0xFFC21414)],
        ),
      ),
    );
  }
}
