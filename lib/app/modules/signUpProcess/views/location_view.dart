import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:quopon/common/custom_textField.dart';

import '../controllers/sign_up_process_controller.dart';

class LocationScreen extends GetView<SignUpProcessController> {
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const LocationScreen({super.key, required this.onNext, required this.onSkip});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final pos = controller.marker.value ?? const LatLng(51.4769, 0.0005);

      return Stack(
        children: [
          // ======= MAP AREA (fills the same container you had) =======
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: pos,
                  initialZoom: 16,
                  onTap: (tapPosition, latLng) => controller.onMapTap(latLng),
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: const ['a', 'b', 'c'],
                    userAgentPackageName: 'com.quopon.app',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: pos,
                        width: 40.w,
                        height: 40.h,
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/images/Location/Mark Location Icon.png',
                          color: Colors.red,
                          width: 40.w,
                          height: 40.h,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ======= YOUR BOTTOM SHEET (UNCHANGED LOOK) =======
          Positioned(
            top: 518.h,
            child: Container(
              width: 430.w,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 24, offset: Offset(0, -4.h)),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Set Your Location',
                      style: TextStyle(color: const Color(0xFF020711), fontSize: 18.sp, fontWeight: FontWeight.w500)),
                  SizedBox(height: 16.h),
                  const Divider(color: Color(0xFFEAECED), thickness: 1),
                  SizedBox(height: 16.h),

                  // Address field (readOnly; auto-fills after tap)
                  GetInTouchTextField(
                    headingText: 'Address',
                    fieldText: '9 Victoria Road London SE73 1XL',
                    iconImagePath: 'assets/images/Location/Address.png',
                    controller: controller.addressController,
                    isRequired: false,
                    readOnly: true,
                    suffix: Obx(() => controller.isGeocoding.value
                        ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                        : const SizedBox.shrink()),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
