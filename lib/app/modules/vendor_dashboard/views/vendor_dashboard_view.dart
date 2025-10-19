import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:quopon/app/modules/vendor_create_deal/views/vendor_create_deal_view.dart';
import 'package:quopon/app/modules/vendor_dashboard/views/dashboard_order_card_view.dart';
import '../controllers/vendor_dashboard_controller.dart';
import 'dashboard_view.dart';

class VendorDashboardView extends GetView<VendorDashboardController> {
  const VendorDashboardView({super.key});

  DateTime _parseDate(String? iso) {
    if (iso == null) return DateTime.fromMillisecondsSinceEpoch(0);
    return DateTime.tryParse(iso) ?? DateTime.fromMillisecondsSinceEpoch(0);
  }

  String _formatDate(DateTime dt) {
    // Example target: "03 Aug 2025, 5:49 PM"
    return DateFormat('dd MMM yyyy, h:mm a').format(dt);
  }

  bool _isNew(DateTime createdAt) {
    return DateTime.now().difference(createdAt) <= const Duration(hours: 24);
  }

  double _toDouble(String? s) {
    if (s == null) return 0;
    return double.tryParse(s) ?? 0;
  }

  String _capitalize(String? s) {
    if (s == null || s.isEmpty) return '';
    return s[0].toUpperCase() + s.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    // If the controller isn't already in a binding, ensure it's available.
    Get.put(VendorDashboardController());

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFC),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await controller.fetchOrders();
            await controller.fetchDeals();
            await controller.fetchVendorProfile();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 16.h),
              child: Column(
                children: [
                  // Header
                  Obx(() {
                    final vp = controller.vendorProfile.value;

                    // Greeting by current local time
                    String greeting() {
                      final h = DateTime.now().hour; // device local time
                      if (h < 12) return 'Good Morning!';
                      if (h < 17) return 'Good Afternoon!';
                      return 'Good Evening!';
                    }

                    // name + logo fallback
                    final displayName = (vp?.name?.isNotEmpty == true) ? vp!.name : 'Vendor';
                    final logoUrl = vp?.logoImage ?? '';

                    Widget avatar;
                    if (logoUrl.startsWith('http')) {
                      avatar = CircleAvatar(radius: 20.r, backgroundImage: NetworkImage(logoUrl));
                    } else {
                      avatar = CircleAvatar(
                        radius: 20.r,
                        backgroundImage: const AssetImage('assets/images/Vendor/Dashboard/placeholder_vendor.png'),
                      );
                    }

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            avatar,
                            SizedBox(width: 10.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hi, ${greeting()}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                    color: const Color(0xFF020711),
                                  ),
                                ),
                                Text(
                                  displayName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                    color: const Color(0xFF6F7E8D),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16)],
                              ),
                              child: GestureDetector(
                                onTap: () => Get.to(() => VendorCreateDealView()),
                                child: const Icon(Icons.add),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Container(
                              padding: EdgeInsets.all(8.r),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16)],
                              ),
                              child: Image.asset('assets/images/Home/Notification.png'),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),

                  SizedBox(height: 15.h),

                  // Title
                  Row(
                    children: [
                      Text(
                        'Dashboard',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                          color: const Color(0xFF020711),
                        ),
                      ),
                      const SizedBox.shrink(),
                    ],
                  ),



                  SizedBox(height: 5.h),

                  Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          DashboardView(
                            title: 'Total Deals Published',
                            count: controller.totalDeals.value,
                            isImproved: true,
                            change: 12.8,
                          ),
                          SizedBox(height: 10.h),
                          DashboardView(
                            title: 'Redemption Rate (%)',
                            count: controller.redemptionRate.value,
                            isRate: true,
                            isImproved: false,
                            change: 12.8,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          DashboardView(
                            title: 'Total Redemptions',
                            count: controller.totalRedemptions.value,
                            isImproved: false,
                            change: 12.8,
                          ),
                          SizedBox(height: 10.h),
                          DashboardView(
                            title: 'Pushes Sent',
                            count: controller.pushesSent.value,
                            isImproved: true,
                            change: 12.8,
                          ),
                        ],
                      ),
                    ],
                  )),

                  SizedBox(height: 20.h),

                  // Latest Orders (dynamic)
                  Row(
                    children: [
                      Text(
                        'Latest Orders',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                          color: const Color(0xFF020711),
                        ),
                      ),
                      const SizedBox.shrink(),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  Obx(() {
                    // Copy & sort orders by createdAt DESC
                    final sorted = [...controller.orders];
                    sorted.sort((a, b) =>
                        _parseDate(b.createdAt).compareTo(_parseDate(a.createdAt)));

                    if (sorted.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.h),
                        child: Center(
                          child: Text(
                            'No orders yet',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color(0xFF6F7E8D),
                            ),
                          ),
                        ),
                      );
                    }

                    // Build list of cards
                    return Column(
                      children: List.generate(sorted.length, (index) {
                        final o = sorted[index];
                        final created = _parseDate(o.createdAt);
                        final isNew = _isNew(created);

                        // Safely pick first item for display
                        final firstItem = (o.items.isNotEmpty) ? o.items.first : null;
                        final itemName = firstItem?.itemName ?? 'Item';
                        final itemImg = firstItem?.itemImage;
                        final displayImage = (itemImg != null && itemImg.isNotEmpty)
                            ? itemImg
                            : 'assets/images/Cart/Italian Panini.png';

                        // Sum quantities
                        final totalQty = o.items.fold<int>(0, (sum, e) => sum + (e.quantity));

                        return Padding(
                          padding: EdgeInsets.only(bottom: 7.5.h),
                          child: DashboardOrderCardView(
                            itemImg: displayImage,
                            itemName: itemName,
                            // If your card requires this, send empty map when addons not available
                            itemAddons: const <String, List<String>>{},
                            isNew: isNew,
                            status: _capitalize(o.deliveryType),
                            customerName: 'Customer #${o.user}',
                            orderItem: itemName,
                            quantity: totalQty == 0 ? 1 : totalQty,
                            totalAmount: _toDouble(o.totalAmount),
                            orderTime: _formatDate(created),
                            orderStatus: o.status,
                            orderId: o.orderId,
                          ),
                        );
                      }),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}