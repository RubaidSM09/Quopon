import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/ProductDetails/views/product_details_view.dart';
import 'package:quopon/common/ItemCard.dart';
import 'package:quopon/common/customTextButton.dart';
import 'package:quopon/common/restaurant_card.dart';

import '../controllers/vendor_profile_controller.dart';

class VendorProfileView extends GetView<VendorProfileController> {
  const VendorProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(VendorProfileController());

    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 264,
              decoration: BoxDecoration(
                color: Color(0xFFF6E7D8)
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
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
                          child: Icon(Icons.arrow_back),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage('assets/images/deals/details/Starbucks_Logo.png'),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              'Starbucks',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                            ),
                            SizedBox(height: 2.5,),
                            Row(
                              children: [
                                Text(
                                  'Café',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                                ),
                                SizedBox(width: 5,),
                                CircleAvatar(
                                  backgroundColor: Color(0xFF6F7E8D),
                                  radius: 3,
                                ),
                                SizedBox(width: 5,),
                                Text(
                                  'Downtown',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                                ),
                                SizedBox(width: 5,),
                                CircleAvatar(
                                  backgroundColor: Color(0xFF6F7E8D),
                                  radius: 3,
                                ),
                                SizedBox(width: 5,),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                      size: 14,
                                    ),
                                    SizedBox(width: 3),
                                    Text(
                                      '4.7 ',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF020711),
                                      ),
                                    ),
                                    Text(
                                      '(917)',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF6F7E8D),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        Image.asset("assets/images/MyDealsDetails/Upload.png"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GradientButton(
                          onPressed: () {  },
                          text: "Follow",
                          colors: [Color(0xFFD62828), Color(0xFFC21414)],
                          width: 175,
                          height: 44,
                          borderRadius: 12,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/VendorProfile/Follow.png"),
                              SizedBox(width: 10,),
                              Text(
                                "Follow",
                                style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.w500, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        GradientButton(
                          onPressed: () {  },
                          text: "Email",
                          colors: [Color(0xFFF4F5F6), Color(0xFFEEF0F3)],
                          width: 175,
                          height: 44,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/login/Email.png"),
                              SizedBox(width: 10,),
                              Text(
                                "Email",
                                style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Active Deals",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Color(0xFF020711)),
                      ),
                    ],
                  ),
                  Obx(() {
                    if (controller.activeDeals.isEmpty) {
                      return const Text("No active deals available.");
                    }
        
                    return SizedBox(
                      height: 246,
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
        
                  SizedBox(height: 10,),
                  Text(
                    "Menu",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Color(0xFF020711)),
                  ),
                  SizedBox(height: 6,),
                  Obx(() {
                    if (controller.menu.isEmpty) {
                      return const Text("No active deals available.");
                    }
        
                    return SizedBox(
                      height: 32,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.menu.length,
                        separatorBuilder: (context, index) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final menu = controller.menu[index];
                          return Container(
                            width: 92,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                menu,
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xFF6F7E8D)),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
        
                  SizedBox(height: 20,),
                  Text(
                    "Hot Coffee",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFF020711)),
                  ),
                  SizedBox(height: 6,),
                  Obx(() {
                    if (controller.items.isEmpty) {
                      return const Text("No active deals available.");
                    }

                    // Calculate height based on number of items
                    double itemHeight = 114;
                    double totalHeight = itemHeight + 12;
                    double boxHeight = totalHeight * controller.items.length;

                    return SizedBox(
                      height: boxHeight,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: controller.items.length,
                        // separatorBuilder: (context, index) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final items = controller.items[index];
                          return Container(
                              width: 398,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
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
                              )
                          );
                        },
                      ),
                    );
                  }),

                  SizedBox(height: 20,),
                  Text(
                    "Cold Coffee",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFF020711)),
                  ),
                  SizedBox(height: 6,),
                  Obx(() {
                    if (controller.items.isEmpty) {
                      return const Text("No active deals available.");
                    }

                    // Calculate height based on number of items
                    double itemHeight = 114;
                    double totalHeight = itemHeight + 12;
                    double boxHeight = totalHeight * controller.items.length;

                    return SizedBox(
                      height: boxHeight,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: controller.items.length,
                        // separatorBuilder: (context, index) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final items = controller.items[index];
                          return Container(
                              width: 398,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
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
                              )
                          );
                        },
                      ),
                    );
                  }),

                  SizedBox(height: 20,),
                  Text(
                    "Hot Tea",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFF020711)),
                  ),
                  SizedBox(height: 6,),
                  Obx(() {
                    if (controller.items.isEmpty) {
                      return const Text("No active deals available.");
                    }

                    // Calculate height based on number of items
                    double itemHeight = 114;
                    double totalHeight = itemHeight + 12;
                    double boxHeight = totalHeight * controller.items.length;

                    return SizedBox(
                      height: boxHeight,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: controller.items.length,
                        // separatorBuilder: (context, index) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final items = controller.items[index];
                          return Container(
                              width: 398,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
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
                              )
                          );
                        },
                      ),
                    );
                  }),

                  SizedBox(height: 20,),
                  Text(
                    "Cold Tea",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFF020711)),
                  ),
                  SizedBox(height: 6,),
                  Obx(() {
                    if (controller.items.isEmpty) {
                      return const Text("No active deals available.");
                    }

                    // Calculate height based on number of items
                    double itemHeight = 114;
                    double totalHeight = itemHeight + 12;
                    double boxHeight = totalHeight * controller.items.length;

                    return SizedBox(
                      height: boxHeight,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: controller.items.length,
                        // separatorBuilder: (context, index) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final items = controller.items[index];
                          return Container(
                              width: 398,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
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
                              )
                          );
                        },
                      ),
                    );
                  }),

                  SizedBox(height: 20,),
                  Text(
                    "Refreshers",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFF020711)),
                  ),
                  SizedBox(height: 6,),
                  Obx(() {
                    if (controller.menu.isEmpty) {
                      return const Text("No active deals available.");
                    }

                    // Calculate height based on number of items
                    double itemHeight = 114;
                    double totalHeight = itemHeight + 0;
                    double boxHeight = totalHeight * controller.menu.length;

                    return SizedBox(
                      height: boxHeight,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: controller.items.length,
                        // separatorBuilder: (context, index) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final items = controller.items[index];
                          return Container(
                              width: 398,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
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
                              )
                          );
                        },
                      ),
                    );
                  }),
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
      )
    );
  }
}
