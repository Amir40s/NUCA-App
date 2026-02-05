import 'package:get/get.dart';

import '../modules/choose_language/bindings/choose_language_binding.dart';
import '../modules/choose_language/views/choose_language_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/halal_guidlines/bindings/halal_guidlines_binding.dart';
import '../modules/halal_guidlines/views/halal_guidlines_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/on_boarding/bindings/on_boarding_binding.dart';
import '../modules/on_boarding/views/on_boarding_view.dart';
import '../modules/product_detail/bindings/product_detail_binding.dart';
import '../modules/product_detail/views/product_detail_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/scan_history/bindings/scan_history_binding.dart';
import '../modules/scan_history/views/scan_history_view.dart';
import '../modules/scan_qr/bindings/scan_qr_binding.dart';
import '../modules/scan_qr/views/scan_qr_view.dart';
import '../modules/select_preferences/bindings/select_preferences_binding.dart';
import '../modules/select_preferences/views/select_preferences_view.dart';
import '../modules/signUp/bindings/sign_up_binding.dart';
import '../modules/signUp/views/sign_up_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/subscription/bindings/subscription_binding.dart';
import '../modules/subscription/views/subscription_view.dart';
import '../modules/subscription_managment/bindings/subscription_managment_binding.dart';
import '../modules/subscription_managment/views/subscription_managment_view.dart';
import '../modules/tabs/bindings/tabs_binding.dart';
import '../modules/tabs/views/tabs_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.CHOOSE_LANGUAGE,
      page: () => const ChooseLanguageView(),
      binding: ChooseLanguageBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_PREFERENCES,
      page: () => const SelectPreferencesView(),
      binding: SelectPreferencesBinding(),
    ),
    GetPage(
      name: _Paths.ON_BOARDING,
      page: () => const OnBoardingView(),
      binding: OnBoardingBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.TABS,
      page: () => const TabsView(),
      binding: TabsBinding(),
    ),
    GetPage(
      name: _Paths.SCAN_QR,
      page: () => const ScanQrView(),
      binding: ScanQrBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAIL,
      page: () => const ProductDetailView(),
      binding: ProductDetailBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SUBSCRIPTION,
      page: () => const SubscriptionView(),
      binding: SubscriptionBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.SUBSCRIPTION_MANAGMENT,
      page: () => const SubscriptionManagmentView(),
      binding: SubscriptionManagmentBinding(),
    ),
    GetPage(
      name: _Paths.HALAL_GUIDLINES,
      page: () => const HalalGuidlinesView(),
      binding: HalalGuidlinesBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.SCAN_HISTORY,
      page: () => const ScanHistoryView(),
      binding: ScanHistoryBinding(),
    ),
  ];
}
