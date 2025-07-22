import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              height: 264,
              decoration: BoxDecoration(
                color: Color(0xFFF6E7D8),
                image: DecorationImage(
                  image: AssetImage(image!),
                  fit: BoxFit.cover,
                ),
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
                        Image.asset("assets/images/MyDealsDetails/Upload.png"),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Product description section
            Padding(
              padding: EdgeInsets.all(16),
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
                          fontSize: 20,
                          color: Color(0xFF020711),
                        ),
                      ),
                      Text(
                        "\$$price",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Color(0xFFD62828),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    description,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xFF6F7E8D),
                    ),
                  ),
                  Divider(color: Color(0xFFEAECED), thickness: 1),
                  SizedBox(height: 10),

                  // Addons section
                  Obx(() {
                    if (controller.itemAddOns.isEmpty) {
                      return const Text("No active add-ons available.");
                    }

                    double addOnHeight = 355;
                    double totalHeight = addOnHeight + 12;
                    double boxHeight = totalHeight * controller.itemAddOns.length;

                    return SizedBox(
                      height: boxHeight, // Adjust the height of this section
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: controller.itemAddOns.length,
                        // separatorBuilder: (context, index) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final addOn = controller.itemAddOns[index];
                          double addOnHeight = 58;
                          if(addOn.addOnOptions[index].price==0.0){
                            addOnHeight = 41;
                          }
                          double totalHeight = addOnHeight + 12;
                          double boxHeight = totalHeight * addOn.addOnOptions.length;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Text(
                                    addOn.addOnTitle,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Color(0xFF020711),
                                    ),
                                  ),
                                  if (addOn
                                      .addOnType) // Only add "*" if addOnType is true
                                    Text(
                                      "*",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: Color(0xFFD62828),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(height: 6),

                              // Addon options section
                              addOn.addOnOptions.isEmpty
                                  ? const Text("No options available.")
                                  : SizedBox(
                                      height: boxHeight,
                                      child: Center(
                                        child: Container(
                                          width: 500,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: ListView.separated(
                                            itemCount:
                                                addOn.addOnOptions.length,
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(width: 8),
                                            itemBuilder: (context, index) {
                                              final option =
                                                  addOn.addOnOptions[index];

                                              return Padding(
                                                padding: const EdgeInsets.all(
                                                  12.0,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          option.title,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14,
                                                            color: Color(
                                                              0xFF020711,
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            // Update the checked value on tap
                                                            option.checked =
                                                                !option
                                                                    .checked!;
                                                            controller.update();
                                                          },
                                                          child: Radio(
                                                            value:
                                                                option.checked!,
                                                            groupValue: true,
                                                            onChanged:
                                                                (bool? value) {
                                                                  option.checked =
                                                                      value!;
                                                                  controller
                                                                      .update();
                                                                },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    option.price != 0.0
                                                        ? Text(
                                                            "+\$${option.price}",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 14,
                                                              color: Color(
                                                                0xFF6F7E8D,
                                                              ),
                                                            ),
                                                          )
                                                        : SizedBox.shrink(),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          );
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
