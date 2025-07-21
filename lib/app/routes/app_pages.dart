import 'package:get/get.dart';

import '../modules/ChooseRedemptionDeal/bindings/choose_redemption_deal_binding.dart';
import '../modules/ChooseRedemptionDeal/views/choose_redemption_deal_view.dart';
import '../modules/MyDeals/bindings/my_deals_binding.dart';
import '../modules/MyDeals/views/my_deals_view.dart';
import '../modules/MyDealsDetails/bindings/my_deals_details_binding.dart';
import '../modules/MyDealsDetails/views/my_deals_details_view.dart';
import '../modules/ProductDetails/bindings/product_details_binding.dart';
import '../modules/ProductDetails/views/product_details_view.dart';
import '../modules/Profile/bindings/profile_binding.dart';
import '../modules/Profile/views/profile_view.dart';
import '../modules/QRScanner/bindings/q_r_scanner_binding.dart';
import '../modules/QRScanner/views/q_r_scanner_view.dart';
import '../modules/Search/bindings/search_binding.dart';
import '../modules/Search/views/search_view.dart';
import '../modules/VendorProfile/bindings/vendor_profile_binding.dart';
import '../modules/VendorProfile/views/vendor_profile_view.dart';
import '../modules/dealDetail/bindings/deal_detail_binding.dart';
import '../modules/dealDetail/views/deal_detail_view.dart';
import '../modules/deals/bindings/deals_binding.dart';
import '../modules/deals/views/deals_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home2/bindings/home2_binding.dart';
import '../modules/home2/views/home2_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/signUpProcess/bindings/sign_up_process_binding.dart';
import '../modules/signUpProcess/views/sign_up_process_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.PRODUCT_DETAILS;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP_PROCESS,
      page: () => const SignUpProcessView(),
      binding: SignUpProcessBinding(),
    ),
    GetPage(
      name: _Paths.HOME2,
      page: () => const Home2View(),
      binding: Home2Binding(),
    ),
    GetPage(
      name: _Paths.DEALS,
      page: () => DealsView(),
      binding: DealsBinding(),
    ),
    GetPage(
      name: _Paths.DEAL_DETAIL,
      page: () => DealDetailView(
        dealImage: '',
        dealTitle: '',
        dealDescription: '',
        dealValidity: '',
        dealStoreName: '',
        brandLogo: '',
      ),
      binding: DealDetailBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.Q_R_SCANNER,
      page: () => const QRScannerView(),
      binding: QRScannerBinding(),
    ),
    GetPage(
      name: _Paths.MY_DEALS,
      page: () => MyDealsView(),
      binding: MyDealsBinding(),
    ),
    GetPage(
      name: _Paths.MY_DEALS_DETAILS,
      page: () => const MyDealsDetailsView(),
      binding: MyDealsDetailsBinding(),
    ),
    GetPage(
      name: _Paths.CHOOSE_REDEMPTION_DEAL,
      page: () => const ChooseRedemptionDealView(
        dealImage: '',
        dealTitle: '',
        dealDescription: '',
        dealValidity: '',
        dealStoreName: '',
        brandLogo: '',
      ),
      binding: ChooseRedemptionDealBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.VENDOR_PROFILE,
      page: () => const VendorProfileView(),
      binding: VendorProfileBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAILS,
      page: () => ProductDetailsView(title: 'Blonde Roast - Sunsera', price: 3.15, calory: 0, description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text.', image: 'assets/images/VendorProfile/Shake.png',),
      binding: ProductDetailsBinding(),
    ),
  ];
}
