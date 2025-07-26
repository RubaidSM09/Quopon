import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DashboardView extends GetView {
  final String title;
  final int count;
  final bool isRate;
  final bool isImproved;
  final double change;

  const DashboardView({
    required this.title,
    required this.count,
    this.isRate = false,
    required this.isImproved,
    required this.change,
    super.key
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 16)]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xFF6F7E8D)),
          ),
          SizedBox(height: 15,),
          isRate ?
          Text(
            '$count %',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24, color: Color(0xFF020711)),
          ) :
          Text(
            NumberFormat.decimalPattern().format(count),
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24, color: Color(0xFF020711)),
          ),
          SizedBox(height: 15,),
          Row(
            children: [
              Row(
                children: [
                  isImproved ?
                  Icon(
                    Icons.arrow_upward,
                    size: 14,
                    color: Color(0xFF2ECC71),
                  ) :
                  Icon(
                    Icons.arrow_downward,
                    size: 14,
                    color: Color(0xFFD62828),
                  ),
                  Text(
                    '12.8%',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: isImproved ? Color(0xFF2ECC71) : Color(0xFFD62828)),
                  ),
                ],
              ),
              SizedBox(width: 40,),
              Text(
                'This month',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xFF6F7E8D)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
