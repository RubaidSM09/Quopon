import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/profileCard.dart';
import '../../vendor_edit_deal/views/vendor_edit_deal_view.dart';
import '../../vendor_edit_menu/views/vendor_edit_menu_view.dart';
import '../controllers/vendor_menu_controller.dart';

class MenuOptionsView extends GetView<VendorMenuController> {
  final int menuId;

  const MenuOptionsView({
    required this.menuId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 266.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox.shrink(),
              Text(
                'Item Options',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,
                  color: const Color(0xFF020711),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(Icons.close),
              ),
            ],
          ),
          const Divider(color: Color(0xFFEAECED)),

          SizedBox(height: 10.h),

          GestureDetector(
            onTap: () {
              Get.back();
              Get.to(() => VendorEditMenuView(menuId: menuId),
                  arguments: {'menuId': menuId});
            },
            child: ProfileCard(
              icon: 'assets/images/DealOptions/Edit Deal.png',
              title: 'Edit Item',
            ),
          ),

          SizedBox(height: 10.h),

          GestureDetector(
            onTap: () {
              // TODO: Implement Deactivate Deal functionality
            },
            child: ProfileCard(
              icon: 'assets/images/DealOptions/Deactivate Deal.png',
              title: 'Deactivate Deal',
              isActive: true,
            ),
          ),

          SizedBox(height: 10.h),

          GestureDetector(
            onTap: () {
              Get.back();
              Get.defaultDialog(
                title: 'Confirm Delete',
                middleText: 'Are you sure you want to delete this menu item?',
                textConfirm: 'Delete',
                textCancel: 'Cancel',
                confirmTextColor: Colors.white,
                buttonColor: const Color(0xFFC21414),
                onConfirm: () async {
                  Get.back(); // Close the dialog
                  await controller.deleteMenu(menuId); // Call delete method
                },
              );
            },
            child: ProfileCard(
              icon: 'assets/images/DealOptions/Delete Deal.png',
              title: 'Delete Item',
            ),
          ),
        ],
      ),
    );
  }
}