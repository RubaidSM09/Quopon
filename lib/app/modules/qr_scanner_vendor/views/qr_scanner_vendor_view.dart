import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:quopon/app/modules/qr_scanner_vendor/views/qr_fail_vendor_view.dart';
import 'package:quopon/app/modules/qr_scanner_vendor/views/qr_success_vendor_view.dart';
import 'package:quopon/app/modules/qr_scanner_vendor/views/verification_code_view.dart';
import 'package:quopon/common/customTextButton.dart';

import '../controllers/qr_scanner_vendor_controller.dart';

class QrScannerVendorView extends GetView<QrScannerVendorController> {
  final MobileScannerController _scannerController = MobileScannerController();

  int _selectedIndex = 2;
  bool _isScanned = false;

  Future<void> _handleQRCode(String code) async {
    // API endpoint URL
    final String url = 'http://10.10.13.52:7000/discover/qr-scanner/';

    try {
      // Sending GET request to the API with the QR code
      final response = await http.get(Uri.parse('$url?code=$code'));

      if (response.statusCode == 200) {
        // Parse the response
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['details'] == "No active offer found.") {
          Get.dialog(QrFailVendorView());
        } else {
          Get.dialog(QrSuccessVendorView(dealTitle: '50% Off Any Grande Beverage', dealStoreName: 'Starbucks', brandLogo: 'assets/images/deals/details/Starbucks_Logo.png', time: '01:05 AM'));
        }
      } else {
        // Handle unsuccessful API response
        Get.snackbar("Error", "Failed to fetch data from API.");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    }
  }

  void _showQRSuccess(BuildContext context, String dealTitle, String dealStoreName, String brandLogo, String time) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: QrSuccessVendorView(dealTitle: dealTitle, dealStoreName: dealStoreName, brandLogo: brandLogo, time: time),
        );
      },
    );
  }

  void _showQRFail(BuildContext context) {
    Get.dialog(QrFailVendorView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Camera View (disable on Web)
          if (!kIsWeb)
            MobileScanner(
              controller: _scannerController,
              onDetect: (BarcodeCapture capture) {
                if (_isScanned) return;

                final List<Barcode> barcodes = capture.barcodes;
                if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
                  _isScanned = true;
                  final String code = barcodes.first.rawValue!;
                  debugPrint('Scanned: $code');

                  // Make the API call to validate QR code
                  _handleQRCode(code);

                  // Reset after 3 seconds
                  Future.delayed(const Duration(seconds: 3), () {
                    _isScanned = false;
                  });
                }
              },
            )
          else
            const Center(
              child: Text(
                "Scanner not supported on web",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),

          // Header bar
          Positioned(
            top: 40.h,
            left: 16.w,
            right: 16.w,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                SizedBox(width: 12.w),
                Text(
                  "Scan QR Code",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),

          // QR Scan overlay box and label
          Center(
            child: Container(
              width: 200.w,
              height: 200.h,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2.w),
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),

          // Bottom action buttons (Flash & Camera flip)
          Positioned(
            bottom: 100.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _scannerController.toggleTorch(),
                  child: _actionButton(Icons.flash_on),
                ),
                SizedBox(width: 32.w),
                GestureDetector(
                  onTap: () => _scannerController.switchCamera(),
                  child: _actionButton(Icons.cameraswitch),
                ),
                SizedBox(width: 32.w),
                GestureDetector(
                  onTap: () => Get.dialog(QrSuccessVendorView(dealTitle: '50% Off Any Grande Beverage', dealStoreName: 'Starbucks', brandLogo: 'assets/images/deals/details/Starbucks_Logo.png', time: '01:05 AM')),
                  child: _actionButton(Icons.flash_on),
                ),
                SizedBox(width: 32.w),
                GestureDetector(
                  onTap: () => _showQRFail(context),
                  child: _actionButton(Icons.cameraswitch),
                ),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.r),
        color: Colors.white,
        child: GradientButton(
          text: 'Use 6 Digit Code',
          onPressed: () {
            Get.dialog(VerificationCodeView());
          },
          colors: [const Color(0xFFD62828), const Color(0xFFC21414)],
          boxShadow: [const BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)],
          child: Text(
            'Use 6 Digit Code',
            style: TextStyle(
              fontSize: 16.sp,  // Use ScreenUtil for font size
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _actionButton(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
      padding: EdgeInsets.all(12.w),  // Use ScreenUtil for padding
      child: Icon(icon, color: Colors.white),
    );
  }
}
