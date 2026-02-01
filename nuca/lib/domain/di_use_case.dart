import 'package:get/get.dart';
import '../core/export.dart';
import 'use_cases/export.dart';

Future<void> initializeModelUseCasesDependencies() async {
  Get.lazyPut<ImageGenerateUseCase>(
    () => ImageGenerateUseCase(
      Get.find<ImageGenerateRepo>(),
    ),
    fenix: true,
  );
}
