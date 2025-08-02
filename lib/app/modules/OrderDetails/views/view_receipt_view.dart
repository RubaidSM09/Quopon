import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/customTextButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil

class ViewReceiptView extends GetView {
  const ViewReceiptView({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          height: 632.h, // ScreenUtil applied
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h), // ScreenUtil applied
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)), // ScreenUtil applied
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
                height: 80.h, // ScreenUtil applied
                width: 80.w,  // ScreenUtil applied
              ),
              SizedBox(height: 17.h), // ScreenUtil applied
              Text(
                'Payment Successful',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)), // ScreenUtil applied
              ),
              SizedBox(height: 17.h), // ScreenUtil applied

              DottedLine(
                dashColor: Color(0xFFEAECED),
                lineThickness: 1.0,
                dashLength: 6.0,
                dashGapLength: 6.0,
              ),

              SizedBox(height: 17.h), // ScreenUtil applied

              Row(
                children: [
                  Text(
                    'Payment Details',
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)), // ScreenUtil applied
                  ),
                  SizedBox.shrink(),
                ],
              ),
              SizedBox(height: 10.h), // ScreenUtil applied
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 110.w, // ScreenUtil applied
                    child: Text(
                      'Invoice Number',
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Color(0xFF020711)), // ScreenUtil applied
                  ),
                  SizedBox(
                    width: 170.w, // ScreenUtil applied
                    child: Text(
                      textAlign: TextAlign.left,
                      'S564 F5677 G6412',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Color(0xFF020711)), // ScreenUtil applied
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h), // ScreenUtil applied
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 110.w, // ScreenUtil applied
                    child: Text(
                      'Order Time',
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Color(0xFF020711)), // ScreenUtil applied
                  ),
                  SizedBox(
                    width: 170.w, // ScreenUtil applied
                    child: Text(
                      textAlign: TextAlign.left,
                      '01: 09 AM, 20 June, 2025',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Color(0xFF020711)), // ScreenUtil applied
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h), // ScreenUtil applied
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 110.w, // ScreenUtil applied
                    child: Text(
                      'Payment Method',
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Color(0xFF020711)), // ScreenUtil applied
                  ),
                  SizedBox(
                    width: 170.w, // ScreenUtil applied
                    child: Text(
                      textAlign: TextAlign.left,
                      'PayPal',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Color(0xFF020711)), // ScreenUtil applied
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h), // ScreenUtil applied
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 110.w, // ScreenUtil applied
                    child: Text(
                      'Payment Status',
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Color(0xFF020711)), // ScreenUtil applied
                  ),
                  SizedBox(
                    width: 170.w, // ScreenUtil applied
                    child: Text(
                      textAlign: TextAlign.left,
                      'Successful',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Color(0xFF020711)), // ScreenUtil applied
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h), // ScreenUtil applied
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 110.w, // ScreenUtil applied
                    child: Text(
                      'Amount',
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Color(0xFF020711)), // ScreenUtil applied
                  ),
                  SizedBox(
                    width: 170.w, // ScreenUtil applied
                    child: Text(
                      textAlign: TextAlign.left,
                      '\$37.99',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Color(0xFF020711)), // ScreenUtil applied
                    ),
                  ),
                ],
              ),

              SizedBox(height: 17.h), // ScreenUtil applied

              DottedLine(
                dashColor: Color(0xFFEAECED),
                lineThickness: 1.0,
                dashLength: 6.0,
                dashGapLength: 6.0,
              ),

              SizedBox(height: 17.h), // ScreenUtil applied

              Row(
                children: [
                  Text(
                    'Product Details',
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)), // ScreenUtil applied
                  ),
                  SizedBox.shrink(),
                ],
              ),
              SizedBox(height: 10.h), // ScreenUtil applied
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 110.w, // ScreenUtil applied
                    child: Text(
                      'Italian Panini x2',
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Color(0xFF020711)), // ScreenUtil applied
                  ),
                  SizedBox(
                    width: 170.w, // ScreenUtil applied
                    child: Text(
                      textAlign: TextAlign.left,
                      '\$9.00',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Color(0xFF020711)), // ScreenUtil applied
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h), // ScreenUtil applied
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 110.w, // ScreenUtil applied
                    child: Text(
                      'Delivery Charges',
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Color(0xFF020711)), // ScreenUtil applied
                  ),
                  SizedBox(
                    width: 170.w, // ScreenUtil applied
                    child: Text(
                      textAlign: TextAlign.left,
                      '\$1.99',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Color(0xFF020711)), // ScreenUtil applied
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h), // ScreenUtil applied
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 110.w, // ScreenUtil applied
                    child: Text(
                      'Total Amount',
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xFF6F7E8D)), // ScreenUtil applied
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Color(0xFF020711)), // ScreenUtil applied
                  ),
                  SizedBox(
                    width: 170.w, // ScreenUtil applied
                    child: Text(
                      textAlign: TextAlign.left,
                      '\$37.99',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Color(0xFF020711)), // ScreenUtil applied
                    ),
                  ),
                ],
              ),

              SizedBox(height: 17.h), // ScreenUtil applied

              DottedLine(
                dashColor: Color(0xFFEAECED),
                lineThickness: 1.0,
                dashLength: 6.0,
                dashGapLength: 6.0,
              ),

              SizedBox(height: 17.h), // ScreenUtil applied

              GradientButton(
                onPressed: () {},
                text: "Get PDF Receipt",
                colors: [Color(0xFFF4F5F6), Color(0xFFEEF0F3)],
                height: 52.h, // ScreenUtil applied
                borderRadius: 12.r, // ScreenUtil applied
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                        'assets/images/OrderDetails/Download.png'
                    ),
                    SizedBox(width: 5.w), // ScreenUtil applied
                    Text(
                      "Get PDF Receipt",
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Color(0xFF020711)), // ScreenUtil applied
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
