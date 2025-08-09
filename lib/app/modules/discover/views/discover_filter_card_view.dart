import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/discover_controller.dart';

class CuisineFilterCardView extends GetView<DiscoverController> {
  final String filterTitle;
  final int index;

  const CuisineFilterCardView({
    required this.filterTitle,
    required this.index,
    super.key
  });
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          controller.selectedCuisine[index].value = !controller.selectedCuisine[index].value;
        },
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: controller.selectedCuisine[index].value
                  ? Color(0xFFD62828)
                  : Color(0xFFEAECED),
            ),
          ),
          child: Text(
            filterTitle,
            style: TextStyle(
              color: controller.selectedCuisine[index].value
                  ? Color(0xFFD62828)
                  : Color(0xFF6F7E8D),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    });
  }
}

class DietFilterCardView extends GetView<DiscoverController> {
  final String filterTitle;
  final int index;

  const DietFilterCardView({
    required this.filterTitle,
    required this.index,
    super.key
  });
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          controller.selectedDiet[index].value = !controller.selectedDiet[index].value;
        },
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: controller.selectedDiet[index].value
                  ? Color(0xFFD62828)
                  : Color(0xFFEAECED),
            ),
          ),
          child: Text(
            filterTitle,
            style: TextStyle(
              color: controller.selectedDiet[index].value
                  ? Color(0xFFD62828)
                  : Color(0xFF6F7E8D),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    });
  }
}

class PriceFilterCardView extends GetView<DiscoverController> {
  final String filterTitle;
  final int index;

  const PriceFilterCardView({
    required this.filterTitle,
    required this.index,
    super.key
  });
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          controller.selectedPrice[index].value = !controller.selectedPrice[index].value;
        },
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: controller.selectedPrice[index].value
                  ? Color(0xFFD62828)
                  : Color(0xFFEAECED),
            ),
          ),
          child: Text(
            filterTitle,
            style: TextStyle(
              color: controller.selectedPrice[index].value
                  ? Color(0xFFD62828)
                  : Color(0xFF6F7E8D),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    });
  }
}

class RatingFilterCardView extends GetView<DiscoverController> {
  final String filterTitle;
  final int index;

  const RatingFilterCardView({
    required this.filterTitle,
    required this.index,
    super.key
  });
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          controller.selectedRating[index].value = !controller.selectedRating[index].value;
        },
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: controller.selectedRating[index].value
                  ? Color(0xFFD62828)
                  : Color(0xFFEAECED),
            ),
          ),
          child: Text(
            filterTitle,
            style: TextStyle(
              color: controller.selectedRating[index].value
                  ? Color(0xFFD62828)
                  : Color(0xFF6F7E8D),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    });
  }
}
