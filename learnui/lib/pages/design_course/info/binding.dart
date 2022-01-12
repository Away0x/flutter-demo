import 'package:get/get.dart';
import 'controller.dart';

class DesignCourseInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DesignCourseInfoController>(() => DesignCourseInfoController());
  }
}
