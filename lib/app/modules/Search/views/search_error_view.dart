import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchErrorView extends StatelessWidget {
  const SearchErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24.h),
      child: Column(
        children: [
          // Image / Illustration
          Image.asset(
            'assets/images/Search/No Deals.png', // ensure this asset exists
            height: 200.h,
          ),
          SizedBox(height: 16.h),
          // Title
          Text(
            'No Results Found',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF020711),
            ),
          ),
          SizedBox(height: 8.h),
          // Subtitle
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              'Try a different name, or check trending deals and nearby vendors.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF6F7E8D),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          // Helpful actions (outlined primary + subtle secondary)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                // Primary (light) button
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F5F6),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // up to you: route to a popular deals page, or clear search, etc.
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Text(
                        'Browse Popular Deals',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF020711),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                // Secondary (accent) button
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD62828),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // up to you: open a location picker or nearby city explorer
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Text(
                        'Explore Nearby Cities',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}
