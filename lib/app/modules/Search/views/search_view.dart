// lib/app/modules/Search/views/search_view.dart
import 'dart:async';
import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import 'package:quopon/app/modules/Search/views/search_error_view.dart';
import 'package:quopon/app/modules/Search/views/search_history_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../home/controllers/home_controller.dart';
import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SearchController());
    final home = Get.find<HomeController>();
    final TextEditingController _searchCtrl =
    TextEditingController(text: home.currentQuery.value);

    Future<void> _executeSearchAndMaybeNavigate(String txt) async {
      final ok = await home.runSearch(txt);
      if (ok) {
        // record search history on success
        await controller.addSearchToHistory(txt);

        // pop back (your original behavior)
        if (Get.isOverlaysOpen) Get.back();
        if (Get.currentRoute != '/') {
          Get.back();
        }
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFC),
      body: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 60.h, bottom: 22.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(Icons.arrow_back, color: const Color(0xFF020711), size: 24.sp),
                  ),
                  Text(
                    'Search',
                    style: TextStyle(
                      color: const Color(0xFF020711),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox.shrink(),
                ],
              ),

              SizedBox(height: 24.h),

              // Search bar
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchCtrl,
                        onChanged: (txt) => home.currentQuery.value = txt,
                        onSubmitted: (txt) => _executeSearchAndMaybeNavigate(txt),
                        decoration: const InputDecoration(
                          hintText: 'Search food, store, deals...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _executeSearchAndMaybeNavigate(_searchCtrl.text),
                      child: Image.asset('assets/images/Home/Search.png'),
                    ),
                  ],
                ),
              ),

              // Spinner during search
              Obx(() => home.searching.value
                  ? Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: const CircularProgressIndicator(),
              )
                  : const SizedBox.shrink()),

              SizedBox(height: 20.h),

              // Inline "no results" error view
              Obx(() {
                final hasQuery = home.currentQuery.value.trim().isNotEmpty;
                final noResults = !home.searching.value &&
                    hasQuery &&
                    home.beyondNeighbourhood.isEmpty &&
                    home.nearShops.isEmpty &&
                    home.speedyDeliveries.isEmpty;

                if (noResults) {
                  return const SearchErrorView();
                }

                // Default content (Recent + Frequent)
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recent Searches',
                          style: TextStyle(
                            color: const Color(0xFF020711),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _searchCtrl.clear();
                            home.runSearch('');
                          },
                          child: Text(
                            'Clear All',
                            style: TextStyle(
                              color: const Color(0xFFD62828),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),

                    // ---- DYNAMIC recent history (latest 5) ----
                    Obx(() {
                      final items = controller.recentSearches;
                      if (items.isEmpty) {
                        return Text(
                          'No recent searches',
                          style: TextStyle(color: const Color(0xFF6F7E8D), fontSize: 14.sp),
                        );
                      }
                      return Column(
                        children: items
                            .map((h) => SearchHistoryView(title: h.query))
                            .toList(),
                      );
                    }),

                    SizedBox(height: 16.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Frequently searched by people’s',
                          style: TextStyle(
                            color: const Color(0xFF020711),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox.shrink()
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Obx(() {
                      if (controller.frequentSearches.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Column(
                        children: controller.frequentSearches.take(5).map((f) {
                          return SearchHistoryView(title: f.queryText);
                        }).toList(),
                      );
                    }),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
