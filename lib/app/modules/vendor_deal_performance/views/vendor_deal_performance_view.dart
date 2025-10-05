// lib/app/modules/vendor_deal_performance/views/vendor_deal_performance_view.dart
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../common/customTextButton.dart';
import '../../vendor_deal_performance/controllers/vendor_deal_performance_controller.dart';
import '../../vendor_deals/controllers/vendor_deals_controller.dart'; // for DealItem model import if placed there

class VendorDealPerformanceView extends StatefulWidget {
  final DealItem deal; // <-- pass the selected deal

  const VendorDealPerformanceView({super.key, required this.deal});

  @override
  State<VendorDealPerformanceView> createState() =>
      _VendorDealPerformanceViewState();
}

class _VendorDealPerformanceViewState extends State<VendorDealPerformanceView> {
  final controller = Get.put(VendorDealPerformanceController());

  @override
  void initState() {
    super.initState();
    controller.fetchLast7Days(widget.deal.id ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    final deal = widget.deal;

    final validRange =
        '${controller.formatDdMmmY(deal.startDate)} - ${controller.formatDdMmmY(deal.endDate)}';
    final timeLeft = controller.timeLeftFromNow(deal.endDate);
    final isDealActiveNow = timeLeft != 'Expired' && (deal.isActive ?? false);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFC),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 16.h),
          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(onTap: Get.back, child: const Icon(Icons.arrow_back)),
                  Text(
                    'Deal Performance',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                      color: const Color(0xFF020711),
                    ),
                  ),
                  const SizedBox.shrink(),
                ],
              ),

              SizedBox(height: 20.h),

              // Hero card (image, title, Active badge, validity)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black.withAlpha(13), blurRadius: 16)],
                ),
                padding: EdgeInsets.all(12.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: AspectRatio(
                        aspectRatio: 16/9,
                        child: Image.network(
                          deal.imageUrl ?? '',
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: const Color(0xFFEFF2F5),
                            child: const Center(child: Icon(Icons.image_not_supported_outlined)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            deal.title ?? 'Untitled Deal',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              color: const Color(0xFF020711),
                            ),
                          ),
                        ),
                        Container(
                          height: 26.h,
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.r),
                            color: isDealActiveNow
                                ? const Color(0xFFECFDF5)
                                : const Color(0xFFFFF2F2),
                          ),
                          child: Center(
                            child: Text(
                              isDealActiveNow ? 'Active' : 'Inactive',
                              style: TextStyle(
                                color: isDealActiveNow
                                    ? const Color(0xFF2ECC71)
                                    : const Color(0xFFD62828),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.event_available, size: 16),
                        SizedBox(width: 5.w),
                        Text(
                          validRange,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: const Color(0xFF6F7E8D),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // KPI tiles (now bound to real counts + computed time left + placeholder push)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black.withAlpha(13), blurRadius: 16)],
                ),
                padding: EdgeInsets.all(12.r),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _KpiTile(
                          bg: const Color(0xFFEFF6FF),
                          border: const Color(0xFFE2ECFD),
                          value: NumberFormat.decimalPattern().format(deal.viewCount),
                          label: 'Total Views',
                          valueColor: const Color(0xFF1D4ED8),
                        ),
                        _KpiTile(
                          bg: const Color(0xFFFAF5FF),
                          border: const Color(0xFFF3E8FC),
                          value: NumberFormat.decimalPattern().format(deal.activationCount),
                          label: 'Activations',
                          valueColor: const Color(0xFF7E22CE),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _KpiTile(
                          bg: const Color(0xFFF0FDF4),
                          border: const Color(0xFFE3F5E9),
                          value: NumberFormat.decimalPattern().format(deal.redemptionCount),
                          label: 'Redemptions',
                          valueColor: const Color(0xFF10B981),
                        ),
                        _KpiTile(
                          bg: const Color(0xFFFFFBEB),
                          border: const Color(0xFFFAF1DD),
                          value: timeLeft,
                          label: 'Time Left',
                          valueColor: const Color(0xFFB45309),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Obx(() => _KpiTile(
                      bg: const Color(0xFFEEF2FF),
                      border: const Color(0xFFE4E7FC),
                      value: controller.pushSent.value == 0
                          ? '—'
                          : NumberFormat.decimalPattern()
                          .format(controller.pushSent.value),
                      label: 'Push Sent',
                      valueColor: const Color(0xFF4338CA),
                      isWide: true,
                    )),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // 7-day chart (Views vs Redemptions)
              Obx(() {
                final m = controller.metrics;
                if (controller.isLoading.value && m.isEmpty) {
                  return Container(
                    height: 276.h,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  );
                }

                // Build spots
                final viewsSpots = <FlSpot>[];
                final redSpots = <FlSpot>[];
                double maxY = 0;

                for (int i = 0; i < m.length; i++) {
                  final v = m[i].views.toDouble();
                  final r = m[i].redemptions.toDouble();
                  viewsSpots.add(FlSpot(i.toDouble(), v));
                  redSpots.add(FlSpot(i.toDouble(), r));
                  maxY = [maxY, v, r].reduce((a, b) => a > b ? a : b);
                }
                // add a small headroom
                maxY = (maxY * 1.15).ceilToDouble();

                return Container(
                  width: 398.w,
                  height: 276.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black.withAlpha(13), blurRadius: 16)],
                  ),
                  padding: EdgeInsets.all(12.r),
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: true),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          axisNameSize: 16.sp,
                          sideTitles: SideTitles(showTitles: true, reservedSize: 38),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          axisNameSize: 16.sp,
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              final i = value.toInt();
                              if (i < 0 || i >= m.length) return const SizedBox.shrink();
                              return Text(controller.formatMmmD(m[i].day)); // e.g., "May 7"
                            },
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: true),
                      minX: 0,
                      maxX: (m.length - 1).toDouble().clamp(0, 6),
                      minY: 0,
                      maxY: maxY == 0 ? 10 : maxY,
                      lineBarsData: [
                        LineChartBarData(
                          spots: viewsSpots,
                          isCurved: true,
                          barWidth: 4,
                          // keep colors consistent with your palette; shaded area on
                          belowBarData: BarAreaData(show: true),
                        ),
                        LineChartBarData(
                          spots: redSpots,
                          isCurved: true,
                          barWidth: 4,
                          belowBarData: BarAreaData(show: true),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),

      // Bottom actions (unchanged—wire as needed)
      bottomNavigationBar: Container(
        height: 170.h,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GradientButton(
                onPressed: () {},
                text: "Edit Deal",
                colors: const [Color(0xFFF4F5F6), Color(0xFFEEF0F3)],
                borderRadius: 12.r,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/DealPerformance/Edit.png'),
                    SizedBox(width: 10.w),
                    Text(
                      "Edit Deal",
                      style: TextStyle(
                        fontSize: 17.5.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF020711),
                      ),
                    ),
                  ],
                ),
              ),
              GradientButton(
                onPressed: () {},
                text: "Send Push Notification",
                colors: const [Color(0xFFD62828), Color(0xFFC21414)],
                borderRadius: 12.r,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/DealPerformance/Send.png'),
                    SizedBox(width: 10.w),
                    Text(
                      "Send Push Notification",
                      style: TextStyle(
                        fontSize: 17.5.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------- Small widget for KPI tiles ----------
class _KpiTile extends StatelessWidget {
  final Color bg;
  final Color border;
  final String value;
  final String label;
  final Color valueColor;
  final bool isWide;

  const _KpiTile({
    super.key,
    required this.bg,
    required this.border,
    required this.value,
    required this.label,
    required this.valueColor,
    this.isWide = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: bg,
        border: Border.all(color: border),
      ),
      child: SizedBox(
        width: isWide ? 350.w : 159.w,
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Text(
              value,
              style: TextStyle(color: valueColor, fontSize: 16.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 10.h),
            Text(
              label,
              style: TextStyle(color: valueColor, fontSize: 12.sp, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
