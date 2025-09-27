// lib/app/modules/Notifications/controllers/notifications_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quopon/app/data/base_client.dart';
import 'package:quopon/app/data/model/app_notification.dart';
import 'package:quopon/app/modules/Notifications/views/deal_detail_by_id_dialog.dart';

class NotificationsController extends GetxController {
  final isLoading = false.obs;
  final notifications = <AppNotification>[].obs;

  Map<String, List<AppNotification>> get grouped {
    final Map<String, List<AppNotification>> m = {};
    final nowLocal = DateTime.now().toLocal();

    for (final n in notifications) {
      final createdLocal = n.createdAt.toLocal();
      final key = _bucket(nowLocal, createdLocal);
      m.putIfAbsent(key, () => []);
      m[key]!.add(n);
    }

    // newest → oldest inside each bucket
    m.forEach((_, list) => list.sort((a, b) => b.createdAt.compareTo(a.createdAt)));
    return m;
  }

  String _bucket(DateTime todayLocal, DateTime createdLocal) {
    final today = DateTime(todayLocal.year, todayLocal.month, todayLocal.day);
    final created = DateTime(createdLocal.year, createdLocal.month, createdLocal.day);
    if (created == today) return 'TODAY';
    if (created == today.subtract(const Duration(days: 1))) return 'YESTERDAY';
    return DateFormat('MMM d, yyyy').format(createdLocal);
  }

  Future<void> fetchNotifications() async {
    try {
      isLoading.value = true;
      final headers = await BaseClient.authHeaders();
      final res = await BaseClient.getRequest(
        api: 'https://intensely-optimal-unicorn.ngrok-free.app/notifications/list/',
        headers: headers,
      );

      if (res.statusCode >= 200 && res.statusCode <= 210) {
        final decoded = json.decode(res.body);
        notifications.assignAll(AppNotification.listFromJson(decoded));
      } else {
        final body = json.decode(res.body);
        Get.snackbar('Error', body['message'] ?? 'Failed to fetch notifications');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// POST: /notifications/mark-read/{notification_id}/
  Future<void> _markAsRead(int notificationId) async {
    // If already read, skip server call
    final idx = notifications.indexWhere((x) => x.id == notificationId);
    if (idx == -1) return;
    final current = notifications[idx];
    if (current.read) return;

    // Optimistic update
    final prev = current;
    notifications[idx] = current.copyWith(read: true);

    try {
      final headers = await BaseClient.authHeaders();
      final url = 'https://intensely-optimal-unicorn.ngrok-free.app/notifications/mark-read/$notificationId/';
      // If your BaseClient has postRequest:
      final res = await BaseClient.postRequest(api: url, headers: headers);
      // If you need a body, send {}. If your BaseClient requires body param, use body: {}
      if (res.statusCode < 200 || res.statusCode > 210) {
        // rollback if server fails
        notifications[idx] = prev;
        final body = json.decode(res.body);
        Get.snackbar('Error', body['message'] ?? 'Failed to mark as read');
      }
    } catch (e) {
      // rollback on error
      notifications[idx] = prev;
      Get.snackbar('Error', 'Failed to mark as read: $e');
    }
  }

  /// Tap handler — marks as read first, then opens deal dialog if promotion
  Future<void> onTapNotification(AppNotification n) async {
    await _markAsRead(n.id);

    final isPromotion = n.type.toLowerCase() == 'promotion' ||
        (n.data['type']?.toString().toLowerCase() == 'new_deal');

    if (!isPromotion) {
      // Non-promotion: nothing else to do (already marked read)
      return;
    }

    final idStr = (n.data['deal_id'] ?? '').toString();
    final dealId = int.tryParse(idStr);
    if (dealId == null) {
      Get.snackbar('Not available', 'No valid deal id found in this notification.');
      return;
    }

    Get.dialog(DealDetailByIdDialog(dealId: dealId), barrierDismissible: true);
  }

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }
}
