import 'package:get/get.dart';

class Vendor {
  final String brandLogo;
  final String dealStoreName;
  final String dealType;
  final int activeDeals;

  Vendor({
    required this.brandLogo,
    required this.dealStoreName,
    required this.dealType,
    required this.activeDeals,
  });
}

class FollowVendorsController extends GetxController {
  var vendorList = <Vendor>[].obs;

  @override
  void onInit() {
    super.onInit();

    vendorList.value = [
      Vendor(
        brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
        dealStoreName: 'Starbucks',
        dealType: 'Food & Beverage',
        activeDeals: 3,
      ),
      Vendor(
        brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
        dealStoreName: 'Starbucks',
        dealType: 'Food & Beverage',
        activeDeals: 3,
      ),
      Vendor(
        brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
        dealStoreName: 'Starbucks',
        dealType: 'Food & Beverage',
        activeDeals: 3,
      ),
      Vendor(
        brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
        dealStoreName: 'Starbucks',
        dealType: 'Food & Beverage',
        activeDeals: 3,
      ),
      Vendor(
        brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
        dealStoreName: 'Starbucks',
        dealType: 'Food & Beverage',
        activeDeals: 3,
      ),
      Vendor(
        brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
        dealStoreName: 'Starbucks',
        dealType: 'Food & Beverage',
        activeDeals: 3,
      ),
      Vendor(
        brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
        dealStoreName: 'Starbucks',
        dealType: 'Food & Beverage',
        activeDeals: 3,
      ),
      Vendor(
        brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
        dealStoreName: 'Starbucks',
        dealType: 'Food & Beverage',
        activeDeals: 3,
      ),
      Vendor(
        brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
        dealStoreName: 'Starbucks',
        dealType: 'Food & Beverage',
        activeDeals: 3,
      ),
      Vendor(
        brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
        dealStoreName: 'Starbucks',
        dealType: 'Food & Beverage',
        activeDeals: 3,
      ),
      Vendor(
        brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
        dealStoreName: 'Starbucks',
        dealType: 'Food & Beverage',
        activeDeals: 3,
      ),
      Vendor(
        brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
        dealStoreName: 'Starbucks',
        dealType: 'Food & Beverage',
        activeDeals: 3,
      ),
      Vendor(
        brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
        dealStoreName: 'Starbucks',
        dealType: 'Food & Beverage',
        activeDeals: 3,
      ),
      Vendor(
        brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
        dealStoreName: 'Starbucks',
        dealType: 'Food & Beverage',
        activeDeals: 3,
      ),
      Vendor(
        brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
        dealStoreName: 'Starbucks',
        dealType: 'Food & Beverage',
        activeDeals: 3,
      ),
      Vendor(
        brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
        dealStoreName: 'Starbucks',
        dealType: 'Food & Beverage',
        activeDeals: 3,
      ),
      Vendor(
        brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
        dealStoreName: 'Starbucks',
        dealType: 'Food & Beverage',
        activeDeals: 3,
      ),
      Vendor(
        brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
        dealStoreName: 'Starbucks',
        dealType: 'Food & Beverage',
        activeDeals: 3,
      ),
      Vendor(
        brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
        dealStoreName: 'Starbucks',
        dealType: 'Food & Beverage',
        activeDeals: 3,
      ),
      Vendor(
        brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
        dealStoreName: 'Starbucks',
        dealType: 'Food & Beverage',
        activeDeals: 3,
      ),
      Vendor(
        brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
        dealStoreName: 'Starbucks',
        dealType: 'Food & Beverage',
        activeDeals: 3,
      ),
      Vendor(
        brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
        dealStoreName: 'Starbucks',
        dealType: 'Food & Beverage',
        activeDeals: 3,
      ),
      Vendor(
        brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
        dealStoreName: 'Starbucks',
        dealType: 'Food & Beverage',
        activeDeals: 3,
      ),
      Vendor(
        brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
        dealStoreName: 'Starbucks',
        dealType: 'Food & Beverage',
        activeDeals: 3,
      ),
      Vendor(
        brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
        dealStoreName: 'Starbucks',
        dealType: 'Food & Beverage',
        activeDeals: 3,
      ),
      Vendor(
        brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
        dealStoreName: 'Starbucks',
        dealType: 'Food & Beverage',
        activeDeals: 3,
      ),
      Vendor(
        brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
        dealStoreName: 'Starbucks',
        dealType: 'Food & Beverage',
        activeDeals: 3,
      ),
      Vendor(
        brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
        dealStoreName: 'Starbucks',
        dealType: 'Food & Beverage',
        activeDeals: 3,
      ),
      Vendor(
        brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
        dealStoreName: 'Starbucks',
        dealType: 'Food & Beverage',
        activeDeals: 3,
      ),
      Vendor(
        brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
        dealStoreName: 'Starbucks',
        dealType: 'Food & Beverage',
        activeDeals: 3,
      ),
      Vendor(
        brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
        dealStoreName: 'Starbucks',
        dealType: 'Food & Beverage',
        activeDeals: 3,
      ),
      Vendor(
        brandLogo: 'assets/images/deals/details/Starbucks_Logo.png',
        dealStoreName: 'Starbucks',
        dealType: 'Food & Beverage',
        activeDeals: 3,
      ),
    ];
  }
}
