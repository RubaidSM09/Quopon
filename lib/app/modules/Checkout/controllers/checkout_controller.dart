// lib/app/modules/Checkout/controllers/checkout_controller.dart
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:quopon/app/modules/landing/views/landing_view.dart';

import '../../../data/base_client.dart';
import '../../../data/model/vendor_profile_lite.dart';
import '../../OrderDetails/views/order_details_view.dart';
import '../views/checkout_web_view.dart';
import 'package:collection/collection.dart';

class CheckoutController extends GetxController {
  // ----- inbound from CheckoutView -----
  late final double baseSubTotal;
  late final double baseDelivery;
  late final int vendorId;

  // call this from CheckoutView.onInit
  void setBaseInputs({required double subTotal, required double delivery, required int vendorId}) {
    baseSubTotal = subTotal;
    baseDelivery = delivery;
    this.vendorId = vendorId;
  }

  // UI state
  final selectedPaymentMethod = "".obs;
  final selectedPaymentMethodLogo = "".obs;

  // Profile (tier, phone, address)
  final isPremium = false.obs;
  final phoneNumber = ''.obs;
  final profileAddress = ''.obs; // server-saved address (also editable)
  SubscriptionTier get tier => isPremium.value ? SubscriptionTier.premium : SubscriptionTier.free;

  // Current location & derived address
  final Rxn<Position> currentPos = Rxn<Position>();
  final currentAddress = ''.obs;

  // Vendor
  final Rxn<VendorProfileLite> vendorProfile = Rxn<VendorProfileLite>();

  // Distance/ETA/Fee
  final distanceKm = 0.0.obs;
  final etaMinutes = 0.obs;
  final estimatedDeliveryFee = 0.0.obs;

  // Scheduling
  final RxBool isScheduled = false.obs;
  final Rxn<DateTime> scheduledAt = Rxn<DateTime>();

  // Deals
  final deals = <DealLite>[].obs;            // for this vendor
  final Rxn<DealLite> selectedDeal = Rxn<DealLite>();
  final isApplyingDeal = false.obs;

  // Totals (start with base, then overridden by calculation API)
  final subTotal = 0.0.obs;
  final deliveryFee = 0.0.obs;
  final discountAmount = 0.0.obs;
  final finalTotal = 0.0.obs;

  // Shared note
  final noteController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    subTotal.value = 0;
    deliveryFee.value = 0;
    finalTotal.value = 0;

    _initProfileAndLocation();

    // 🔁 Whenever either currentPos or vendorProfile changes, recompute ETA/distance
    everAll([currentPos, vendorProfile], (_) async {
      if (currentPos.value != null && vendorProfile.value != null) {
        await _computeDistanceEtaAndFee();
      }
    });
  }

  // ------------------ Initialization ------------------

  Future<void> _initProfileAndLocation() async {
    await _fetchProfile();           // sets tier, phone, saved address
    await _getCurrentLocation();     // sets currentPos + currentAddress
  }

  Future<void> hydrateForVendor(int vendorId) async {
    // Make sure we have a location first (in case onInit is still fetching)
    if (currentPos.value == null) {
      await _getCurrentLocation();
    }

    await _fetchVendorProfile(vendorId);
    // No need to call _computeDistanceEtaAndFee() here explicitly;
    // the everAll watcher above will run it once both are ready.

    if (subTotal.value == 0 && finalTotal.value == 0) {
      subTotal.value = baseSubTotal;
      deliveryFee.value = baseDelivery;
      discountAmount.value = 0;
      finalTotal.value = baseSubTotal + baseDelivery;
    }

    // Also fetch deals (filtered below by tier)
    await _fetchDealsForVendor(vendorId);
  }

  // ------------------ Profile ------------------

  Future<void> _fetchProfile() async {
    try {
      final headers = await BaseClient.authHeaders();
      headers['ngrok-skip-browser-warning'] = 'true';
      final res = await http.get(
        Uri.parse("https://doctorless-stopperless-turner.ngrok-free.dev/food/my-profile/"),
        headers: headers,
      );
      if (res.statusCode == 200) {
        final j = json.decode(res.body);
        final status = (j['subscription_status'] ?? '').toString().toLowerCase();
        isPremium.value = status == 'active';
        phoneNumber.value = (j['phone_number'] ?? '').toString();
        profileAddress.value = (j['address'] ?? '').toString();
      }
    } catch (_) {}
  }

  // ------------------ Location helpers ------------------

  Future<void> _getCurrentLocation() async {
    try {
      final perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied) {
        final p2 = await Geolocator.requestPermission();
        if (p2 == LocationPermission.denied || p2 == LocationPermission.deniedForever) return;
      }
      final pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      currentPos.value = pos;

      // reverse geocode
      final placemarks = await geocoding.placemarkFromCoordinates(pos.latitude, pos.longitude);
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        currentAddress.value = [
          p.street, p.subLocality, p.locality, p.administrativeArea, p.postalCode, p.country
        ].where((e) => (e ?? '').toString().trim().isNotEmpty).join(', ');
      }
    } catch (_) {}
  }

  // ------------------ Vendor lookups ------------------

  Future<void> _fetchVendorProfile(int vendorId) async {
    try {
      final headers = await BaseClient.authHeaders();
      headers['ngrok-skip-browser-warning'] = 'true';
      final res = await http.get(
        Uri.parse("https://doctorless-stopperless-turner.ngrok-free.dev/vendors/all-business-profile/"),
        headers: headers,
      );
      if (res.statusCode == 200) {
        final List list = jsonDecode(res.body);
        final found = list.cast<Map<String, dynamic>>()
            .map(VendorProfileLite.fromJson)
            .firstWhereOrNull((e) => e.vendorId == vendorId);
        vendorProfile.value = found;
      }
    } catch (_) {}
  }

  // ------------------ Distance / ETA / Fee ------------------

  Future<void> _computeDistanceEtaAndFee() async {
    final vp = vendorProfile.value;
    final pos = currentPos.value;
    if (vp == null || pos == null) return;

    try {
      // Try geocoding vendor address
      final results = await geocoding.locationFromAddress(vp.address);
      if (results.isEmpty) throw Exception('Geocode failed');

      final vend = results.first;
      final d = _haversineKm(
        pos.latitude, pos.longitude, vend.latitude, vend.longitude,
      );
      distanceKm.value = d;

      // ~3 min per km, clamp 10–90 min
      final eta = (d * 3).clamp(10, 90).round();
      etaMinutes.value = eta;

      // Example fee rule
      final fee = max(49.0, 49.0 + 12.0 * d);
      estimatedDeliveryFee.value = double.parse(fee.toStringAsFixed(2));
    } catch (_) {
      // ✅ Fallbacks so UI never shows "Calculating..." forever
      if (distanceKm.value <= 0) distanceKm.value = 2.0;   // assume ~2 km
      if (etaMinutes.value <= 0) etaMinutes.value = 15;    // assume ~15 min
      if (estimatedDeliveryFee.value <= 0) {
        final fee = max(49.0, 49.0 + 12.0 * distanceKm.value);
        estimatedDeliveryFee.value = double.parse(fee.toStringAsFixed(2));
      }
    }
  }

  double _haversineKm(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371.0; // km
    final dLat = _deg2rad(lat2 - lat1);
    final dLon = _deg2rad(lon2 - lon1);
    final a = sin(dLat/2)*sin(dLat/2) +
        cos(_deg2rad(lat1))*cos(_deg2rad(lat2))*sin(dLon/2)*sin(dLon/2);
    final c = 2 * atan2(sqrt(a), sqrt(1-a));
    return R * c;
  }
  double _deg2rad(double d) => d * pi / 180.0;

  // ------------------ Deals ------------------

  Future<void> _fetchDealsForVendor(int vendorId) async {
    try {
      final headers = await BaseClient.authHeaders();
      headers['ngrok-skip-browser-warning'] = 'true';
      final res = await http.get(
        Uri.parse("https://doctorless-stopperless-turner.ngrok-free.dev/vendors/all-vendor-deals/"),
        headers: headers,
      );
      if (res.statusCode == 200) {
        final List raw = jsonDecode(res.body);

        final now = DateTime.now().toLocal();

        // Vendor + active + not expired
        final base = raw
            .cast<Map<String, dynamic>>()
            .map(DealLite.fromJson)
            .where((d) => d.userId == vendorId && d.isActive)
            .where((d) {
          if (d.endDate == null || d.endDate!.isEmpty) return false;
          final parsed = DateTime.tryParse(d.endDate!);
          if (parsed == null) return false;
          final endLocal = parsed.toLocal();
          return endLocal.isAfter(now); // only not-expired
        });

        // Subscription gating
        final filteredByTier = base.where((d) {
          final t = (d.dealType ?? '').toLowerCase();
          if (isPremium.value) return true;
          return t.isEmpty || t == 'free' || t == 'both';
        }).toList();

        deals.assignAll(filteredByTier);
      }
    } catch (_) {}
  }

  // show dialog & let user pick a deal
  Future<void> showDealPickerDialog() async {
    if (deals.isEmpty) {
      Get.snackbar('Deals', 'No active deals found for this vendor.');
      return;
    }
    await Get.dialog(
      Dialog(
        insetPadding: const EdgeInsets.all(16),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 520),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const Text('Choose a Deal', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Expanded(
                  child: Obx(() {
                    return ListView.separated(
                      itemCount: deals.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (_, i) {
                        final d = deals[i];
                        final discountText = tier == SubscriptionTier.premium
                            ? (d.discountPaid ?? d.discountFree ?? '-')
                            : (d.discountFree ?? d.discountPaid ?? '-');

                        return ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(d.imageUrl, width: 56, height: 56, fit: BoxFit.cover),
                          ),
                          title: Text(d.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                          subtitle: Text('Discount: $discountText'),
                          trailing: ElevatedButton(
                            onPressed: () async {
                              await applyDeal(d);
                              if (Get.isDialogOpen ?? false) Get.back();
                            },
                            child: const Text('Use Deal'),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  Future<void> applyDeal(DealLite deal) async {
    if (isApplyingDeal.value) return;
    isApplyingDeal.value = true;
    try {
      final headers = await BaseClient.authHeaders();
      headers['ngrok-skip-browser-warning'] = 'true';
      headers['Content-Type'] = 'application/json';

      final res = await http.post(
        Uri.parse("https://doctorless-stopperless-turner.ngrok-free.dev/order/cart/checkout/calculate/"),
        headers: headers,
        body: jsonEncode({"deal_id": deal.id}),
      );

      if (res.statusCode >= 200 && res.statusCode < 300) {
        final j = jsonDecode(res.body) as Map<String, dynamic>;
        subTotal.value      = _toDouble(j['subtotal']);
        deliveryFee.value   = _toDouble(j['delivery_fee']);
        discountAmount.value= _toDouble(j['discount_amount']);
        finalTotal.value    = _toDouble(j['final_total']);
        selectedDeal.value  = deal;
        Get.snackbar('Deal Applied', 'Updated totals with "${deal.title}"');
      } else {
        Get.snackbar('Deal', 'Failed to apply deal (${res.statusCode})');
      }
    } catch (e) {
      Get.snackbar('Deal', 'Error applying deal: $e');
    } finally {
      isApplyingDeal.value = false;
    }
  }

  double _toDouble(dynamic v) {
    if (v == null) return 0.0;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0.0;
  }

  // ------------------ Edit dialogs ------------------

  Future<void> editTextDialog({
    required String title,
    required String initial,
    required void Function(String) onSave,
    TextInputType inputType = TextInputType.text,
  }) async {
    final ctrl = TextEditingController(text: initial);
    await Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            TextField(controller: ctrl, keyboardType: inputType),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: Get.back, child: const Text('Cancel')),
                ElevatedButton(
                  onPressed: () {
                    onSave(ctrl.text.trim());
                    Get.back();
                  },
                  child: const Text('Save'),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }

  Future<void> pickSchedule() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: Get.context!,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 14)),
    );
    if (date == null) return;
    final time = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.fromDateTime(now.add(const Duration(minutes: 45))),
    );
    if (time == null) return;
    final dt = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    scheduledAt.value = dt;
    isScheduled.value = true;
  }

  // ------------------ Place order + Payment ------------------

  void updatePaymentMethod(String method, String logo) {
    selectedPaymentMethod.value = method;
    selectedPaymentMethodLogo.value = logo;
  }

  Future<void> placeOrderAndPay({
    required bool isDelivery,
    required String note,
  }) async {
    try {
      final headers = await BaseClient.authHeaders();
      headers['ngrok-skip-browser-warning'] = 'true';
      headers['Content-Type'] = 'application/json';

      final String addr = isDelivery
          ? (currentAddress.value.isNotEmpty ? currentAddress.value : profileAddress.value)
          : (vendorProfile.value?.address ?? 'N/A');

      final String finalNote =
      (noteController.text.isNotEmpty ? noteController.text : (note.isEmpty ? "No notes" : note));

      final Map<String, dynamic> body = {
        "delivery_type": isDelivery ? "DELIVERY" : "PICKUP",
        "delivery_address": addr,
        "order_type": isScheduled.value ? "SCHEDULED" : "STANDARD",
        "note": finalNote,
        // (optional) tell backend which method we chose
        "payment_method": selectedPaymentMethod.value == 'Online Mollie Payment' ? "MOLLIE" : "CASH",
      };

      if (isScheduled.value && scheduledAt.value != null) {
        body["scheduled_time"] = scheduledAt.value!.toIso8601String();
      }
      if (selectedDeal.value != null) {
        body["deal_id"] = selectedDeal.value!.id;
      }

      final orderRes = await http.post(
        Uri.parse("https://doctorless-stopperless-turner.ngrok-free.dev/order/orders/create/"),
        headers: headers,
        body: json.encode(body),
      );

      if (orderRes.statusCode == 200 || orderRes.statusCode == 201) {
        final parsed = json.decode(orderRes.body) as Map<String, dynamic>;
        final orderId = parsed['order_id']?.toString();
        if (orderId == null || orderId.isEmpty) {
          Get.snackbar("Order Error", "Missing order_id in response");
          return;
        }

        // ✅ Branch by selected method
        final method = selectedPaymentMethod.value;
        final isMollie = method == 'Online Mollie Payment';

        if (isMollie) {
          // proceed with Mollie (webview)
          await _startPayment(orderId: orderId);
        } else {
          // Cash: no webview—just confirm & go to details
          Get.snackbar("Success", "Order placed successfully (Cash).");
          Get.offAll(() => LandingView());
          Get.to(() => const OrderDetailsView(), arguments: {"order_id": orderId});
        }

      } else {
        Get.snackbar("Order Failed", orderRes.body);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> _startPayment({required String orderId}) async {
    try {
      final headers = await BaseClient.authHeaders();
      headers['ngrok-skip-browser-warning'] = 'true';
      headers['Content-Type'] = 'application/json';

      final response = await http.post(
        Uri.parse("https://doctorless-stopperless-turner.ngrok-free.dev/order/orders/$orderId/process-payment/"),
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        final checkoutUrl = responseBody['checkout_url'];
        if (checkoutUrl != null && checkoutUrl.isNotEmpty) {
          Get.to(() => WebViewScreen(
            orderId: orderId,
            url: checkoutUrl,
            onUrlMatched: (bool isCancelled) {
              if (!isCancelled) {
                Get.snackbar("Success", "Order placed successfully!");
              } else {
                Get.snackbar("Cancelled", "Payment cancelled");
              }
              Get.offAll(() => const OrderDetailsView(),
                  arguments: {"order_id": orderId});
            },
          ));
        } else {
          Get.snackbar("Warning", "No checkout url received");
        }
      } else {
        Get.snackbar("Payment Failed", response.body);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
