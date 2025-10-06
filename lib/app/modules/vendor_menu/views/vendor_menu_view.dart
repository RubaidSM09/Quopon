// lib/app/modules/vendor_menu/views/vendor_menu_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quopon/app/modules/vendor_add_menu/views/vendor_add_menu_view.dart';
import 'package:quopon/app/modules/vendor_menu/views/menu_card_view.dart';
import '../../../../common/customTextButton.dart';
import '../controllers/vendor_menu_controller.dart';

class VendorMenuView extends GetView<VendorMenuController> {
  const VendorMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure controller is available
    Get.put(VendorMenuController());

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFC),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 60.h, 16.w, 22.h),
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
                    'My Menu',
                    style: TextStyle(
                      color: const Color(0xFF020711),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox.shrink(),
                ],
              ),

              SizedBox(height: 20.h),

              // Search (kept as-is)
              GestureDetector(
                onTap: () {/* navigate to search if needed */},
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
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
                      const Expanded(
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: 'Search food...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Image.asset('assets/images/Home/Search.png'),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              // ===== Dynamic content =====
              Obx(() {
                if (controller.loading.value) {
                  return Padding(
                    padding: EdgeInsets.only(top: 40.h),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }
                if (controller.error.isNotEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(top: 40.h),
                    child: Text(
                      controller.error.value,
                      style: TextStyle(color: Colors.red, fontSize: 14.sp),
                    ),
                  );
                }
                if (controller.menusByCategory.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(top: 40.h),
                    child: Text(
                      'No menu items found',
                      style: TextStyle(fontSize: 14.sp, color: const Color(0xFF6F7E8D)),
                    ),
                  );
                }

                final sections = <Widget>[];
                controller.menusByCategory.forEach((category, items) {
                  sections.addAll([
                    Row(
                      children: [
                        Text(
                          category,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: const Color(0xFF020711),
                          ),
                        ),
                        const SizedBox.shrink(),
                      ],
                    ),
                    SizedBox(height: 15.h),

                    ...items.map((m) {
                      final parsedPrice = double.tryParse(m.price) ?? 0.0;  // your model has price as String
                      final imageUrl = m.logoImage;                         // full URL from API

                      return Padding(
                        padding: EdgeInsets.only(bottom: 7.5.h),
                        child: MenuCardView(
                          menuId: m.id,
                          // if you already added `isNetworkImage` earlier, pass true; otherwise this arg is optional.
                          image: imageUrl.isNotEmpty
                              ? imageUrl
                              : 'assets/images/Menu/Custom Chicken Steak Hoagie.png',
                          isNetworkImage: imageUrl.isNotEmpty, // safe if your widget added this optional param
                          title: m.title,
                          description: m.description,
                          price: parsedPrice,
                        ),
                      );
                    }),
                    SizedBox(height: 15.h),
                  ]);
                });

                return Column(children: sections);
              }),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 24.r)],
        ),
        child: GradientButton(
          text: 'Add Menu Item',
          onPressed: () => Get.to(VendorAddMenuView()),
          borderColor: const [Color(0xFFF44646), Color(0xFFC21414)],
          boxShadow: [BoxShadow(color: const Color(0xFF9A0000), spreadRadius: 1.r)],
          colors: const [Color(0xFFD62828), Color(0xFFC21414)],
        ),
      ),
    );
  }
}
