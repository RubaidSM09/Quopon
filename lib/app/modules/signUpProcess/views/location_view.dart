import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quopon/common/custom_textField.dart';

import '../../signUpProcess/views/food_preferences_view.dart';

class LocationScreen extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onSkip;

  LocationScreen({required this.onNext, required this.onSkip});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  TextEditingController _addressController = TextEditingController(
    text: '9 Victoria Road London SE73 1XL',
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Stack(
            children: [
              // Map background pattern
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.grey[50],
                ),
              ),
              // Streets pattern (simplified)
              Positioned.fill(
                child: CustomPaint(
                  painter: MapPainter(),
                ),
              ),
              // Location pin
              Center(
                child: Image.asset(
                  'assets/images/Location/Mark Location Icon.png',
                  color: Colors.red,
                  height: 40.h,
                  width: 40.w,
                ),
              ),
              // Street names
              Positioned(
                top: 100.h,
                left: 50.w,
                child: Text(
                  'Oak Lane',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12.sp,
                  ),
                ),
              ),
              Positioned(
                top: 50.h,
                right: 50.w,
                child: Text(
                  'Victoria Road',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
        ),

        Positioned(
          top: 488.h,
          child: Container(
            width: 430.w,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 24, offset: Offset(0, -4.h))]
            ),
            child: Column(
              children: [
                Text(
                  'Set Your Location',
                  style: TextStyle(color: Color(0xFF020711), fontSize: 18.sp, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 16.h,),
                Divider(color: Color(0xFFEAECED), thickness: 1,),
                SizedBox(height: 16.h,),
                GetInTouchTextField(
                  headingText: 'Address',
                  fieldText: '9 Victoria Road London SE73 1XL',
                  iconImagePath: 'assets/images/Location/Address.png',
                  controller: _addressController,
                  isRequired: false,
                )
              ],
            ),
          ),
        )
      ],
    );

    /*return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                // Map placeholder
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      children: [
                        // Map background pattern
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[50],
                          ),
                        ),
                        // Streets pattern (simplified)
                        Positioned.fill(
                          child: CustomPaint(
                            painter: MapPainter(),
                          ),
                        ),
                        // Location pin
                        Center(
                          child: Image.asset(
                            'assets/images/Location/Mark Location Icon.png',
                            color: Colors.red,
                            height: 40,
                            width: 40,
                          ),
                        ),
                        // Street names
                        Positioned(
                          bottom: 100,
                          left: 50,
                          child: Text(
                            'Oak Lane',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 50,
                          right: 50,
                          child: Text(
                            'Victoria Road',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Set Your Location',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Address',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.grey[600],
                            size: 20,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _addressController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter your address',
                                hintStyle: TextStyle(color: Colors.grey[500]),
                              ),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );*/
  }
}

class MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 2.w
      ..style = PaintingStyle.stroke;

    // Draw some simple street-like lines
    canvas.drawLine(
      Offset(0, size.height * 0.3),
      Offset(size.width, size.height * 0.3),
      paint,
    );
    canvas.drawLine(
      Offset(0, size.height * 0.7),
      Offset(size.width, size.height * 0.7),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.3, 0),
      Offset(size.width * 0.3, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.7, 0),
      Offset(size.width * 0.7, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}