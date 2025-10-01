import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';

import '../../Search/views/search_view.dart';
import '../controllers/discover_controller.dart';
import 'discover_filter_view.dart';

class DiscoverMapView extends GetView<DiscoverController> {
  const DiscoverMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.error.value != null) {
        return Center(child: Text(controller.error.value!));
      }

      final center = controller.mapCenter.value;
      final nearby = controller.nearbyPins;

      return Stack(
        children: [
          // Map
          FlutterMap(
            options: MapOptions(
              initialCenter: center,
              initialZoom: controller.mapZoom.value,
              interactionOptions: const InteractionOptions(flags: ~InteractiveFlag.rotate),
            ),
            children: [
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c'],
                // Consider attribution widget in UI for OSM
              ),
              if (controller.userLocation.value != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: controller.userLocation.value!,
                      width: 30,
                      height: 30,
                      child: const Icon(Icons.my_location, size: 28, color: Colors.blue),
                    )
                  ],
                ),
              // Vendor pins
              MarkerLayer(
                markers: nearby.map((pin) {
                  final logo = pin.vendor.logoImage;
                  return Marker(
                    point: pin.position,
                    width: 56,
                    height: 72,
                    alignment: Alignment.topCenter,
                    child: GestureDetector(
                      onTap: () {
                        _showVendorBottomSheet(context, pin);
                      },
                      child: Column(
                        children: [
                          // Logo bubble
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 6)],
                            ),
                            padding: const EdgeInsets.all(2),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: (logo != null && logo.isNotEmpty)
                                  ? NetworkImage(logo)
                                  : const AssetImage('assets/images/placeholder_logo.png') as ImageProvider,
                              backgroundColor: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Icon(Icons.location_on, color: Colors.red, size: 24),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          // Your top bar UI kept but simplified to match your earlier layout
          Positioned(
            left: 0.w,
            right: 0.w,
            top: 0.h,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.transparent,
                  ],
                  begin: AlignmentGeometry.topCenter,
                  end: AlignmentGeometry.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Location label
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Text('Location', style: TextStyle(color: const Color(0xFF6F7E8D), fontSize: 12.sp)),
                            SizedBox(width: 4.w),
                            Icon(Icons.keyboard_arrow_down, size: 14.sp, color: const Color(0xFF6F7E8D)),
                          ]),
                          SizedBox(height: 6.h),
                          Row(children: [
                            const Icon(Icons.location_pin, color: Color(0xFFD62828)),
                            SizedBox(width: 8.w),
                            Text('Near you', style: TextStyle(color: const Color(0xFF020711), fontSize: 16.sp, fontWeight: FontWeight.w500)),
                          ]),
                        ],
                      ),

                      Row(children: [
                        GestureDetector(
                          onTap: () => Get.to(const SearchView()),
                          child: const Icon(Icons.search),
                        ),
                        SizedBox(width: 16.w),
                        GestureDetector(
                          onTap: () => Get.dialog(const DiscoverFilterView()),
                          child: const Icon(Icons.tune),
                        ),
                        SizedBox(width: 16.w),
                        GestureDetector(
                          onTap: () { if (controller.isMap.value) controller.isMap.value = false; },
                          child: const Icon(Icons.view_list_rounded),
                        ),
                      ]),
                    ],
                  ),

                  SizedBox(height: 20.h,),

                  Obx(() {
                    return Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: Color(0xFFF1F3F4),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (!controller.isDelivery.value) {
                                controller.isDelivery.value = !controller.isDelivery.value;
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                              decoration: BoxDecoration(
                                color: controller.isDelivery.value ? Color(0xFFD62828) : Colors.transparent,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: SizedBox(
                                width: 161.w,
                                child: Center(
                                  child: Text(
                                    'Delivery',
                                    style: TextStyle(
                                      color: controller.isDelivery.value ? Colors.white : Color(0xFF6F7E8D),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              if (controller.isDelivery.value) {
                                controller.isDelivery.value = !controller.isDelivery.value;
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                              decoration: BoxDecoration(
                                color: !controller.isDelivery.value ? Color(0xFFD62828) : Colors.transparent,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: SizedBox(
                                width: 161.w,
                                child: Center(
                                  child: Text(
                                    'Pickup',
                                    style: TextStyle(
                                      color: !controller.isDelivery.value ? Colors.white : Color(0xFF6F7E8D),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  SizedBox(height: 40.h,),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  void _showVendorBottomSheet(BuildContext context, VendorPin pin) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            CircleAvatar(
              radius: 22,
              backgroundImage: (pin.vendor.logoImage != null && pin.vendor.logoImage!.isNotEmpty)
                  ? NetworkImage(pin.vendor.logoImage!)
                  : const AssetImage('assets/images/placeholder_logo.png') as ImageProvider,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(pin.vendor.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            ),
            Text('${pin.distanceKm.toStringAsFixed(2)} km', style: const TextStyle(color: Colors.grey)),
          ]),
          const SizedBox(height: 8),
          Text(pin.vendor.address, style: const TextStyle(color: Colors.black87)),
          const SizedBox(height: 12),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: navigate to vendor details
                  Get.back();
                },
                icon: const Icon(Icons.storefront),
                label: const Text('View details'),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () {
                  // Optional: open in maps via url_launcher
                },
                icon: const Icon(Icons.directions),
                label: const Text('Directions'),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ]),
      ),
    );
  }
}
