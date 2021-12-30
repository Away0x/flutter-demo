import 'package:get/get.dart';
import 'controller.dart';

class FitnessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FitnessController>(() => FitnessController());
  }
}
