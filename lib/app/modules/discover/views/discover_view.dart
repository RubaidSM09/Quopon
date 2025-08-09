import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quopon/app/modules/discover/views/discover_list_view.dart';
import 'package:quopon/app/modules/discover/views/discover_map_view.dart';

import '../controllers/discover_controller.dart';

class DiscoverView extends GetView<DiscoverController> {
  const DiscoverView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(DiscoverController());

    return Scaffold(
      backgroundColor: Color(0xFFF9FBFC),
      body: Obx(() {
        return controller.isMap.value ? DiscoverMapView() : DiscoverListView();
      }),
    );
  }
}
