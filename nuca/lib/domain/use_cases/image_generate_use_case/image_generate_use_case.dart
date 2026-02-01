import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import '../../../core/export.dart';

class ImageGenerateUseCase {
  final ImageGenerateRepo imageGenerateRepo;

  ImageGenerateUseCase(this.imageGenerateRepo);

  String getUserId() {
    return imageGenerateRepo.getUserId();
  }

  bool getUserLoggedInStatus() {
    return imageGenerateRepo.getUserLoggedInStatus();
  }

  Future<Either<AppError, GenerateImageModel>> generateImage({
    required Uint8List userImage,
    required String prompt,
  }) async {
    final response = await imageGenerateRepo.generateImage(
      userImage: userImage,
      prompt: prompt,
    );
    return response.fold(
      (error) {
        return Left(error);
      },
      (success) {
        return Right(success);
      },
    );
  }

  Future<Either<AppError, GenerateImageModel>> generateFromPrompt({
    Uint8List? userImage,
    required String prompt,
  }) async {
    final response = await imageGenerateRepo.generateFromPrompt(
      userImage: userImage,
      prompt: prompt,
    );
    return response.fold(
      (error) {
        return Left(error);
      },
      (success) {
        return Right(success);
      },
    );
  }
}
