// lib/app/modules/Search/views/search_history_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../home/controllers/home_controller.dart';

class SearchHistoryView extends GetView {
  final String title;
  const SearchHistoryView({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    final home = Get.find<HomeController>();

    return GestureDetector(
      onTap: () async {
        final ok = await home.runSearch(title);
        if (ok) Get.back();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Color(0xFFF0F2F3)),
            bottom: BorderSide(color: Color(0xFFF0F2F3)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: TextStyle(
                  color: const Color(0xFF6F7E8D),
                  fontSize: 14.sp,
                )),
            Icon(Icons.close, size: 16.sp, color: const Color(0xFF6F7E8D)),
          ],
        ),
      ),
    );
  }
}
