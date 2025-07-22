import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class CheckoutCard extends GetView {
  final String prefixIcon;
  final String title;
  final String subTitle;
  final String? suffixIcon;

  const CheckoutCard({
    required this.prefixIcon,
    required this.title,
    required this.subTitle,
    this.suffixIcon,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xFFF5F7F8),
                shape: BoxShape.circle
              ),
              child: ClipRRect(
                child: Image.asset(prefixIcon),
              ),
            ),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF020711)),
                ),
                Text(
                  subTitle,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                ),
              ],
            )
          ],
        ),
        suffixIcon != null ? IconButton(
          onPressed: () { }, 
          icon: Image.asset(suffixIcon!),
        ) : SizedBox.shrink(),
      ],
    );
  }

}