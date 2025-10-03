import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quopon/app/data/repo/deals_repo.dart';
import 'package:quopon/app/modules/dealDetail/views/deal_detail_view.dart';

class DealDetailByIdDialog extends StatelessWidget {
  final int dealId;
  const DealDetailByIdDialog({super.key, required this.dealId});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 24.h),
      backgroundColor: Colors.transparent,
      child: FutureBuilder<Map<String, dynamic>>(
        future: DealsRepo.fetchDealRawById(dealId),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return _box(child: const Center(child: CircularProgressIndicator()));
          }
          if (snap.hasError) {
            return _box(child: _err('Failed to load deal #$dealId\n${snap.error}'));
          }
          final m = snap.data ?? {};

          // Map to your DealDetailView props
          final dealImage = (m['image_url'] ?? m['image'] ?? '') as String;
          final dealTitle = (m['title'] ?? m['offer_title'] ?? 'Deal') as String;
          final dealDescription = (m['description'] ?? '') as String;

          final rawValidity = (m['end_date'] ?? m['deal_validity']);
          final dealValidity = (rawValidity != null && rawValidity.toString().isNotEmpty)
              ? DateFormat('hh:mm a, MMM dd').format(DateTime.parse(rawValidity.toString()))
              : '—';

          final dealStoreName = (m['vendor_name'] ?? m['store_name'] ?? 'Store') as String;
          final brandLogo = (m['image_url'] ?? m['brand_logo'] ?? '') as String;
          final redemptionType = (m['redemption_type'] ?? 'Pickup') as String;
          final deliveryCost = (m['delivery_fee'] ?? '0').toString();
          final minOrder = int.tryParse((m['min_order'] ?? '0').toString()) ?? 0;

          return DealDetailView(
            dealImage: dealImage,
            dealTitle: dealTitle,
            dealDescription: dealDescription,
            dealValidity: dealValidity,
            dealStoreName: dealStoreName,
            brandLogo: brandLogo,
            redemptionType: redemptionType,
            deliveryCost: deliveryCost,
            minOrder: minOrder,
          );
        },
      ),
    );
  }

  Widget _box({required Widget child}) => Container(
    decoration: BoxDecoration(
      color: const Color(0xFFF9FBFC),
      borderRadius: BorderRadius.circular(16.r),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 4))],
    ),
    padding: EdgeInsets.all(16.w),
    child: child,
  );

  Widget _err(String msg) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Icon(Icons.error_outline, color: Colors.red),
      SizedBox(height: 8.h),
      Text(msg, textAlign: TextAlign.center),
      SizedBox(height: 12.h),
      TextButton(onPressed: () => Get.back(), child: const Text('Close')),
    ],
  );
}
