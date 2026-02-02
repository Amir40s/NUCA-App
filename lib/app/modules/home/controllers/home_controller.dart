import 'package:get/get.dart';
import 'package:nuca/gen/assets.gen.dart';

class HomeController extends GetxController {
  final foods = [
    {
      'image': Assets.images.food1.path,
      'title': 'Organic Orange Juice',
      'time': '2 hours ago',
      'price': '2.50',
      'isHalal': true,
    },
    {
      'image': Assets.images.food2.path,
      'title': 'Cheetos',
      'time': '4 hours ago',
      'price': '1.50',
      'isHalal': false,
    },
  ];
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
