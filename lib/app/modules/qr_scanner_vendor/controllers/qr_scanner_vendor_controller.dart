import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QrScannerVendorController extends GetxController {
  final List<TextEditingController> controllers = List.generate(6, (_) => TextEditingController());

  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  String get code =>
      controllers.map((controller) => controller.text).join();

  void onDigitEntered(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  Future<void> refreshAll() async {
    // For a keypad/OTP style scanner, “refresh” = clear and focus
    clearAll();
  }

  void clearAll() {
    for (var c in controllers) {
      c.clear();
    }
    focusNodes.first.requestFocus();
  }

  @override
  void onClose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.onClose();
  }
}
