import 'package:get/get.dart';
import 'controller.dart';

class DesignCourseHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DesignCourseHomeController>(() => DesignCourseHomeController());
  }
}
