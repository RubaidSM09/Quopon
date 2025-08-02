import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:quopon/app/modules/QRScanner/views/q_r_fail_view.dart';
import 'package:quopon/app/modules/QRScanner/views/q_r_success_view.dart';

import '../../MyDeals/views/my_deals_view.dart';
import '../../Profile/views/profile_view.dart';
import '../../deals/views/deals_view.dart';
import '../../home/views/home_view.dart';

class QRScannerView extends StatefulWidget {
  const QRScannerView({super.key});

  @override
  State<QRScannerView> createState() => _QRScannerViewState();
}

class _QRScannerViewState extends State<QRScannerView> {
  final MobileScannerController _scannerController = MobileScannerController();

  int _selectedIndex = 2;
  bool _isScanned = false;

  void _showQRSuccess(BuildContext context, String dealTitle, String dealStoreName, String brandLogo, String time) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: QRSuccessView(dealTitle: dealTitle, dealStoreName: dealStoreName, brandLogo: brandLogo, time: time),
        );
      },
    );
  }

  void _showQRFail(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: QRFailView(),
        );
      },
    );
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
                  onTap: () => _showQRSuccess(context, '50% Off Any Grande Beverage', 'Starbucks', 'assets/images/deals/details/Starbucks_Logo.png', '01:05 AM'),
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
