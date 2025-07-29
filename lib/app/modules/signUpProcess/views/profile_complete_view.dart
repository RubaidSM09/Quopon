import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';  // Import ScreenUtil
import 'package:quopon/common/custom_textField.dart';

class ProfileCompleteScreen extends StatefulWidget {
  final VoidCallback onFinish;
  final VoidCallback onSkip;

  const ProfileCompleteScreen({required this.onFinish, required this.onSkip});

  @override
  _ProfileCompleteScreenState createState() => _ProfileCompleteScreenState();
}

class _ProfileCompleteScreenState extends State<ProfileCompleteScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),  // Use ScreenUtil for padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Complete Your Profile',
            style: TextStyle(
              fontSize: 28.sp,  // Use ScreenUtil for font size
              fontWeight: FontWeight.bold,
              color: Color(0xFF020711),
            ),
          ),
          SizedBox(height: 8.h),  // Use ScreenUtil for height spacing
          Text(
            'Add your details to personalize your Goupon\nexperience.',
            style: TextStyle(
              fontSize: 16.sp,  // Use ScreenUtil for font size
              color: Color(0xFF6F7E8D),
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40.h),  // Use ScreenUtil for height spacing
          Center(
            child: Column(
              children: [
                Container(
                  width: 80.w,  // Use ScreenUtil for width
                  height: 80.h,  // Use ScreenUtil for height
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/CompleteProfile/Cloud.png',
                    color: Color(0xFF6F7E8D),
                    height: 30.h,  // Use ScreenUtil for height
                    width: 30.w,  // Use ScreenUtil for width
                  ),
                ),
                SizedBox(height: 8.h),  // Use ScreenUtil for height spacing
                Text(
                  'Upload Profile Picture',
                  style: TextStyle(
                    fontSize: 14.sp,  // Use ScreenUtil for font size
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF020711),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40.h),  // Use ScreenUtil for height spacing
          GetInTouchTextField(
              headingText: 'Full Name',
              fieldText: 'Enter full name',
              iconImagePath: '',
              controller: _nameController,
              isRequired: false
          ),
          SizedBox(height: 20.h),  // Use ScreenUtil for height spacing
          GetInTouchTextField(
              headingText: 'Phone Number',
              fieldText: 'Enter phone number',
              iconImagePath: '',
              controller: _phoneController,
              isRequired: false
          ),
          SizedBox(height: 20.h),  // Use ScreenUtil for height spacing
          CustomCategoryField(
            fieldName: 'Language',
            isRequired: false,
            selectedCategory: 'English',
            categories: ['English', 'Spanish', 'German', 'French'],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
