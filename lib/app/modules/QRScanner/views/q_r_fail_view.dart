import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:quopon/common/red_button.dart';

import '../../../../common/customTextButton.dart';

class QRFailView extends StatelessWidget {

  const QRFailView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);  // Close the detail view on tapping outside
      },
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.0),
        body: Center(
          child: GestureDetector(
            onTap: () {}, // Prevent dismiss on card tap
            child: Container(
              /*height: 400,
              width: 350,*/
              width: 398,
              height: 450,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFF9FBFC),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/QR/no-data 1.png'),
                  SizedBox(height: 20),
                  Text('Oops! Something Went Wrong', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF020711), fontSize: 18, fontWeight: FontWeight.w500),),
                  SizedBox(height: 10),
                  Text('This QR code is invalid or expired.', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF020711), fontSize: 14, fontWeight: FontWeight.w400),),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xFFF7EEEF)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset('assets/images/QR/RedExclIcon.png'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Unable to process QR code',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFFD62828),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'The QR code might be expired or invalid. Please try\nscanning again or contact support if the issue persists.',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFFD62828),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  RedButton(buttonText: '⟳ Try Again', onPressed: () { }),
                  SizedBox(height: 10,),
                  GradientButton(text: "Contact Support", onPressed: () { }, colors: [Color(0xFFF4F5F6), Color(0xFFEEF0F3)], textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Color(0xFF020711)),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
