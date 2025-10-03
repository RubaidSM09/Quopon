import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../Notifications/controllers/notifications_controller.dart';
import '../../Notifications/views/notifications_card_view.dart';
import '../../Notifications/views/notifications_settings_view.dart';
import 'package:quopon/app/data/model/app_notification.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationsController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FBFC),
        title: Center(
          child: Text(
            'Notifications',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, color: const Color(0xFF020711)),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => const NotificationsSettingsView()),
            child: Image.asset("assets/images/Notifications/Notification Settings.png"),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF9FBFC),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.notifications.isEmpty) {
          return const Center(child: Text('No notifications yet'));
        }

        // Copy grouped map so we can safely remove TODAY/YESTERDAY
        final Map<String, List<AppNotification>> grouped = Map.from(controller.grouped);

        final todayItems = grouped.remove('TODAY');
        final yesterdayItems = grouped.remove('YESTERDAY');

        // Sort remaining section keys (date strings) newest → oldest
        final otherSections = grouped.keys.toList()
          ..sort((a, b) {
            final da = DateFormat('MMM d, yyyy').parse(a);
            final db = DateFormat('MMM d, yyyy').parse(b);
            return db.compareTo(da);
          });

        // Final section order: TODAY → YESTERDAY → others (newest → oldest)
        final sectionKeys = <String>[
          if (todayItems != null) 'TODAY',
          if (yesterdayItems != null) 'YESTERDAY',
          ...otherSections,
        ];

        return SingleChildScrollView(
          child: Column(
            children: sectionKeys.map((section) {
              final items = section == 'TODAY'
                  ? todayItems!
                  : section == 'YESTERDAY'
                  ? yesterdayItems!
                  : grouped[section]!;

              // items are already newest → oldest from controller.grouped,
              // but sorting again here is harmless and defensive:
              items.sort((a, b) => b.createdAt.compareTo(a.createdAt));

              return Column(
                children: [
                  // Section header
                  Container(
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          section,
                          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: const Color(0xFF6F7E8D)),
                        ),
                        const SizedBox.shrink(),
                      ],
                    ),
                  ),

                  // Notifications list for the section
                  ...items.map((n) {
                    final isPromotion = n.type.toLowerCase() == 'promotion' ||
                        (n.data['type']?.toString().toLowerCase() == 'new_deal');

                    final String icon = isPromotion
                        ? 'assets/images/Notifications/Flame.png'
                        : 'assets/images/Notifications/Star.png';
                    final Color iconBg = isPromotion ? const Color(0xFFFF6C3D) : const Color(0xFFFFA81C);

                    final timeText = (section == 'TODAY' || section == 'YESTERDAY')
                        ? section
                        : DateFormat('MMM d, yyyy').format(n.createdAt.toLocal());

                    return NotificationsCardView(
                      isChecked: n.read,
                      icon: icon,
                      iconBg: iconBg,
                      title: n.title,
                      time: timeText,
                      description: n.body,
                      onTap: () => controller.onTapNotification(n),
                    );
                  }).toList(),
                ],
              );
            }).toList(),
          ),
        );
      }),
    );
  }
}
