import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/base_client.dart';

class OrderDetailsController extends GetxController {
  // API data
  final order = Rxn<Map<String, dynamic>>();
  final isLoading = false.obs;
  final error = RxnString();

  // convenience getters
  String get orderId => order.value?["order_id"]?.toString() ?? "";
  String get status => order.value?["status"]?.toString() ?? "";
  String get paymentStatus => order.value?["payment_status"]?.toString() ?? "";
  String get deliveryTypeRaw => order.value?["delivery_type"]?.toString() ?? "";
  String get orderType => order.value?["order_type"]?.toString() ?? "";
  String get subtotal => order.value?["subtotal"]?.toString() ?? "0.00";
  String get deliveryFee => order.value?["delivery_fee"]?.toString() ?? "0.00";
  String get discountAmount => order.value?["discount_amount"]?.toString() ?? "0.00";
  String get totalAmount => order.value?["total_amount"]?.toString() ?? "0.00";
  String get deliveryAddress => order.value?["delivery_address"]?.toString() ?? "";
  String get createdAtIso => order.value?["created_at"]?.toString() ?? "";

  /// All items in the order (typed for convenience)
  List<Map<String, dynamic>> get items =>
      ((order.value?["items"] as List?) ?? const [])
          .whereType<Map<String, dynamic>>()
          .toList();

  // Pretty delivery type for UI (e.g., "DELIVERY" -> "Delivery")
  String get deliveryType {
    if (deliveryTypeRaw.isEmpty) return "";
    final lower = deliveryTypeRaw.toLowerCase();
    return lower[0].toUpperCase() + lower.substring(1);
  }

  // ---- Date/Time formatting (no intl) ----
  static const List<String> _monthNames = [
    "January","February","March","April","May","June",
    "July","August","September","October","November","December"
  ];

  /// e.g., "20 June, 2025"
  String get orderDate {
    final dt = _parseIso(createdAtIso);
    if (dt == null) return "—";
    final d = dt.day;
    final m = _monthNames[dt.month - 1];
    final y = dt.year;
    return "$d $m, $y";
  }

  /// e.g., "01: 09 AM"
  String get orderTime {
    final dt = _parseIso(createdAtIso);
    if (dt == null) return "—";
    int hour = dt.hour;
    final minute = dt.minute.toString().padLeft(2, '0');
    final ampm = hour >= 12 ? "PM" : "AM";
    hour = hour % 12;
    if (hour == 0) hour = 12;
    final hh = hour.toString().padLeft(2, '0');
    return "$hh: $minute $ampm";
  }

  DateTime? _parseIso(String iso) {
    if (iso.isEmpty) return null;
    try {
      return DateTime.parse(iso).toLocal();
    } catch (_) {
      return null;
    }
  }

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    print(args);
    final String? oid =
    (args is Map && args["order_id"] != null) ? args["order_id"].toString() : null;
    print(oid);

    if (oid == null || oid.isEmpty) {
      error.value = "Missing order_id";
      return;
    }

    fetchOrder(oid);
  }

  Future<void> fetchOrder(String orderId) async {
    isLoading.value = true;
    error.value = null;
    try {
      final headers = await BaseClient.authHeaders();
      headers['ngrok-skip-browser-warning'] = 'true';

      final res = await http.get(
        Uri.parse("https://doctorless-stopperless-turner.ngrok-free.dev/order/orders/$orderId/"),
        headers: headers,
      );

      if (res.statusCode == 200) {
        order.value = json.decode(res.body) as Map<String, dynamic>;
      } else {
        error.value = "Failed to fetch order (${res.statusCode})";
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
