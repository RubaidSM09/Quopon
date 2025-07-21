import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemCard extends GetView {
  final String title;
  final double price;
  final double calory;
  final String description;
  final String? image;

  const ItemCard({
    required this.title,
    required this.price,
    required this.calory,
    required this.description,
    this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF020711)),
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Text(
                      "\$$price",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF020711)),
                    ),
                    SizedBox(width: 10,),
                    CircleAvatar(
                      radius: 2.5,
                      backgroundColor: Color(0xFFCAD9E8),
                    ),
                    SizedBox(width: 10,),
                    Text(
                      "$calory Cal",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                SizedBox(
                  width: 278,
                  child: Text(
                    description,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    image!,
                    width: 84,
                    height: 84,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Color(0x87000000),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        SizedBox(height: 10,),
        Divider(
          color: Color(0xFFEAECED),
          thickness: 1,
        ),
      ],
    );
  }

}