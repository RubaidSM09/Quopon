import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DeliveryCostModel {
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController deliveryFeeController = TextEditingController();
  TextEditingController minOrderController = TextEditingController();
}

class DeliveryCostController extends GetxController {
  var deliveryCosts = <DeliveryCostModel>[DeliveryCostModel()].obs;

  void addCost() {
    deliveryCosts.add(DeliveryCostModel());
  }

  void removeCost(int index) {
    if (deliveryCosts.length > 1) {
      deliveryCosts.removeAt(index);
    }
  }
}

class DeliveryCostForm extends StatelessWidget {
  final DeliveryCostController controller = Get.put(DeliveryCostController());
  final String zipCode;
  final double deliveryFee;
  final double minOrderAmount;

  DeliveryCostForm({
    this.zipCode = 'Zip Code',
    this.deliveryFee = 0.00,
    this.minOrderAmount = 00,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "Delivery Costs",
            style: TextStyle(
              fontSize: 16.sp,  // Use ScreenUtil for font size
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
        Obx(() => Column(
          children: List.generate(
            controller.deliveryCosts.length,
                (index) => _buildRow(controller.deliveryCosts[index], index),
          ),
        )),
        GestureDetector(
          onTap: controller.addCost,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: Color(0xFFF2F4F5),
              border: Border.all(
                color: Colors.grey.shade400,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                "+  Add Another",
                style: TextStyle(color: Color(0xFF020711), fontSize: 14.sp, fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRow(DeliveryCostModel model, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: _buildTextField(
              controller: model.zipCodeController,
              label: "Zip Code",
              hint: zipCode,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildTextField(
              controller: model.deliveryFeeController,
              label: "Delivery Fee",
              hint: "€ $deliveryFee",
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildTextField(
              controller: model.minOrderController,
              label: "Min Order Amount",
              hint: "€ $minOrderAmount",
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => controller.removeCost(index),
            child: Container(
              padding: EdgeInsets.all(8.w),
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: Color(0xFFFDF4F4),
                borderRadius: BorderRadius.circular(10.r)
              ),
              child: Center(
                child: Icon(Icons.delete, color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    String? prefix,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,  // Use ScreenUtil for font size
                fontWeight: FontWeight.w500,
                color: Color(0xFF6F7E8D),
              ),
            ),
            SizedBox.shrink(),
          ],
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFF4F6F7),
            hintText: hint,
            hintStyle: TextStyle(
              color: Color(0xFF8F9EAD),
              fontWeight: FontWeight.w400,
              fontSize: 14.sp
            ),
            prefixText: prefix,
            isDense: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFEAECED)),
              borderRadius: BorderRadius.circular(10.r)
            )
          ),
        ),
      ],
    );
  }
}