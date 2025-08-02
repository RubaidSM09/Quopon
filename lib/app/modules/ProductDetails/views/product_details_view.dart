import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/customTextButton.dart';
import '../controllers/product_details_controller.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  final String title;
  final double price;
  final double calory;
  final String description;
  final String? image;

  const ProductDetailsView({
    required this.title,
    required this.price,
    required this.calory,
    required this.description,
    this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(ProductDetailsController());
    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image and top section
            Container(
              height: 264.h, // ScreenUtil applied
              decoration: BoxDecoration(
                color: Color(0xFFF6E7D8),
                image: DecorationImage(
                  image: AssetImage(image!),
                  fit: BoxFit.cover,
                ),
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
                        Image.asset("assets/images/MyDealsDetails/Upload.png", width: 40.w, height: 40.h), // ScreenUtil applied
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Product description section
            Padding(
              padding: EdgeInsets.all(16.w), // ScreenUtil applied
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp, // ScreenUtil applied
                          color: Color(0xFF020711),
                        ),
                      ),
                      Text(
                        "\$$price",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp, // ScreenUtil applied
                          color: Color(0xFFD62828),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h), // ScreenUtil applied
                  Text(
                    description,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp, // ScreenUtil applied
                      color: Color(0xFF6F7E8D),
                    ),
                  ),
                  Divider(color: Color(0xFFEAECED), thickness: 1),

                  // Addons section
                  Obx(() {
                    if (controller.itemAddOns.isEmpty) {
                      return const Text("No active add-ons available.");
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: controller.itemAddOns.map((addOn) {
                        if (addOn.addOnOptions.isEmpty) {
                          return const SizedBox.shrink();
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.h), // ScreenUtil applied
                            Row(
                              children: [
                                Text(
                                  addOn.addOnTitle,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.sp, // ScreenUtil applied
                                    color: Color(0xFF020711),
                                  ),
                                ),
                                if (addOn.addOnType)
                                  Text(
                                    "*",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.sp, // ScreenUtil applied
                                      color: Color(0xFFD62828),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: 6.h), // ScreenUtil applied

                            // Addon options section
                            addOn.addOnOptions.isEmpty
                                ? const Text("No options available.")
                                : Container(
                              width: 500.w, // ScreenUtil applied
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r), // ScreenUtil applied
                              ),
                              child: Column(
                                children: addOn.addOnOptions.asMap().entries.map((entry) {
                                  final option = entry.value;
                                  final index = entry.key;

                                  return Padding(
                                    padding: EdgeInsets.only(left: 12.w), // ScreenUtil applied
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              option.title,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.sp, // ScreenUtil applied
                                                color: Color(0xFF020711),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                // Update the checked value on tap
                                                option.checked = !option.checked!;
                                                controller.update();
                                              },
                                              child: Radio(
                                                value: option.checked!,
                                                groupValue: true,
                                                onChanged: (bool? value) {
                                                  option.checked = value!;
                                                  controller.update();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        option.price != 0.0
                                            ? Text(
                                          "+\$${option.price}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp, // ScreenUtil applied
                                            color: Color(0xFF6F7E8D),
                                          ),
                                        )
                                            : SizedBox.shrink(),

                                        if (index < addOn.addOnOptions.length - 1)
                                          Divider(color: Color(0xFFEAECED), thickness: 1),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    );
                  }),
                  SizedBox(height: 10.h), // ScreenUtil applied
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h), // ScreenUtil applied
          child: GradientButton(
            onPressed: () {},
            text: "Follow",
            colors: [Color(0xFFD62828), Color(0xFFC21414)],
            borderRadius: 12.r, // ScreenUtil applied
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/images/ProductDetails/Cart.png"),
                SizedBox(width: 10.w), // ScreenUtil applied
                Text(
                  "Add 1 to Cart \$5.29",
                  style: TextStyle(fontSize: 17.5.sp, fontWeight: FontWeight.w500, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
