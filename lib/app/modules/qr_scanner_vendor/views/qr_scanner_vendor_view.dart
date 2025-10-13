import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:quopon/app/data/api_client.dart';
import 'package:quopon/app/modules/my_orders_vendors/controllers/my_orders_vendors_controller.dart';
import 'package:quopon/app/modules/qr_scanner_vendor/views/qr_fail_vendor_view.dart';
import 'package:quopon/app/modules/qr_scanner_vendor/views/qr_success_vendor_view.dart';
import 'package:quopon/app/modules/qr_scanner_vendor/views/verification_code_view.dart';
import 'package:quopon/common/customTextButton.dart';

import '../../../data/model/vendor_order.dart';
import '../controllers/qr_scanner_vendor_controller.dart';

class QrScannerVendorView extends GetView<QrScannerVendorController> {
  QrScannerVendorView({super.key});

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? scannerController;

  bool _isScanned = false;

  @override
  void dispose() {
    scannerController?.dispose();
    // super.dispose(); // No super.dispose() in GetView
  }

  void _onQRViewCreated(QRViewController controller) {
    scannerController = controller;
    controller.scannedDataStream.listen((scanData) {
      if (_isScanned) return;

      final String? code = scanData.code;
      if (code != null) {
        _isScanned = true;
        debugPrint('Scanned: $code');
        _handleQRCode(code);
        Future.delayed(const Duration(seconds: 3), () {
          _isScanned = false;
        });
      }
    });
  }

  Future<void> _handleQRCode(String code) async {
    final ordersCtrl = Get.find<MyOrdersVendorsController>();
    final VendorOrder? order = ordersCtrl.orders.firstWhereOrNull((o) => o.deliveryCode == code);

    if (order == null || order.status != 'OUT_FOR_DELIVERY' || order.deliveryCodeUsed) {
      Get.dialog(const QrFailVendorView());
      return;
    }

    final url = Uri.parse('https://doctorless-stopperless-turner.ngrok-free.dev/order/orders/${order.orderId}/verify-delivery/');
    try {
      final response = await http.post(
        url,
        headers: await ApiClient.authHeaders(),
        body: json.encode({'delivery_code': code}),
      );
      if (response.statusCode == 200) {
        final currentTime = DateFormat('hh:mm a').format(DateTime.now());
        Get.dialog(QrSuccessOrderView(
          invoiceNumber: order.orderId,
          customerName: 'User ${order.user}',
          orderItems: order.items.map((i) => '${i.quantity} x ${i.itemName}').join(', '),
          timestamp: 'Verified at $currentTime',
        ));
        ordersCtrl.fetchOrders();
      } else {
        Get.dialog(const QrFailVendorView());
      }
    } catch (e) {
      Get.dialog(const QrFailVendorView());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Camera View (disable on Web)
          if (!kIsWeb)
            QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.white,
                borderRadius: 8.r,
                borderLength: 30.w,
                borderWidth: 2.w,
                cutOutSize: 200.w,
              ),
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

          // Bottom action buttons (Flash & Camera flip)
          Positioned(
            bottom: 100.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => scannerController?.toggleFlash(),
                  child: _actionButton(Icons.flash_on),
                ),
                SizedBox(width: 32.w),
                GestureDetector(
                  onTap: () => scannerController?.flipCamera(),
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
              fontSize: 16.sp,
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
      padding: EdgeInsets.all(12.w),
      child: Icon(icon, color: Colors.white),
    );
  }
}
