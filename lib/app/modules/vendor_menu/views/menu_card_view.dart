import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quopon/app/modules/vendor_menu/views/menu_options_view.dart';

class MenuCardView extends GetView {
  final String image;
  final String title;
  final String description;
  final double price;

  const MenuCardView({
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    super.key
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 12, left: 8, top: 8, bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16)],
      ),
      child: Row(
        children: [
          Container(
            height: 88,
            width: 88,
            decoration: BoxDecoration(
              color: Color(0xFFF4F6F7),
              borderRadius: BorderRadius.circular(8)
            ),
            child: Image.asset(
              image,
            ),
          ),
          SizedBox(width: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 218,
                    child: Text(
                      title,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color(0xFF020711)
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.bottomSheet(MenuOptionsView());
                    },
                    child: Icon(Icons.more_vert,),
                  )
                ],
              ),
              SizedBox(
                // height: 32,
                width: 230,
                child: Text(
                  description,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xFF6F7E8D),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Text(
                '\$$price',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Color(0xFFD62828)
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
