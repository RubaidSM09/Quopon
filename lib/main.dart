import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/Profile/controllers/profile_controller.dart';

import 'app/routes/app_pages.dart';
import 'app/services/notification_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().initializeNotifications();
  runApp(
    ScreenUtilInit(
      designSize: Size(430, 932),  // Define the design size of your app (e.g., 375x812 for iPhone X)
      minTextAdapt: true,           // Allows text scaling based on screen size
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: "Application",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          debugShowCheckedModeBanner: false,
        );
      },
    ),
  );
}
