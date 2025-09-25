import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

import '../controllers/q_r_scanner_controller.dart';


class QRScannerView extends GetView<QRScannerController> {
  const QRScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    // NOTE: controller is provided by your Binding. Don't Get.put here.
    Get.put(QRScannerController());
    final cameraSupported = !kIsWeb && (Platform.isAndroid || Platform.isIOS);

    return Scaffold(
      body: Stack(
        children: [
          if (cameraSupported)
            QRView(
              key: controller.qrKey,
              onQRViewCreated: controller.onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.white,
                borderRadius: 8.r,
                borderLength: 30.w, // double OK
                borderWidth: 6.w,
                cutOutSize: 220.w,
              ),
            )
          else
            const Center(
              child: Text(
                "Scanner not supported on this platform",
                style: TextStyle(color: Colors.black87, fontSize: 18),
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
                  onTap: () => Get.back(),
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
                ),
              ],
            ),
          ),

          // Bottom action buttons
          if (cameraSupported)
            Positioned(
              bottom: 100.h,
              left: 0,
              right: 0,
              child: Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _actionButton(
                      icon: controller.isTorchOn.value ? Icons.flash_on : Icons.flash_off,
                      onTap: controller.toggleTorch,
                    ),
                    SizedBox(width: 32.w),
                    _actionButton(
                      icon: Icons.cameraswitch,
                      onTap: controller.flipCamera,
                    ),
                  ],
                );
              }),
            ),
        ],
      ),
    );
  }

  Widget _actionButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(12.w),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
