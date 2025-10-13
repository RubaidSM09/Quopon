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

  // NEW: UI state for send-push
  final isSending = false.obs;
  final pushSentCount = 0.obs; // bound to KPI

  // Call this in initState with the current deal's push count
  void initWithDealPushCount(int initial) {
    pushSentCount.value = initial;
  }

  Future<void> sendPush(int dealId, {required String dealName}) async {
    if (isSending.value) return;
    isSending.value = true;
    try {
      final headers = await BaseClient.authHeaders();
      headers['Content-Type'] = 'application/json';

      final uri = Uri.parse(
        'https://doctorless-stopperless-turner.ngrok-free.dev/vendors/$dealId/send-notification/',
      );

      // ✅ REQUIRED BODY
      final payload = {
        "title": "New Deals in town",
        "body": dealName.isEmpty ? "New Deal" : dealName, // $deal_name
      };

      final res = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(payload),
      );

      if (res.statusCode >= 200 && res.statusCode < 300) {
        int? serverTotal;
        try {
          final decoded = json.decode(res.body);
          serverTotal = int.tryParse('${decoded['push_sent_count'] ?? decoded['total_push_sent'] ?? ''}');
          print(serverTotal);
        } catch (_) {}
        if (serverTotal != null) {
          pushSentCount.value = serverTotal;
        } else {
          pushSentCount.value = pushSentCount.value + 1;
        }
        Get.snackbar('Success', 'Push notification sent.');
      } else {
        Get.snackbar('Failed', 'Send push failed (${res.statusCode}).');
      }
    } catch (e) {
      Get.snackbar('Error', 'Send push error: $e');
    } finally {
      isSending.value = false;
    }
  }

  /// ---- metrics code unchanged below ----

  Future<void> fetchLast7Days(int dealId) async {
    isLoading.value = true;
    error.value = null;
    try {
      final headers = await BaseClient.authHeaders();
      final uri = Uri.parse(
        'https://doctorless-stopperless-turner.ngrok-free.dev/vendors/deals/$dealId/daily-metrics/?days=7',
      );
      final res = await http.get(uri, headers: headers);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        final decoded = json.decode(res.body);
        final List days = (decoded['days'] as List?) ?? [];
        final today = DateTime.now().toLocal();
        final Map<String, Map<String, dynamic>> byDate = {
          for (final e in days)
            (e['date'] ?? '').toString(): (e as Map<String, dynamic>)
        };
        final List<DayMetric> out = [];
        for (int i = 6; i >= 0; i--) {
          final d = DateTime(today.year, today.month, today.day).subtract(Duration(days: i));
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
    final out = List<DayMetric>.generate(7, (i) {
      final d = DateTime(today.year, today.month, today.day).subtract(Duration(days: 6 - i));
      return DayMetric(d, 0, 0);
    });
    metrics.assignAll(out);
  }

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
