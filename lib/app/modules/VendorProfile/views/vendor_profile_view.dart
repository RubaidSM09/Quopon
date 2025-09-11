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
  final int vendorId;
  final String? logo;
  final String name;
  final String type;
  final String address;

  const VendorProfileView({
    required this.vendorId,
    required this.logo,
    required this.name,
    required this.type,
    required this.address,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    Get.put(VendorProfileController());
    print(vendorId);
    controller.fetchDeals(vendorId);
    controller.fetchMenus(vendorId);

    final hasLogo = logo != null && logo!.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 264.h, // ScreenUtil applied
              decoration: BoxDecoration(
                color: Color(0xFFF6E7D8),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 16.h), // ScreenUtil applied
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
                          child: Icon(Icons.arrow_back, size: 24.sp), // ScreenUtil applied
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 30.h, // ScreenUtil applied
                              backgroundImage: hasLogo ? NetworkImage(logo!) : null,
                              child: hasLogo ? null : const Icon(Icons.store),
                            ),
                            SizedBox(height: 10.h), // ScreenUtil applied
                            Text(
                              name,
                              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                            ),
                            SizedBox(height: 2.5.h), // ScreenUtil applied
                            Row(
                              children: [
                                Text(
                                  type,
                                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                                ),
                                SizedBox(width: 5.w), // ScreenUtil applied
                                CircleAvatar(
                                  backgroundColor: Color(0xFF6F7E8D),
                                  radius: 3.h, // ScreenUtil applied
                                ),
                                SizedBox(width: 5.w), // ScreenUtil applied
                                Text(
                                  address,
                                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                                ),
                                SizedBox(width: 5.w), // ScreenUtil applied
                                CircleAvatar(
                                  backgroundColor: Color(0xFF6F7E8D),
                                  radius: 3.h, // ScreenUtil applied
                                ),
                                SizedBox(width: 5.w), // ScreenUtil applied
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                      size: 14.sp, // ScreenUtil applied
                                    ),
                                    SizedBox(width: 3.w), // ScreenUtil applied
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
                        Image.asset("assets/images/MyDealsDetails/Upload.png", width: 40.w, height: 40.h), // ScreenUtil applied
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GradientButton(
                          onPressed: () {},
                          text: "Follow",
                          colors: [Color(0xFFD62828), Color(0xFFC21414)],
                          width: 175.w, // ScreenUtil applied
                          borderRadius: 12.r, // ScreenUtil applied
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/VendorProfile/Follow.png"),
                              SizedBox(width: 10.w), // ScreenUtil applied
                              Text(
                                "Follow",
                                style: TextStyle(fontSize: 17.5.sp, fontWeight: FontWeight.w500, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        GradientButton(
                          onPressed: () {},
                          text: "Email",
                          colors: [Color(0xFFF4F5F6), Color(0xFFEEF0F3)],
                          width: 175.w, // ScreenUtil applied
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/login/Email.png"),
                              SizedBox(width: 10.w), // ScreenUtil applied
                              Text(
                                "Email",
                                style: TextStyle(fontSize: 17.5.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
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
              padding: EdgeInsets.all(16.w), // ScreenUtil applied
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
                      height: 253.h, // ScreenUtil applied
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.deals.length,
                        itemBuilder: (context, index) {
                          final deal = controller.deals[index];
                          return ActiveDealCard(
                            dealImg: deal.imageUrl,
                            dealTitle: deal.title,
                            dealDescription: deal.description,
                            dealValidity: deal.endDate,
                          );
                        },
                      ),
                    );
                  }),

                  SizedBox(height: 10.h), // ScreenUtil applied
                  Text(
                    "Menu",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp, color: Color(0xFF020711)),
                  ),
                  SizedBox(height: 6.h), // ScreenUtil applied

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
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100.r), // ScreenUtil applied
                            ),
                            child: Center(
                              child: Text(
                                category,
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Color(0xFF6F7E8D)),
                              ),
                            ),
                          ),
                        ),
                      ]);
                    });

                    return SizedBox(
                      height: 32.h, // ScreenUtil applied
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: sections,
                        ),
                      )
                    );
                  }),

                  SizedBox(height: 15.h,),

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
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => ProductDetailsView(
                                  id: m.id,
                                  title: m.title,
                                  price: double.parse(m.price),
                                  calory: 5,
                                  description: m.description,
                                  image: imageUrl,
                                  // item: Items(),
                                ));
                              },
                              child: ItemCard(
                                // if you already added `isNetworkImage` earlier, pass true; otherwise this arg is optional.
                                image: imageUrl.isNotEmpty
                                    ? imageUrl
                                    : 'assets/images/Menu/Custom Chicken Steak Hoagie.png',
                                isNetworkImage: imageUrl.isNotEmpty, // safe if your widget added this optional param
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

                  SizedBox(height: 20.h), // ScreenUtil applied



                  /*Obx(() {
                    if (controller.menu.isEmpty) {
                      return const Text("No active deals available.");
                    }

                    return Column(
                      children: controller.menu.map((menu) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  menu.name!,
                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Color(0xFF020711)),
                                ),
                              ],
                            ),

                            SizedBox(height: 6.h),

                            Column(
                              children: menu.items!.map((items) {
                                return Container(
                                  width: 398.w, // ScreenUtil applied
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12.r) // ScreenUtil applied
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 0.h), // ScreenUtil applied
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(() => ProductDetailsView(
                                          id: menu.id!,
                                          title: items.name!,
                                          price: double.parse(items.price!),
                                          calory: items.calories!,
                                          description: items.description!,
                                          image: items.imageUrl,
                                          item: items,
                                        ));
                                      },
                                      child: ItemCard(
                                        title: items.name!,
                                        price: double.parse(items.price!),
                                        calory: items.calories!,
                                        description: items.description!,
                                        image: items.imageUrl,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              ).toList(),

                              *//*return SizedBox(
                              height: boxHeight,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: controller.items.length,
                                itemBuilder: (context, index) {
                                  final items = controller.items[index];
                                  return Container(
                                    width: 398.w, // ScreenUtil applied
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12.r) // ScreenUtil applied
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 0.h), // ScreenUtil applied
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(() => ProductDetailsView(
                                            title: items.title,
                                            price: items.price,
                                            calory: items.calory,
                                            description: items.description,
                                            image: items.image,
                                          ));
                                        },
                                        child: ItemCard(
                                          title: items.title,
                                          price: items.price,
                                          calory: items.calory,
                                          description: items.description,
                                          image: items.image,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),*//*
                            ),

                            SizedBox(height: 20.h),
                          ],
                        );
                      }).toList(),
                    );
                  }),*/




                  /*Text(
                    "Hot Coffee",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Color(0xFF020711)),
                  ),
                  SizedBox(height: 6.h), // ScreenUtil applied
                  Obx(() {
                    if (controller.items.isEmpty) {
                      return const Text("No active deals available.");
                    }

                    // Calculate height based on number of items
                    double itemHeight = 114.h; // ScreenUtil applied
                    double totalHeight = itemHeight + 12.h; // ScreenUtil applied
                    double boxHeight = totalHeight * controller.items.length;

                    return SizedBox(
                      height: boxHeight,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: controller.items.length,
                        itemBuilder: (context, index) {
                          final items = controller.items[index];
                          return Container(
                            width: 398.w, // ScreenUtil applied
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r) // ScreenUtil applied
                            ),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 0.h), // ScreenUtil applied
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() => ProductDetailsView(
                                    title: items.title,
                                    price: items.price,
                                    calory: items.calory,
                                    description: items.description,
                                    image: items.image,
                                  ));
                                },
                                child: ItemCard(
                                  title: items.title,
                                  price: items.price,
                                  calory: items.calory,
                                  description: items.description,
                                  image: items.image,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),

                  SizedBox(height: 20.h), // ScreenUtil applied
                  Text(
                    "Cold Coffee",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Color(0xFF020711)),
                  ),
                  SizedBox(height: 6.h), // ScreenUtil applied
                  Obx(() {
                    if (controller.items.isEmpty) {
                      return const Text("No active deals available.");
                    }

                    // Calculate height based on number of items
                    double itemHeight = 114.h; // ScreenUtil applied
                    double totalHeight = itemHeight + 12.h; // ScreenUtil applied
                    double boxHeight = totalHeight * controller.items.length;

                    return SizedBox(
                      height: boxHeight,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: controller.items.length,
                        itemBuilder: (context, index) {
                          final items = controller.items[index];
                          return Container(
                            width: 398.w, // ScreenUtil applied
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r) // ScreenUtil applied
                            ),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 0.h), // ScreenUtil applied
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() => ProductDetailsView(
                                    title: items.title,
                                    price: items.price,
                                    calory: items.calory,
                                    description: items.description,
                                    image: items.image,
                                  ));
                                },
                                child: ItemCard(
                                  title: items.title,
                                  price: items.price,
                                  calory: items.calory,
                                  description: items.description,
                                  image: items.image,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),

                  SizedBox(height: 20.h), // ScreenUtil applied
                  Text(
                    "Hot Tea",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Color(0xFF020711)),
                  ),
                  SizedBox(height: 6.h), // ScreenUtil applied
                  Obx(() {
                    if (controller.items.isEmpty) {
                      return const Text("No active deals available.");
                    }

                    // Calculate height based on number of items
                    double itemHeight = 114.h; // ScreenUtil applied
                    double totalHeight = itemHeight + 12.h; // ScreenUtil applied
                    double boxHeight = totalHeight * controller.items.length;

                    return SizedBox(
                      height: boxHeight,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: controller.items.length,
                        itemBuilder: (context, index) {
                          final items = controller.items[index];
                          return Container(
                            width: 398.w, // ScreenUtil applied
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r) // ScreenUtil applied
                            ),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 0.h), // ScreenUtil applied
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() => ProductDetailsView(
                                    title: items.title,
                                    price: items.price,
                                    calory: items.calory,
                                    description: items.description,
                                    image: items.image,
                                  ));
                                },
                                child: ItemCard(
                                  title: items.title,
                                  price: items.price,
                                  calory: items.calory,
                                  description: items.description,
                                  image: items.image,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),

                  SizedBox(height: 20.h), // ScreenUtil applied
                  Text(
                    "Cold Tea",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Color(0xFF020711)),
                  ),
                  SizedBox(height: 6.h), // ScreenUtil applied
                  Obx(() {
                    if (controller.items.isEmpty) {
                      return const Text("No active deals available.");
                    }

                    // Calculate height based on number of items
                    double itemHeight = 114.h; // ScreenUtil applied
                    double totalHeight = itemHeight + 12.h; // ScreenUtil applied
                    double boxHeight = totalHeight * controller.items.length;

                    return SizedBox(
                      height: boxHeight,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: controller.items.length,
                        itemBuilder: (context, index) {
                          final items = controller.items[index];
                          return Container(
                            width: 398.w, // ScreenUtil applied
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r) // ScreenUtil applied
                            ),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 0.h), // ScreenUtil applied
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() => ProductDetailsView(
                                    title: items.title,
                                    price: items.price,
                                    calory: items.calory,
                                    description: items.description,
                                    image: items.image,
                                  ));
                                },
                                child: ItemCard(
                                  title: items.title,
                                  price: items.price,
                                  calory: items.calory,
                                  description: items.description,
                                  image: items.image,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),

                  SizedBox(height: 20.h), // ScreenUtil applied
                  Text(
                    "Refreshers",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Color(0xFF020711)),
                  ),
                  SizedBox(height: 6.h), // ScreenUtil applied
                  Obx(() {
                    if (controller.items.isEmpty) {
                      return const Text("No active deals available.");
                    }

                    // Calculate height based on number of items
                    double itemHeight = 114.h; // ScreenUtil applied
                    double totalHeight = itemHeight + 12.h; // ScreenUtil applied
                    double boxHeight = totalHeight * controller.items.length;

                    return SizedBox(
                      height: boxHeight,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: controller.items.length,
                        itemBuilder: (context, index) {
                          final items = controller.items[index];
                          return Container(
                            width: 398.w, // ScreenUtil applied
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r) // ScreenUtil applied
                            ),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 0.h), // ScreenUtil applied
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() => ProductDetailsView(
                                    title: items.title,
                                    price: items.price,
                                    calory: items.calory,
                                    description: items.description,
                                    image: items.image,
                                  ));
                                },
                                child: ItemCard(
                                  title: items.title,
                                  price: items.price,
                                  calory: items.calory,
                                  description: items.description,
                                  image: items.image,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),*/


                  // Align "Location" to left
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Location",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                    ),
                  ),
                  // SizedBox(height: 5),
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
                  ),
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
          borderRadius: BorderRadius.only(topRight: Radius.circular(12.r), topLeft: Radius.circular(12.r),),
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 24.r, offset: Offset(0, -4))]
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
                Get.bottomSheet(CartBottomView());
              },
              child: Icon(
                Icons.keyboard_arrow_up_outlined,
                size: 24.sp,
                color: Color(0xFF020711),
              ),
            )
          ],
        ),
      ),
    );
  }
}
