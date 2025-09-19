// lib/app/modules/signUpProcess/views/food_preferences_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../common/customTextButton.dart';
import '../controllers/sign_up_process_controller.dart';

class FoodPreferencesScreen extends GetView<SignUpProcessController> {
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const FoodPreferencesScreen({super.key, required this.onNext, required this.onSkip});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Tell Us What You Love',
              style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold, color: const Color(0xFF020711))),
          SizedBox(height: 8.h),
          Text(
            'Choose your favorite food categories so we can show you the most relevant deals around you.',
            style: TextStyle(fontSize: 16.sp, color: const Color(0xFF6F7E8D), fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30.h),

          // grid of categories (live)
          Expanded(
            child: Obx(() {
              if (controller.isLoadingCategories.value) {
                return const Center(child: CircularProgressIndicator());
              }
              final items = controller.categories;
              if (items.isEmpty) {
                return const Center(child: Text('No categories found'));
              }

              return Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                children: items.map((c) {
                  final isSelected = controller.selectedCategoryNames.contains(c.name);
                  return GestureDetector(
                    onTap: () {
                      if (isSelected) {
                        controller.selectedCategoryNames.remove(c.name);
                      } else {
                        controller.selectedCategoryNames.add(c.name);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFD62828) : Colors.grey[100],
                        borderRadius: BorderRadius.circular(25.r),
                        border: Border.all(
                          color: isSelected ? Colors.transparent : const Color(0xFFEFF1F2),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(c.emoji, style: TextStyle(fontSize: 16.sp)),
                          SizedBox(width: 8.w),
                          Text(
                            c.name,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
