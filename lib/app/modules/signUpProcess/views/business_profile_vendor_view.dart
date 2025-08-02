import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:quopon/app/modules/signUpProcess/controllers/sign_up_process_vendor_controller.dart';

class BusinessProfileVendorView extends GetView<SignUpProcessVendorController> {
  final VoidCallback onNext;
  final VoidCallback onSkip;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _selectedCategory = 'Select';

  BusinessProfileVendorView({super.key, required this.onNext, required this.onSkip});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.w), // Use ScreenUtil for padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Business Profile Setup',
              style: TextStyle(
                fontSize: 28.sp, // Use ScreenUtil for font size
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h), // Use ScreenUtil for height spacing
            Text(
              'Provide your business details to begin onboarding with Qoupon.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp, // Use ScreenUtil for font size
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 40.h), // Use ScreenUtil for height spacing
            Center(
              child: Column(
                children: [
                  Container(
                    width: 80.w, // Use ScreenUtil for width
                    height: 80.h, // Use ScreenUtil for height
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/CompleteProfile/Cloud.png',
                      color: Color(0xFF020711),
                      height: 30.h,
                      width: 30.w,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Upload Profile Picture',
                    style: TextStyle(
                      fontSize: 14.sp, // Use ScreenUtil for font size
                      color: Color(0xFF020711),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h), // Use ScreenUtil for height spacing
            _buildTextField(
              'Store Name',
              'Enter store name',
              _nameController,
            ),
            SizedBox(height: 20.h), // Use ScreenUtil for height spacing
            _buildTextField(
              'KVK Number',
              'Enter KVK number',
              _nameController,
            ),
            SizedBox(height: 20.h), // Use ScreenUtil for height spacing
            _buildTextField(
              'Phone Number',
              'Enter phone number',
              _phoneController,
            ),
            SizedBox(height: 20.h), // Use ScreenUtil for height spacing
            _buildTextField(
              'Store Address',
              'Enter store address',
              _nameController,
            ),
            SizedBox(height: 20.h), // Use ScreenUtil for height spacing
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Category',
                  style: TextStyle(
                    fontSize: 16.sp, // Use ScreenUtil for font size
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8.h), // Use ScreenUtil for height spacing
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w), // Use ScreenUtil for padding
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8.r), // Use ScreenUtil for border radius
                  ),
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    isExpanded: true,
                    underline: Container(),
                    items: ['Select',]
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      // setState(() {
                      //   _selectedLanguage = newValue!;
                      // });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16.sp, // Use ScreenUtil for font size
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.h), // Use ScreenUtil for height spacing
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[500]),
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r), // Use ScreenUtil for border radius
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h), // Use ScreenUtil for padding
          ),
        ),
      ],
    );
  }
}
