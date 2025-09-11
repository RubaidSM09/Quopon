import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quopon/app/modules/forgot_password/views/set_new_password_view.dart';
import 'package:quopon/app/modules/signUpProcess/views/sign_up_process_vendor_view.dart';
import 'package:quopon/app/modules/signUpProcess/views/sign_up_process_view.dart';

import '../../../../common/customTextButton.dart';
import '../../../../common/custom_textField.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../controllers/forgot_password_controller.dart';

class MailVerificationCodeView extends GetView<ForgotPasswordController> {
  final String email;
  final String password;
  final bool passwordForgot;
  final String userType;
  final emailController = TextEditingController();
  bool isLoading = false;

  MailVerificationCodeView({
    required this.email,
    this.password = '',
    required this.passwordForgot,
    required this.userType,
    super.key
  }) {
    Get.put(ForgotPasswordController());
  }

  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> storeTokens(String accessToken, String refreshToken, int userId) async {
    await _storage.write(key: 'access_token', value: accessToken);
    await _storage.write(key: 'refresh_token', value: refreshToken);
    await _storage.write(key: 'user_id', value: userId.toString());
  }

  // API call to verify OTP
  Future<void> verifyOtp(String otp) async {
    try {
      controller.setLoading(true); // Set loading to true

      final body = {
        'email': email,
        'otp': otp
      };

      final headers = {'Content-Type': 'application/json'};

      final response = await BaseClient.postRequest(
        api: Api.verification,
        body: jsonEncode(body),
        headers: headers,
      );

      print(response.statusCode);

      controller.setLoading(false); // Set loading to false

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (password != '') {
          var body = {
            'email': email,
            'password': password,
          };

          var headers = {
            'Content-Type': 'application/json',
          };

          final response = await BaseClient.postRequest(
            api: Api.login,
            body: jsonEncode(body),
            headers: headers,
          );

          //final result = await BaseClient.handleResponse(response);

          if (response.statusCode == 200 || response.statusCode == 201) {
            // Assuming the server responds with success on code 200 or 201
            final responseBody = jsonDecode(response.body);
            final accessToken = responseBody['access'];
            final refreshToken = responseBody['refresh'];
            final userId = responseBody['id'];

            // Store the tokens securely
            await storeTokens(accessToken, refreshToken, userId);

            print(':::::::::::::::responseBody:::::::::::::::::::::$responseBody');
            print(':::::::::::::::accessToken:::::::::::::::::::::$accessToken');
            print(':::::::::::::::refreshToken:::::::::::::::::::::$refreshToken');

            Get.snackbar('Success', 'Logged in successfully!');

            //Get.off(() => VerifyOTPView());


            // SharedPreferences

            // final prefs = await SharedPreferences.getInstance();
            // await prefs.setBool('isLoggedIn', true); // User is logged in

            // Get.offAll(() => DashboardView());

            // homeController.fetchProfileData();
            // homeController.checkVerified(username);

            // Get.to(LandingView());
          } else {
            final responseBody = jsonDecode(response.body);
            Get.snackbar('Login failed', responseBody['message'] ?? 'Please use Correct UserName and Password');
          }
        }

        // If OTP verification is successful, navigate to the next screen
        passwordForgot ? Get.to(SetNewPasswordView(email: email, userType: userType,)) : userType == 'user' ? Get.to(SignUpProcessView()) : Get.to(SignUpProcessVendorView());
      } else {
        // Show error message
        final responseData = json.decode(response.body);
        _showError(responseData['message'] ?? 'OTP verification failed');
      }
    } catch (error) {
      controller.setLoading(false); // Set loading to false
      _showError('An error occurred. Please try again.');
    }
  }

  // Show error dialog or snack bar
  void _showError(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 92, bottom: 38),
        child: SizedBox(
          height: 802.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(12.w), // Use ScreenUtil for padding
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFD62828), Color(0xFFC21414)],
                      ),
                      borderRadius: BorderRadius.circular(
                        16.r,
                      ), // Use ScreenUtil for border radius
                      border: Border.all(width: 1, color: Colors.transparent),
                      boxShadow: [
                        BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/login/Logo Icon.png',
                      fit: BoxFit.cover,
                    ),
                  ),

                  SizedBox(height: 24.h), // Use ScreenUtil for height spacing
                  // Title
                  Text(
                    'Verify Your Email',
                    style: TextStyle(
                      fontSize: 28.sp, // Use ScreenUtil for font size
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF020711),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 12.h), // Use ScreenUtil for height spacing
                  // Subtitle
                  Text(
                    'Enter the 6-digit code we sent to your email.',
                    style: TextStyle(
                      fontSize: 16.sp, // Use ScreenUtil for font size
                      color: Color(0xFF6F7E8D),
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 48.h), // Use ScreenUtil for height spacing
                  // Input boxes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(6, (index) {
                      return SizedBox(
                        width: 58.w,
                        height: 58.h,
                        child: TextField(
                          onTapOutside: (_) => FocusScope.of(context).unfocus(),
                          controller: controller.controllers[index],
                          focusNode: controller.focusNodes[index],
                          onChanged: (value) =>
                              controller.onDigitEntered(index, value),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          maxLength: 1,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF020711),
                          ),
                          decoration: InputDecoration(
                            counterText: '',
                            enabled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(color: Color(0xFFEAECED)),
                            ),
                            filled: true,
                            fillColor: Color(0xFFF4F6F7),
                          ),
                        ),
                      );
                    }),
                  ),

                  SizedBox(height: 24.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t receive code? ",
                        style: TextStyle(
                          color: Color(0xFF6F7E8D),
                          fontSize: 14.sp, // Use ScreenUtil for font size
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Resend Now',
                          style: TextStyle(
                            color: Color(0xFFDC143C),
                            fontSize: 14.sp, // Use ScreenUtil for font size
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              Column(
                children: [
                  Obx(() {
                    return GradientButton(
                      text: 'Verify',
                      onPressed: () {
                        if (controller.isLoading.value) {
                          return null;
                        } else {
                          String otp = controller.code;
                          if (otp.length == 6) {
                            verifyOtp(otp); // Call the API
                          } else {
                            _showError('Please enter a valid 6-digit OTP');
                          }
                        }
                      },
                      colors: [
                        const Color(0xFFD62828),
                        const Color(0xFFC21414),
                      ],
                      boxShadow: [
                        const BoxShadow(
                          color: Color(0xFF9A0000),
                          spreadRadius: 1,
                        ),
                      ],
                      child: controller.isLoading.value
                          ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )  // Show loading indicator if isLoading is true
                          : Text(
                        'Verify',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }),


                  SizedBox(height: 12.h),
                  GradientButton(
                    text: 'Go Back',
                    onPressed: () {
                      Get.back();
                    },
                    colors: [const Color(0xFFF4F5F6), const Color(0xFFEEF0F3)],
                    borderColor: [Colors.white, Color(0xFFEEF0F3)],
                    boxShadow: [
                      const BoxShadow(
                        color: Color(0xFFDFE4E9),
                        spreadRadius: 1,
                      ),
                    ],
                    child: Text(
                      'Go Back',
                      style: TextStyle(
                        color: Color(0xFF020711),
                        fontSize: 16.sp, // Use ScreenUtil for font size
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
