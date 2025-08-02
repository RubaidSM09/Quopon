import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/privacy_policy_controller.dart';

class PrivacyPolicyView extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      appBar: AppBar(
        backgroundColor: Color(0xFFF9FBFC),
        title: Center(child: Text('Privacy Policy')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(  // Use SingleChildScrollView for better responsiveness
        padding: EdgeInsets.all(16.w),  // Using ScreenUtil for padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,  // Align content to the left
          children: [
            // Privacy Policy Title
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 24.sp,  // Using ScreenUtil for font size
                fontWeight: FontWeight.bold,
                color: Color(0xFF020711),
              ),
            ),
            SizedBox(height: 8.h),  // Using ScreenUtil for height
            Text(
              'Last updated: June 25, 2025',
              style: TextStyle(
                fontSize: 16.sp,  // Using ScreenUtil for font size
                color: Color(0xFF6F7E8D),
              ),
            ),
            SizedBox(height: 16.h),  // Using ScreenUtil for height
            Text(
              'This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.\n\nWe use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy. This Privacy Policy has been created with the help of the Privacy Policy Generator.',
              style: TextStyle(fontSize: 16.sp, height: 1.5, color: Color(0xFF6F7E8D),),
            ),
            SizedBox(height: 16.h),  // Using ScreenUtil for height
            Text(
              'Interpretation and Definitions',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Color(0xFF020711)),
            ),
            SizedBox(height: 8.h),  // Using ScreenUtil for height
            Text(
              'Interpretation\n',
              style: TextStyle(fontSize: 16.sp, height: 1.5, fontWeight: FontWeight.bold, color: Color(0xFF020711)),
            ),
            Text(
              'The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.\n',
              style: TextStyle(fontSize: 16.sp, height: 1.5, color: Color(0xFF6F7E8D),),
            ),
            SizedBox(height: 16.h),  // Using ScreenUtil for height
            Text(
              'Definitions\n',
              style: TextStyle(fontSize: 16.sp, height: 1.5, fontWeight: FontWeight.bold, color: Color(0xFF020711)),
            ),
            Text.rich(
              TextSpan(
                text: 'For the purposes of this Privacy Policy:\n\n',
                style: TextStyle(fontSize: 16.sp, height: 1.5, color: Color(0xFF6F7E8D),),
                children: [
                  TextSpan(
                    text: '• Account ',
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black,),
                  ),
                  TextSpan(
                    text: 'means a unique account created for You to access our Service or parts of our Service.\n',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  TextSpan(
                    text: '• Affiliate ',
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black,),
                  ),
                  TextSpan(
                    text: 'means an entity that controls, is controlled by or is under common control with a party, where “control” means ownership of 50% or more of the shares, equity interest or other securities entitled to vote for election of directors or other managing authority.\n',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  TextSpan(
                    text: '• Application ',
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black,),
                  ),
                  TextSpan(
                    text: 'refers to Quopon, the software program provided by the Company.\n',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  TextSpan(
                    text: '• Company ',
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black,),
                  ),
                  TextSpan(
                    text: 'refers to either “the Company”, “We”, “Us” or “Our” in this Agreement) refers to Quopon.\n',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  TextSpan(
                    text: '• Country ',
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black,),
                  ),
                  TextSpan(
                    text: 'refers to: Netherlands',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ],
              ),
            ),
            // Add more sections as needed
          ],
        ),
      ),
    );
  }
}
