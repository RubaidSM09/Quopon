import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quopon/app/modules/ProductDetails/views/product_details_view.dart';
import 'package:quopon/app/modules/VendorProfile/views/cart_bottom_view.dart';
import 'package:quopon/common/ItemCard.dart';
import 'package:quopon/common/customTextButton.dart';
import 'package:quopon/common/restaurant_card.dart';
import '../controllers/vendor_profile_controller.dart';

class VendorProfileView extends GetView<VendorProfileController> {
  final String logo;

  const VendorProfileView({
    required this.logo,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    Get.put(VendorProfileController());

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
                              backgroundImage: NetworkImage(
                                logo,
                              ),
                            ),
                            SizedBox(height: 10.h), // ScreenUtil applied
                            Text(
                              'Starbucks',
                              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                            ),
                            SizedBox(height: 2.5.h), // ScreenUtil applied
                            Row(
                              children: [
                                Text(
                                  'Café',
                                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                                ),
                                SizedBox(width: 5.w), // ScreenUtil applied
                                CircleAvatar(
                                  backgroundColor: Color(0xFF6F7E8D),
                                  radius: 3.h, // ScreenUtil applied
                                ),
                                SizedBox(width: 5.w), // ScreenUtil applied
                                Text(
                                  'Downtown',
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
                    if (controller.activeDeals.isEmpty) {
                      return const Text("No active deals available.");
                    }

                    return SizedBox(
                      height: 253.h, // ScreenUtil applied
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.activeDeals.length,
                        itemBuilder: (context, index) {
                          final deal = controller.activeDeals[index];
                          return ActiveDealCard(
                            dealImg: deal.dealImg,
                            dealTitle: deal.dealTitle,
                            dealDescription: deal.dealDescription,
                            dealValidity: deal.dealValidity,
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
                    if (controller.menu.isEmpty) {
                      return const Text("No active deals available.");
                    }

                    return SizedBox(
                      height: 32.h, // ScreenUtil applied
                      child: Row(
                        children: controller.menu.map((menu) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            child: Container(
                              width: 92.w, // ScreenUtil applied
                              height: 32.h, // ScreenUtil applied
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100.r), // ScreenUtil applied
                              ),
                              child: Center(
                                child: Text(
                                  menu.name!,
                                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: Color(0xFF6F7E8D)),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    );
                  }),

                  SizedBox(height: 20.h), // ScreenUtil applied

                  Column(
                    children: controller.menu.map((menu) {
                      return Column(
                        children: [
                          Text(
                            menu.name!,
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Color(0xFF020711)),
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
                                          title: items.name!,
                                          price: double.parse(items.price!),
                                          calory: (items.calories ?? 0).toDouble(),
                                          description: items.description!,
                                          image: items.imageUrl,
                                        ));
                                      },
                                      child: ItemCard(
                                        title: items.name!,
                                        price: double.parse(items.price!),
                                        calory: (items.calories ?? 0).toDouble(),
                                        description: items.description!,
                                        image: items.imageUrl,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ).toList(),

                            /*return SizedBox(
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
                              ),*/
                            ),

                          SizedBox(height: 20.h),
                        ],
                      );
                    }).toList(),
                  ),


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
