import 'package:flutter/material.dart' hide SearchController;

import 'package:get/get.dart';
import 'package:quopon/common/customTextButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil

import '../controllers/search_controller.dart';

class SearchErrorView extends StatefulWidget {
  const SearchErrorView({super.key});

  @override
  State<SearchErrorView> createState() => _SearchErrorViewState();
}

class _SearchErrorViewState extends State<SearchErrorView> {
  // final TextEditingController _SearchErrorController = TextEditingController(text: "Downtown");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h), // ScreenUtil for padding
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                  SizedBox(width: 8.w), // Use ScreenUtil for spacing
                  const Text(
                    "Search",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w), // ScreenUtil for padding
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r), // ScreenUtil for border radius
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
                          hintText: 'Downtown',
                          hintStyle: TextStyle(color: Color(0xFF6F7E8D), fontSize: 14.sp), // ScreenUtil for font size
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(Icons.search, color: Colors.grey[500], size: 24.sp), // Use ScreenUtil for icon size
                  ],
                ),
              ),
            ),
            SizedBox(height: 40.h), // Use ScreenUtil for height spacing
            Image.asset(
              'assets/images/Search/No Deals.png', // ensure this asset exists
              height: 200.h, // Use ScreenUtil for height
            ),
            SizedBox(height: 24.h), // Use ScreenUtil for height spacing
            Text(
              'No Deals Found Nearby',
              style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0.w, vertical: 12.h),
              child: Text(
                'Try exploring nearby cities or check out trending deals from other locations.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp, color: Colors.grey),
              ),
            ),
            SizedBox(height: 50.h), // Use ScreenUtil for height spacing
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w), // ScreenUtil for padding
              child: Column(
                children: [
                  GradientButton(
                    text: "Browse Popular Deals",
                    onPressed: () {},
                    colors: [Color(0xFFF4F5F6), Color(0xFFEEF0F3)],
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp, // Use ScreenUtil for font size
                      color: Color(0xFF020711),
                    ),
                  ),
                  SizedBox(height: 12.h), // Use ScreenUtil for height spacing
                  GradientButton(
                    text: 'Explore Nearby Cities',
                    onPressed: () {

                    },
                    colors: [const Color(0xFFD62828), const Color(0xFFC21414)],
                    boxShadow: [const BoxShadow(color: Color(0xFF9A0000), spreadRadius: 1)],
                    child: Text(
                      'Explore Nearby Cities',
                      style: TextStyle(
                        fontSize: 16.sp,  // Use ScreenUtil for font size
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h), // Use ScreenUtil for height spacing
          ],
        ),
      ),
    );
  }
}
