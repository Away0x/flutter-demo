import 'package:get/get.dart';
import 'controller.dart';

class DesignCourseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DesignCourseController>(() => DesignCourseController());
  }
}
