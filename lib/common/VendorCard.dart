import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class VendorCard extends GetView {
  final String brandLogo;
  final String dealStoreName;
  final String dealType;
  final int activeDeals;

  const VendorCard({
    required this.brandLogo,
    required this.dealStoreName,
    required this.dealType,
    required this.activeDeals,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10,),
        Row(
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
                  child: Image.asset(brandLogo, ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dealStoreName,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          dealType,
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFFD62828),
                          ),
                        ),
                        SizedBox(width: 8,),
                        Container(
                          height: 5,
                          width: 5,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFCAD9E8)
                          ),
                        ),
                        SizedBox(width: 8,),
                        Text(
                          "$activeDeals Active Deals",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () {

              },
              child: Container(
                width: 93,
                height: 32,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color(0xFFD62828)
                ),
                child: Center(
                  child: Text(
                    'View Profile',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 5,),
        Divider(
          color: Color(0xFFF0F2F3),
          thickness: 2,
        ),
      ],
    );
  }

}