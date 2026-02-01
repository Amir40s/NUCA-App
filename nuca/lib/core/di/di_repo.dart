import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/splash/splash_controller.dart';
import '../repository/export.dart';
import '../services/export.dart';
import '../theme/theme_controller.dart';

class RepoDependencies {
  late NetworkHelper _networkHelper;
  late EndPoints _artistEndPoints;
  late SharedPreferences sharedPreferences;
  late StorageRepo _storageRepo;

  Future init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    _artistEndPoints = EndPoints();
    _networkHelper = NetworkHelperImpl(sharedPreferences);
    _storageRepo = StorageRepoImpl(sharedPreferences);
  }

  initializeRepoDependencies() {
    Get.lazyPut<ImageGenerateRepo>(
      () => ImageGenerateRepoImpl(
        _storageRepo,
        _networkHelper,
        _artistEndPoints,
        sharedPreferences,
      ),
      fenix: true,
    );
    Get.put<StorageRepo>(_storageRepo, permanent: true);
    Get.put(ThemeController(), permanent: true);
    Get.put(SplashController());
  }
}
