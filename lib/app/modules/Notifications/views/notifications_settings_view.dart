import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/Notifications/views/notifications_settings_card_view.dart';

class NotificationsSettingsView extends GetView {
  const NotificationsSettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF9FBFC),
        title: Center(
          child: Text(
            'Notifications',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
          ),
        ),
      ),

      backgroundColor: Color(0xFFF9FBFC),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Container(
          height: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16)]
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              NotificationsSettingsCardView(
                title: 'New Deals',
                description: 'Get notified when new deals go live',
                isActive: true,
              ),

              Divider(thickness: 1, color: Color(0xFFEAECED),),

              NotificationsSettingsCardView(
                title: 'Nearby Offers',
                description: 'Alerts for deals near your location',
                isActive: false,
              ),

              Divider(thickness: 1, color: Color(0xFFEAECED),),

              NotificationsSettingsCardView(
                title: 'Redemption Reminders',
                description: 'Reminders before deals expire',
                isActive: true,
              ),

              Divider(thickness: 1, color: Color(0xFFEAECED),),

              NotificationsSettingsCardView(
                title: 'Vendor Updates',
                description: 'Pushes from vendors you follow',
                isActive: true,
              ),

              Divider(thickness: 1, color: Color(0xFFEAECED),),

              NotificationsSettingsCardView(
                title: 'Messages & Replies',
                description: 'Get notified when vendors reply to your review',
                isActive: false,
              ),

              Divider(thickness: 1, color: Color(0xFFEAECED),),

              NotificationsSettingsCardView(
                title: 'Support Ticket Updates',
                description: 'Get notified when your support request is updated',
                isActive: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
