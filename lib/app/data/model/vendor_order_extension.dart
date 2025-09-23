import 'package:quopon/app/data/model/vendor_order.dart';

extension VendorOrderChecks on VendorOrder {
  /// Valid only when OUT_FOR_DELIVERY or READY_FOR_PICKUP
  bool get isEligibleForVendorVerification =>
      status == 'OUT_FOR_DELIVERY' || status == 'READY_FOR_PICKUP';

  /// Accept match with deliveryCode, qrCode.data, or (optionally) orderId
  bool matchesCode(String raw) {
    final code = raw.trim();
    if (code.isEmpty) return false;
    if (deliveryCode == code) return true;
    if (qrCode?.data == code) return true;
    if (orderId == code) return true; // keep if your QR encodes order_id
    return false;
  }
}