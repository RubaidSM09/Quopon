// lib/app/modules/vendor_deal_performance/controllers/vendor_deal_performance_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:quopon/app/data/base_client.dart';

class DayMetric {
  final DateTime day; // date only
  final int views;
  final int redemptions;
  DayMetric(this.day, this.views, this.redemptions);
}

class VendorDealPerformanceController extends GetxController {
  final isLoading = false.obs;
  final error = RxnString();
  final metrics = <DayMetric>[].obs;

  // Backend hasn't added this yet; keep placeholder
  final pushSent = 0.obs;

  /// Call this right after page opens, passing the deal id.
  Future<void> fetchLast7Days(int dealId) async {
    isLoading.value = true;
    error.value = null;

    try {
      final headers = await BaseClient.authHeaders();

      // TODO: switch to your real endpoint when ready.
      // Expected response example:
      // {
      //   "days": [
      //     {"date":"2025-10-01","views":100,"redemptions":20},
      //     ...
      //   ]
      // }
      final uri = Uri.parse(
        'https://intensely-optimal-unicorn.ngrok-free.app/vendors/deals/$dealId/daily-metrics/?days=7',
      );

      final res = await http.get(uri, headers: headers);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        final decoded = json.decode(res.body);
        final List days = (decoded['days'] as List?) ?? [];

        // Normalize to exactly 7 entries: today and the previous 6 days
        final today = DateTime.now().toLocal();
        final Map<String, Map<String, dynamic>> byDate = {
          for (final e in days)
            (e['date'] ?? '').toString(): (e as Map<String, dynamic>)
        };

        final List<DayMetric> out = [];
        for (int i = 6; i >= 0; i--) {
          final d = DateTime(today.year, today.month, today.day)
              .subtract(Duration(days: i));
          final key = DateFormat('yyyy-MM-dd').format(d);
          final row = byDate[key];

          out.add(DayMetric(
            d,
            int.tryParse((row?['views'] ?? 0).toString()) ?? 0,
            int.tryParse((row?['redemptions'] ?? 0).toString()) ?? 0,
          ));
        }

        metrics.assignAll(out);
      } else {
        _fallbackZeros();
        error.value = 'Metrics API ${res.statusCode}';
      }
    } catch (e) {
      _fallbackZeros();
      error.value = 'Metrics error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void _fallbackZeros() {
    final today = DateTime.now().toLocal();
    final out = List<DayMetric>.generate(
      7,
          (i) {
        final d = DateTime(today.year, today.month, today.day)
            .subtract(Duration(days: 6 - i));
        return DayMetric(d, 0, 0);
      },
    );
    metrics.assignAll(out);
  }

  // ---- Formatting helpers ----
  String formatMmmD(DateTime day) => DateFormat('MMM d').format(day);

  String formatDdMmmY(String? iso) {
    if (iso == null) return '—';
    final dt = DateTime.tryParse(iso)?.toLocal();
    if (dt == null) return '—';
    return DateFormat('dd MMM yyyy').format(dt);
  }

  String timeLeftFromNow(String? endIso) {
    if (endIso == null) return '—';
    final endUtc = DateTime.tryParse(endIso);
    if (endUtc == null) return '—';
    final end = endUtc.toLocal();
    final now = DateTime.now().toLocal();
    if (now.isAfter(end)) return 'Expired';

    final diff = end.difference(now);
    final days = diff.inDays;
    final hours = diff.inHours % 24;
    final mins = diff.inMinutes % 60;

    if (days > 0) return '${days}d ${hours}h';
    if (hours > 0) return '${hours}h ${mins}m';
    return '${mins}m';
  }
}
