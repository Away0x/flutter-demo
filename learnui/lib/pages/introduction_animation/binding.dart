import 'package:get/get.dart';
import 'controller.dart';

class IntroductionAnimationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IntroductionAnimationController>(
        () => IntroductionAnimationController());
  }
}
