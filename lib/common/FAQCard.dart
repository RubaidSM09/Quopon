import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class FAQCard extends GetView {
  final String title;
  final String description;
  final bool isPlus;

  const FAQCard({
    required this.title,
    required this.description,
    this.isPlus = false,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    RxBool isExtented = isPlus.obs;
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 16, color: Colors.black.withAlpha(41))
          ],
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF020711)),
                ),
                isExtented.value ?
                GestureDetector(
                  onTap: () {
                    isExtented.value = false;
                  },
                  child: Icon(Icons.minimize),
                ) :
                GestureDetector(
                  onTap: () {
                    isExtented.value = true;
                  },
                  child: Icon(Icons.add),
                )
              ],
            ),
            isExtented.value ? SizedBox(height: 5,) : SizedBox.shrink(),
            isExtented.value ?
            Text(
              description,
              style: TextStyle(fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6F7E8D)),
            ) :
            SizedBox.shrink(),
          ],
        ),
      );
    });
  }

}