import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quopon/common/FAQCard.dart';

import '../controllers/support_f_a_q_controller.dart';

class FaqView extends GetView<SupportFAQController> {
  const FaqView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(SupportFAQController());

    return Column(
      children: [
        for (var i = 0; i < controller.faqs.length; i++) ...[
          FAQCard(
            title: controller.faqs[i].question,
            description: controller.faqs[i].answer,
            // Keep your plus style if you want (e.g., first item expanded)
            isPlus: i == 0,
          ),
          const SizedBox(height: 15),
        ],
      ],
    );
  }
}
