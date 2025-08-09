import 'package:flutter/material.dart' hide SearchController;

import 'package:get/get.dart';
import 'package:quopon/app/modules/Search/views/search_history_view.dart';
import 'package:quopon/common/customTextButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({super.key});

  // final TextEditingController _searchController = TextEditingController(text: "Downtown");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 60.h, bottom: 22.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(Icons.arrow_back, color: Color(0xFF020711), size: 24.sp,),
                  ),
                  Text(
                    'Search',
                    style: TextStyle(
                        color: Color(0xFF020711),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox.shrink(),
                ],
              ),

              SizedBox(height: 24.h,),

              // Search bar
              GestureDetector(
                onTap: () {
                  // Get.to(SearchView());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),  // Use ScreenUtil for padding
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),  // Use ScreenUtil for border radius
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
                          readOnly: true, // <<— prevent actual editing and avoid focus issues
                          decoration: InputDecoration(
                            hintText: 'Search food, store, deals...',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Image.asset('assets/images/Home/Search.png'),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20.h,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Searches',
                    style: TextStyle(
                        color: Color(0xFF020711),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  Text(
                    'Clear All',
                    style: TextStyle(
                        color: Color(0xFFD62828),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h,),
              SearchHistoryView(title: 'SABABA - Albert Cuypstraat',),
              SearchHistoryView(title: 'Starbucks',),
              SearchHistoryView(title: 'KFC',),
              SearchHistoryView(title: 'Mcdonald',),
              SearchHistoryView(title: 'Best burger near me'),

              SizedBox(height: 16.h,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Frequently searched by people’s',
                    style: TextStyle(
                        color: Color(0xFF020711),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox.shrink()
                ],
              ),
              SizedBox(height: 12.h,),
              SearchHistoryView(title: 'SABABA - Albert Cuypstraat',),
              SearchHistoryView(title: 'Starbucks',),
              SearchHistoryView(title: 'KFC',),
              SearchHistoryView(title: 'Mcdonald',),
              SearchHistoryView(title: 'Best burger near me'),
            ],
          ),
        ),
      ),
    );
  }
}
