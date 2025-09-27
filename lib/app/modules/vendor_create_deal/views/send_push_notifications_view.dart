import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';  // Import ScreenUtil
import 'package:quopon/app/modules/vendor_create_deal/controllers/send_push_notifications_controller.dart';
import 'package:quopon/common/custom_textField.dart';

import '../../../../common/customTextButton.dart';
import '../controllers/vendor_create_deal_controller.dart';

class SendPushNotificationsView extends GetView<SendPushNotificationsController> {
  final int dealId;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final VendorCreateDealController checkboxController = Get.put(VendorCreateDealController());

  SendPushNotificationsView({
    required this.dealId,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    Get.put(SendPushNotificationsController());

    return Dialog(
        backgroundColor: Color(0xFFFFFFFF),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.r), // Use ScreenUtil for padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/CreateDeals/Push Notifications.gif',
                  height: 80.h,  // Use ScreenUtil for height
                  width: 80.w,   // Use ScreenUtil for width
                ),
                SizedBox(height: 20.h), // Use ScreenUtil for spacing
                Column(
                  children: [
                    Text(
                      'Notify Your Followers',
                      style: TextStyle(
                          fontSize: 20.sp,  // Use ScreenUtil for font size
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF020711)
                      ),
                    ),
                    SizedBox(
                      child: Text(
                        'Your deal is live! Send a push notification to let your followers know. Qoupon+ users will get full access.',
                        style: TextStyle(
                            fontSize: 12.95.sp,  // Use ScreenUtil for font size
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF6F7E8D)
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h), // Use ScreenUtil for spacing
                GetInTouchTextField(
                  headingText: 'Title',
                  fieldText: '🎉 New deal just went live! Tap to view.',
                  iconImagePath: '',
                  controller: _titleController,
                  isRequired: false,
                ),
                SizedBox(height: 20.h), // Use ScreenUtil for spacing
                GetInTouchTextField(
                  headingText: 'Short Description',
                  fieldText: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                  iconImagePath: '',
                  controller: _descriptionController,
                  isRequired: false,
                  maxLine: 6,
                ),
                SizedBox(height: 20.h), // Use ScreenUtil for spacing

                Row(
                  children: [
                    // Use Obx to listen to changes in isChecked
                    Obx(() {
                      return Checkbox(
                        activeColor: Color(0xFFD62828),
                        value: checkboxController.isChecked.value,
                        onChanged: (bool? value) {
                          checkboxController.toggleCheckbox(value ?? false);
                        },
                      );
                    }),
                    Text(
                      'Followers: 1,245',
                      style: TextStyle(
                          fontSize: 14.sp, // Use ScreenUtil for font size
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF020711)
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    // Use Obx to listen to changes in isChecked
                    Obx(() {
                      return Checkbox(
                        activeColor: Color(0xFFD62828),
                        value: checkboxController.isChecked.value,
                        onChanged: (bool? value) {
                          checkboxController.toggleCheckbox(value ?? false);
                        },
                      );
                    }),
                    Text(
                      'Qoupon+ (full access): 322',
                      style: TextStyle(
                          fontSize: 14.sp, // Use ScreenUtil for font size
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF020711)
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.h), // Use ScreenUtil for spacing

                GradientButton(
                  text: 'Send Push Notification',
                  onPressed: () {
                    controller.pushNotifications(dealId, _titleController.text, _descriptionController.text);
                  },
                  colors: [Color(0xFFD62828), Color(0xFFC21414)],
                ),
                SizedBox(height: 10.h), // Use ScreenUtil for spacing
                GradientButton(
                  text: 'Skip for Now',
                  onPressed: () {
                    Get.back();
                    Get.back();
                  },
                  colors: [Color(0xFFF4F5F6), Color(0xFFEEF0F3)],
                  boxShadow: [BoxShadow(color: Color(0xFFDFE4E9), spreadRadius: 1)],
                  child: Text(
                    'Skip for Now',
                    style: TextStyle(
                        fontSize: 16.sp, // Use ScreenUtil for font size
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF020711)
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
