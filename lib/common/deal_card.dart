import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil

class DealCard extends StatefulWidget {
  final String brandLogo;
  final String dealStoreName;
  final String dealValidity;

  const DealCard({
    super.key,
    required this.brandLogo,
    required this.dealStoreName,
    required this.dealValidity,
  });

  @override
  State<DealCard> createState() => _DealCardState();
}

class _DealCardState extends State<DealCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.sp), // Apply ScreenUtil to borderRadius
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 10.sp,
          ),
        ],
      ),
      height: 76.h, // Apply ScreenUtil to height
      child: Padding(
        padding: EdgeInsets.all(16.sp), // Apply ScreenUtil to padding
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(widget.brandLogo),
                ),
                SizedBox(width: 10.w), // Apply ScreenUtil to SizedBox width
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.dealStoreName,
                      style: TextStyle(
                        fontSize: 14.sp, // Apply ScreenUtil to font size
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Valid Until: ',
                          style: TextStyle(
                            fontSize: 12.sp, // Apply ScreenUtil to font size
                            color: Color(0xFFD62828),
                          ),
                        ),
                        Text(
                          widget.dealValidity,
                          style: TextStyle(
                            fontSize: 12.sp, // Apply ScreenUtil to font size
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Container(
              width: 63.w, // Apply ScreenUtil to width
              height: 22.h, // Apply ScreenUtil to height
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.sp), // Apply ScreenUtil to borderRadius
                color: Color(0xFFD62828),
              ),
              child: Center(
                child: Text(
                  '50% OFF',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp, // Apply ScreenUtil to font size
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
