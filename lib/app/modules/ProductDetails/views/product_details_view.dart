import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quopon/app/data/model/menu_item.dart' show Modifier, ModifierOption; // <<< use modifiers model
import '../../../../common/customTextButton.dart';
import '../../VendorProfile/controllers/vendor_profile_controller.dart';
import '../controllers/product_details_controller.dart';

class ProductDetailsView extends GetView<VendorProfileController> {
  final int id;
  final String title;
  final double price;
  final int calory;
  final String description;
  final String? image;

  const ProductDetailsView({
    required this.id,
    required this.title,
    required this.price,
    required this.calory,
    required this.description,
    this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Use an internal controller to keep selections & total
    final productController = Get.put(ProductDetailsController(), tag: 'pd_$id');

    // Find the full menu item (so we can render its modifiers)
    // We search the menus already fetched into VendorProfileController.
    final allItems = controller.menusByCategory.values.expand((e) => e).toList();
    final menuItem = allItems.firstWhereOrNull((m) => m.id == id);

    // Initialize selections once (idempotent)
    if (!productController.initialized) {
      productController.init(
        basePrice: price,
        modifiers: menuItem?.modifiers ?? const <Modifier>[],
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ---------- Hero Image ----------
            Container(
              height: 264.h,
              decoration: BoxDecoration(
                color: const Color(0xFFF6E7D8),
                image: image != null && image!.isNotEmpty
                    ? DecorationImage(image: NetworkImage(image!), fit: BoxFit.cover)
                    : null,
              ),
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
                          onTap: Get.back,
                          child: Icon(Icons.arrow_back, size: 24.sp),
                        ),
                        Image.asset("assets/images/MyDealsDetails/Upload.png", width: 40.w, height: 40.h),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // ---------- Details ----------
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + Base Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                          color: const Color(0xFF020711),
                        ),
                      ),
                      Obx(() => Text(
                        // show LIVE total in header too if you want; else keep base:
                        "\$${productController.totalPrice.value.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                          color: const Color(0xFFD62828),
                        ),
                      )),
                    ],
                  ),

                  SizedBox(height: 16.h),
                  Text(
                    description,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: const Color(0xFF6F7E8D),
                    ),
                  ),
                  const Divider(color: Color(0xFFEAECED), thickness: 1),

                  // ---------- MODIFIERS ----------
                  // (keeps your layout; renders just like your commented block intended)
                  if ((menuItem?.modifiers ?? []).isNotEmpty)
                    ..._buildModifiers(menuItem!.modifiers, productController)
                  else
                    SizedBox(height: 10.h),

                ],
              ),
            ),
          ],
        ),
      ),

      // ---------- Bottom Button ----------
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
          child: GradientButton(
            onPressed: () async {
              // Validate required modifiers
              final missing = productController.validateRequiredSelections();
              if (missing.isNotEmpty) {
                Get.snackbar(
                  'Selection required',
                  'Please choose: ${missing.join(", ")}',
                  snackPosition: SnackPosition.BOTTOM,
                );
                return;
              }

              // Example: call your addToCart with selected modifiers payload
              final ok = await productController.addToCart(
                menuItemId: id,
                quantity: 1,
                specialInstructions: '',
              );
              if (ok) Get.back();
            },
            text: "Follow",
            colors: const [Color(0xFFD62828), Color(0xFFC21414)],
            borderRadius: 12.r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/ProductDetails/Cart.png"),
                SizedBox(width: 10.w),
                Obx(() => Text(
                  "Add 1 to Cart \$${productController.totalPrice.value.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 17.5.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------- UI builders ----------
  List<Widget> _buildModifiers(
      List<Modifier> modifiers, ProductDetailsController productController) {
    final widgets = <Widget>[];
    for (int mIdx = 0; mIdx < modifiers.length; mIdx++) {
      final mod = modifiers[mIdx];

      widgets.add(SizedBox(height: 20.h));
      widgets.add(
        Row(
          children: [
            Text(
              mod.name,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
                color: const Color(0xFF020711),
              ),
            ),
            if (mod.isRequired)
              Text(
                " *",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,
                  color: const Color(0xFFD62828),
                ),
              ),
          ],
        ),
      );
      widgets.add(SizedBox(height: 6.h));

      // Options container (keeps your style)
      if (mod.options.isEmpty) {
        widgets.add(const Text("No options available."));
        continue;
      }

      widgets.add(
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Obx(() {
            final selected = productController.selectedByModifier[mIdx];
            return Column(
              children: mod.options.asMap().entries.map((entry) {
                final index = entry.key;
                final option = entry.value;

                final isSelected = selected == index;

                return Padding(
                  padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row: title + selector
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Option title
                          Expanded(
                            child: Text(
                              option.title,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                                color: const Color(0xFF020711),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // Custom round selector (single-select per modifier)
                          GestureDetector(
                            onTap: () => productController.selectOption(
                              modifierIndex: mIdx,
                              optionIndex: index,
                              optionPrice: option.price,
                            ),
                            child: Container(
                              width: 18.w,
                              height: 18.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected ? const Color(0xFFD62828) : Colors.transparent,
                                border: Border.all(color: const Color(0xFFDADCDD), width: 1.3),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Price hint (if > 0)
                      option.price != null && option.price! > 0
                          ? Text(
                        "+\$${option.price!.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: const Color(0xFF6F7E8D),
                        ),
                      )
                          : const SizedBox.shrink(),

                      // Divider between options
                      if (index < mod.options.length - 1)
                        const Divider(color: Color(0xFFEAECED), thickness: 1),
                    ],
                  ),
                );
              }).toList(),
            );
          }),
        ),
      );
    }
    widgets.add(SizedBox(height: 10.h));
    return widgets;
  }
}
