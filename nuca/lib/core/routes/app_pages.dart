import 'package:get/get.dart';

import '../../features/prompt_to_image/export.dart';
import '../../features/all_ai_generative/export.dart';
import '../../features/bottom_nav/export.dart' as bottom_nav;
import '../../features/photo_result/export.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/remove_bg/export.dart';
import '../../features/old_photo_restore/export.dart';
import '../../features/enhance_photo/export.dart';
import '../../features/face_swap/export.dart';
import '../../features/splash/export.dart';
import '../../features/subscription/export.dart';
import 'app_routes.dart';

class AppPages {
  static const String initial = Routes.splash;

  static final List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
    GetPage(
      name: Routes.splash,
      page: () => const SplashView(),
      binding: SplashBindings(),
    ),
    GetPage(name: Routes.onBoard, page: () => const OnboardingView()),

    GetPage(
      name: Routes.bottomNav,
      page: () => const bottom_nav.BottomNavView(),
      binding: bottom_nav.BottomNavBindings(),
    ),
    GetPage(
      name: Routes.promptToImage,
      page: () => const PromptToImageView(),
      binding: PromptToImageBinding(),
    ),
    GetPage(
      name: Routes.allAiGenerative,
      page: () => const AllAiGenerativeView(),
      binding: AllAiGenerativeBinding(),
    ),
    GetPage(
      name: Routes.removeBg,
      page: () => const RemoveBgView(),
      binding: RemoveBgBinding(),
    ),
    GetPage(
      name: Routes.oldPhotoRestore,
      page: () => const OldPhotoRestoreView(),
      binding: OldPhotoRestoreBinding(),
    ),
    GetPage(
      name: Routes.enhancePhoto,
      page: () => const EnhancePhotoView(),
      binding: EnhancePhotoBinding(),
    ),
    GetPage(
      name: Routes.faceSwap,
      page: () => const FaceSwapView(),
      binding: FaceSwapBinding(),
    ),
    GetPage(
      name: Routes.photoResultView,
      page: () => const PhotoResultView(),
      binding: PhotoResultBinding(),
    ),
    GetPage(
      name: Routes.subscription,
      page: () => const SubscriptionScreen(),
      binding: SubscriptionBinding(),
    ),
  ];
}
