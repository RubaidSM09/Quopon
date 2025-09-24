import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:intl/intl.dart';
import 'package:quopon/app/data/api_client.dart';

import '../../../data/model/deal_model.dart';
import '../../../data/model/vendor_profile.dart';
import '../views/q_r_fail_view.dart';
import '../views/q_r_success_view.dart';

class QRScannerController extends GetxController {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrController;

  final RxBool isTorchOn = false.obs;
  final RxBool isProcessing = false.obs;

  // Cache vendor profiles for this session
  final RxList<VendorProfile> _vendors = <VendorProfile>[].obs;
  final String _vendorsUrl =
      'https://intensely-optimal-unicorn.ngrok-free.app/vendors/all-business-profile/';

  @override
  void onInit() {
    super.onInit();
    _prefetchVendors();
  }

  Future<void> _prefetchVendors() async {
    try {
      final res = await http.get(
        Uri.parse(_vendorsUrl),
        headers: await ApiClient.authHeaders(),
      );
      debugPrint('vendors GET -> ${res.statusCode}');
      if (res.statusCode == 200) {
        final List<dynamic> list = jsonDecode(res.body) as List<dynamic>;
        _vendors.assignAll(
          list.map((e) => VendorProfile.fromJson(e as Map<String, dynamic>)).toList(),
        );
        debugPrint('vendors loaded: ${_vendors.length}');
      }
    } catch (e) {
      debugPrint('vendors load error: $e');
    }
  }

  void onQRViewCreated(QRViewController controller) {
    qrController = controller;
    controller.scannedDataStream.listen((scanData) async {
      final code = scanData.code?.trim();
      if (code == null || code.isEmpty) return;
      if (isProcessing.value) return;

      isProcessing.value = true;
      await _handleScan(code);
      await Future.delayed(const Duration(seconds: 2));
      isProcessing.value = false;
    });
  }

  Future<void> _handleScan(String code) async {
    final dealId = _extractDealId(code);
    if (dealId == null) {
      await _showFail();
      return;
    }

    final url = 'https://intensely-optimal-unicorn.ngrok-free.app/vendors/all-deals/$dealId/';

    try {
      await qrController?.pauseCamera();

      final res = await http.get(
        Uri.parse(url),
        headers: await ApiClient.authHeaders(),
      );

      if (res.statusCode == 200) {
        final deal = dealFromJson(res.body);

        final now = DateTime.now();
        final validWindow = now.isAfter(deal.startDate) && now.isBefore(deal.endDate);

        if (deal.isActive && validWindow) {
          final vendor = await _getVendorForDeal(vendorId: deal.userId, email: deal.email);

          final vendorName = (vendor != null && vendor.name.trim().isNotEmpty)
              ? vendor.name
              : deal.email; // final fallback

          final brandLogoUrl = (vendor != null && (vendor.logoImage ?? '').trim().isNotEmpty)
              ? vendor!.logoImage!.trim()
              : deal.imageUrl;

          final formattedTime = DateFormat('hh:mm a').format(now);

          await _showSuccess(
            dealTitle: deal.title,
            vendorName: vendorName,
            brandLogoUrl: brandLogoUrl,
            time: formattedTime,
          );
        } else {
          await _showFail();
        }
      } else {
        await _showFail();
      }
    } catch (_) {
      await _showFail();
    } finally {
      await qrController?.resumeCamera();
    }
  }

  Future<bool> _ensureVendorsLoaded() async {
    if (_vendors.isNotEmpty) return true;
    await _prefetchVendors();
    return _vendors.isNotEmpty;
  }

  VendorProfile? _findVendorById(int vendorId) {
    for (final v in _vendors) {
      if (v.vendorId == vendorId) return v;
    }
    return null;
  }

  VendorProfile? _findVendorByEmail(String email) {
    final needle = email.trim().toLowerCase();
    for (final v in _vendors) {
      if ((v.vendorEmail).trim().toLowerCase() == needle) return v;
    }
    return null;
  }

  /// Robust finder:
  /// 1) try cached by id
  /// 2) if not found -> ensure cache (fetch once)
  /// 3) try id again, else email
  Future<VendorProfile?> _getVendorForDeal({required int vendorId, required String email}) async {
    var vendor = _findVendorById(vendorId);
    if (vendor != null) return vendor;

    await _ensureVendorsLoaded();

    vendor = _findVendorById(vendorId);
    if (vendor != null) return vendor;

    // Graceful fallback: email match
    vendor = _findVendorByEmail(email);
    return vendor;
  }

  int? _extractDealId(String code) {
    final reg = RegExp(r'/vendors/all-deals/(\d+)/?$');
    final match = reg.firstMatch(code);
    if (match != null) return int.tryParse(match.group(1)!);
    return int.tryParse(code);
  }

  Future<void> _showSuccess({
    required String dealTitle,
    required String vendorName,
    required String brandLogoUrl,
    required String time,
  }) async {
    await Get.dialog(
      QRSuccessView(
        dealTitle: dealTitle,
        vendorName: vendorName,
        brandLogoUrl: brandLogoUrl,
        time: time,
      ),
      barrierDismissible: true,
    );
  }

  Future<void> _showFail() async {
    await Get.dialog(const QRFailView(), barrierDismissible: true);
  }

  Future<void> toggleTorch() async {
    if (qrController == null) return;
    await qrController!.toggleFlash();
    final flashStatus = await qrController!.getFlashStatus();
    isTorchOn.value = flashStatus ?? false;
  }

  Future<void> flipCamera() async => qrController?.flipCamera();

  @override
  void onClose() {
    qrController?.dispose();
    super.onClose();
  }
}
