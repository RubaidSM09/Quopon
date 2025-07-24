import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterCard extends GetView {
  final String filterName;

  const FilterCard({
    required this.filterName,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.white,
        boxShadow: [BoxShadow(blurRadius: 12, color: Colors.black.withAlpha(15))]
      ),
      child: Row(
        children: [
          Text(
            filterName,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
          ),
          SizedBox(width: 2.5,),
          Icon(Icons.keyboard_arrow_down, color: Color(0xFF6F7E8D),)
        ],
      ),
    );
  }

}