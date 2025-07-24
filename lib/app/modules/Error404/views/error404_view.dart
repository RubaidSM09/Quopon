import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quopon/common/customTextButton.dart';

import '../../Error404/controllers/error404_controller.dart';

class Error404View extends GetView<Error404Controller> {
  const Error404View({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/404/Illustration.png',
            ),
            SizedBox(height: 30,),
            Text(
              'Oops! We can’t find that page',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28, color: Color(0xFF020711)),
            ),
            Text(
              'The page you’re looking for doesn’t exist or may have been moved. Try refreshing or return to the homepage.',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Color(0xFF6F7E8D)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30,),
            GradientButton(
              text: 'Refresh Page',
              onPressed: () {
                
              },
              colors: [Color(0xFFF4F5F6), Color(0xFFEEF0F3)],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/404/Refresh.png"),
                  SizedBox(width: 10,),
                  Text(
                    "Refresh Page",
                    style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.w500, color: Color(0xFF020711)),
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),
            GradientButton(
              text: 'Back to Home',
              onPressed: () {

              },
              colors: [Color(0xFFD62828), Color(0xFFC21414)],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/404/Home.png"),
                  SizedBox(width: 10,),
                  Text(
                    "Back to Home",
                    style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.w500, color: Colors.white),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
