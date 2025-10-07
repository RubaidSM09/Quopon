import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quopon/app/data/model/menu.dart';
import 'package:quopon/app/modules/ProductDetails/views/product_details_view.dart';
import 'package:quopon/app/modules/VendorProfile/views/cart_bottom_view.dart';
import 'package:quopon/common/ItemCard.dart';
import 'package:quopon/common/customTextButton.dart';
import 'package:quopon/common/restaurant_card.dart';
import '../controllers/vendor_profile_controller.dart';

class VendorProfileView extends GetView<VendorProfileController> {
  final int id; // <-- BUSINESS PROFILE ID (used for follow/unfollow)
  final int vendorId; // <-- user/vendor id (used for deals/menus)
  final String? logo;
  final String name;
  final String type;
  final String address;

  const VendorProfileView({
    required this.id,
    required this.vendorId,
    required this.logo,
    required this.name,
    required this.type,
    required this.address,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(VendorProfileController());
    controller.fetchDeals(vendorId);
    controller.fetchMenus(vendorId);
    controller.loadFollowState(id);

    // Initialize ScrollController for scrolling to sections
    final ScrollController scrollController = ScrollController();

    // Map to store GlobalKey for each category
    final Map<String, GlobalKey> categoryKeys = {};

    final hasLogo = logo != null && logo!.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFC),
      body: SingleChildScrollView(
        controller: scrollController, // Attach ScrollController
        child: Column(
          children: [
            Container(
              height: 264.h,
              decoration: const BoxDecoration(color: Color(0xFFF6E7D8)),
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 16.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(Icons.arrow_back, size: 24.sp),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 30.h,
                              backgroundImage: hasLogo ? NetworkImage(logo!) : null,
                              child: hasLogo ? null : const Icon(Icons.store),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              name,
                              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                            ),
                            SizedBox(height: 2.5.h),
                            Row(
                              children: [
                                Text(
                                  type,
                                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                                ),
                                SizedBox(width: 5.w),
                                CircleAvatar(
                                  backgroundColor: Color(0xFF6F7E8D),
                                  radius: 3.h,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  address,
                                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                                ),
                                SizedBox(width: 5.w),
                                CircleAvatar(
                                  backgroundColor: Color(0xFF6F7E8D),
                                  radius: 3.h,
                                ),
                                SizedBox(width: 5.w),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                      size: 14.sp,
                                    ),
                                    SizedBox(width: 3.w),
                                    Text(
                                      '4.7',
                                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF020711)),
                                    ),
                                    Text(
                                      '(917)',
                                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Image.asset("assets/images/MyDealsDetails/Upload.png", width: 40.w, height: 40.h),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Obx(() {
                          final following = controller.isFollowed.value;
                          final busy = controller.followBusy.value;
                          return GradientButton(
                            onPressed: () {
                              if (busy) return;
                              controller.toggleFollow(id);
                            },
                            text: following ? "Unfollow" : "Follow",
                            colors: following
                                ? [const Color(0xFF6F7E8D), const Color(0xFF6F7E8D)]
                                : [const Color(0xFFD62828), const Color(0xFFC21414)],
                            width: 175.w,
                            borderRadius: 12.r,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (busy) ...[
                                  SizedBox(
                                    height: 18.h,
                                    width: 18.h,
                                    child: const CircularProgressIndicator(strokeWidth: 2),
                                  ),
                                  SizedBox(width: 10.w),
                                ] else ...[
                                  Image.asset("assets/images/VendorProfile/Follow.png"),
                                  SizedBox(width: 10.w),
                                ],
                                Text(
                                  following ? "Unfollow" : "Follow",
                                  style: TextStyle(
                                    fontSize: 17.5.sp,
                                    fontWeight: FontWeight.w500,
                                    color: following ? Colors.white : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        GradientButton(
                          onPressed: () {},
                          text: "Email",
                          colors: const [Color(0xFFF4F5F6), Color(0xFFEEF0F3)],
                          width: 175.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/login/Email.png"),
                              SizedBox(width: 10.w),
                              Text(
                                "Email",
                                style: TextStyle(
                                  fontSize: 17.5.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF020711),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Active Deals",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp, color: Color(0xFF020711)),
                      ),
                    ],
                  ),
                  Obx(() {
                    if (controller.deals.isEmpty) {
                      return const Text("No active deals available.");
                    }

                    return SizedBox(
                      height: 253.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.deals.length,
                        itemBuilder: (context, index) {
                          final deal = controller.deals[index];
                          return ActiveDealCard(
                            dealImg: deal.imageUrl ?? '',
                            dealTitle: deal.title ?? 'Untitled Deal',
                            dealDescription: deal.description ?? '',
                            dealValidity: deal.endDate ?? '',
                          );
                        },
                      ),
                    );
                  }),
                  SizedBox(height: 10.h),
                  Text(
                    "Menu",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp, color: Color(0xFF020711)),
                  ),
                  SizedBox(height: 6.h),
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

                    // Generate GlobalKeys for each category
                    controller.menusByCategory.forEach((category, _) {
                      categoryKeys.putIfAbsent(category, () => GlobalKey());
                    });

                    final sections = <Widget>[];
                    controller.menusByCategory.forEach((category, items) {
                      sections.addAll([
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: GestureDetector(
                            onTap: () {
                              // Scroll to the category section
                              final key = categoryKeys[category];
                              if (key != null && key.currentContext != null) {
                                final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
                                final position = renderBox.localToGlobal(Offset.zero).dy;
                                final scrollOffset = scrollController.offset + position - 50.h; // Adjust for padding
                                scrollController.animateTo(
                                  scrollOffset,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100.r),
                              ),
                              child: Center(
                                child: Text(
                                  category,
                                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Color(0xFF6F7E8D)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]);
                    });

                    return SizedBox(
                      height: 32.h,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: sections,
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: 15.h),
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
                          key: categoryKeys[category], // Assign GlobalKey to category section
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
                          final parsedPrice = double.tryParse(m.price) ?? 0.0;
                          final imageUrl = m.logoImage;

                          return Padding(
                            padding: EdgeInsets.only(bottom: 7.5.h),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => ProductDetailsView(
                                  id: m.id,
                                  title: m.title,
                                  price: double.parse(m.price),
                                  calory: 5,
                                  description: m.description,
                                  image: imageUrl,
                                ));
                              },
                              child: ItemCard(
                                image: imageUrl.isNotEmpty
                                    ? imageUrl
                                    : 'assets/images/Menu/Custom Chicken Steak Hoagie.png',
                                isNetworkImage: imageUrl.isNotEmpty,
                                title: m.title,
                                description: m.description,
                                price: parsedPrice,
                                calory: 5,
                              ),
                            ),
                          );
                        }),
                        SizedBox(height: 15.h),
                      ]);
                    });

                    return Column(children: sections);
                  }),
                  SizedBox(height: 20.h),
                  /*Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Location",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 398,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.asset(
                        'assets/images/MyDealsDetails/Location.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(12.r), topLeft: Radius.circular(12.r)),
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 24.r, offset: Offset(0, -4))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Cart',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF020711),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.bottomSheet(CartBottomView(vendorId: vendorId));
              },
              child: Icon(
                Icons.keyboard_arrow_up_outlined,
                size: 24.sp,
                color: Color(0xFF020711),
              ),
            ),
          ],
        ),
      ),
    );
  }
}