import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:quopon/common/red_button.dart';

class QRSuccessView extends StatelessWidget {
  final String dealTitle;
  final String dealStoreName;
  final String brandLogo;
  final String time;

  const QRSuccessView({
    super.key,
    required this.dealTitle,
    required this.dealStoreName,
    required this.brandLogo,
    required this.time,
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
                  Image.asset('assets/images/QR/confetti 1.png'),
                  SizedBox(height: 20),
                  Text('Congratulations! Deal Redeemed', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF020711), fontSize: 18, fontWeight: FontWeight.w500),),
                  SizedBox(height: 10),
                  Text('You\'ve successfully redeemed the deal at $dealStoreName', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF020711), fontSize: 14, fontWeight: FontWeight.w400),),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white
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
                                child: Image.asset(brandLogo, ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dealTitle,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Redeemed at ',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                      Icon(Icons.circle, color: Colors.grey[300], size: 12,),
                                      Text(
                                        ' $time',
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
                          SizedBox(height: 20,),
                          Container(
                            height: 40,
                            width: 334,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xFFECFDF5)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.check, color: Color(0xFF2ECC71), size: 16,),
                                SizedBox(width: 5,),
                                Text('Verified Redemption', style: TextStyle(color: Color(0xFF2ECC71), fontSize: 14, fontWeight: FontWeight.w400),)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  RedButton(buttonText: 'Done', onPressed: () { })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
