import 'package:get/get.dart';

class MainWrapperController extends GetxController {
  static MainWrapperController get to => Get.find<MainWrapperController>();

  final _currentIndex = 0.obs;

  int get currentIndex => _currentIndex.value;

  void setCurrentIndex(int index) {
    _currentIndex.value = index;
  }
}
