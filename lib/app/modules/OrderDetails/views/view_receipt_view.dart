import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common/customTextButton.dart';

class ViewReceiptView extends GetView {
  const ViewReceiptView({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 632,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          image: DecorationImage(
            image: AssetImage('assets/images/OrderDetails/PaymentSuccessContainer.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox.shrink(),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.close),
                ),
              ],
            ),
            Image.asset(
              'assets/images/OrderDetails/Receipt.gif',
              height: 80,
              width: 80,
            ),
            SizedBox(height: 17,),
            Text(
              'Payment Successful',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
            ),

            SizedBox(height: 17,),

            DottedLine(
              dashColor: Color(0xFFEAECED),
              lineThickness: 1.0,
              dashLength: 6.0,
              dashGapLength: 6.0,
            ),

            SizedBox(height: 17,),

            Row(
              children: [
                Text(
                  'Payment Details',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                ),
                SizedBox.shrink(),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 110,
                  child: Text(
                    'Invoice Number',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                  ),
                ),
                Text(
                  ':',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFF020711)),
                ),
                SizedBox(
                  width: 170,
                  child: Text(
                    textAlign: TextAlign.left,
                    'S564 F5677 G6412',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFF020711)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 110,
                  child: Text(
                    'Order Time',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                  ),
                ),
                Text(
                  ':',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFF020711)),
                ),
                SizedBox(
                  width: 170,
                  child: Text(
                    textAlign: TextAlign.left,
                    '01: 09 AM, 20 June, 2025',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFF020711)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 110,
                  child: Text(
                    'Payment Method',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                  ),
                ),
                Text(
                  ':',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFF020711)),
                ),
                SizedBox(
                  width: 170,
                  child: Text(
                    textAlign: TextAlign.left,
                    'PayPal',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFF020711)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 110,
                  child: Text(
                    'Payment Status',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                  ),
                ),
                Text(
                  ':',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFF020711)),
                ),
                SizedBox(
                  width: 170,
                  child: Text(
                    textAlign: TextAlign.left,
                    'Successful',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFF020711)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 110,
                  child: Text(
                    'Amount',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                  ),
                ),
                Text(
                  ':',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFF020711)),
                ),
                SizedBox(
                  width: 170,
                  child: Text(
                    textAlign: TextAlign.left,
                    '\$37.99',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFF020711)),
                  ),
                ),
              ],
            ),

            SizedBox(height: 17,),

            DottedLine(
              dashColor: Color(0xFFEAECED),
              lineThickness: 1.0,
              dashLength: 6.0,
              dashGapLength: 6.0,
            ),

            SizedBox(height: 17,),

            Row(
              children: [
                Text(
                  'Product Details',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                ),
                SizedBox.shrink(),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 110,
                  child: Text(
                    'Italian Panini x2',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                  ),
                ),
                Text(
                  ':',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFF020711)),
                ),
                SizedBox(
                  width: 170,
                  child: Text(
                    textAlign: TextAlign.left,
                    '\$9.00',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFF020711)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 110,
                  child: Text(
                    'Delivery Charges',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                  ),
                ),
                Text(
                  ':',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFF020711)),
                ),
                SizedBox(
                  width: 170,
                  child: Text(
                    textAlign: TextAlign.left,
                    '\$1.99',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFF020711)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 110,
                  child: Text(
                    'Total Amount',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)),
                  ),
                ),
                Text(
                  ':',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFF020711)),
                ),
                SizedBox(
                  width: 170,
                  child: Text(
                    textAlign: TextAlign.left,
                    '\$37.99',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFF020711)),
                  ),
                ),
              ],
            ),

            SizedBox(height: 17,),

            DottedLine(
              dashColor: Color(0xFFEAECED),
              lineThickness: 1.0,
              dashLength: 6.0,
              dashGapLength: 6.0,
            ),

            SizedBox(height: 17,),

            GradientButton(
              onPressed: () {

              },
              text: "Get PDF Receipt",
              colors: [Color(0xFFF4F5F6), Color(0xFFEEF0F3)],
              width: 366,
              height: 44,
              borderRadius: 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                      'assets/images/OrderDetails/Download.png'
                  ),
                  SizedBox(width: 5,),
                  Text(
                    "Get PDF Receipt",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
