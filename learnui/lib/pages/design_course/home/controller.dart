import 'package:get/get.dart';

enum CategoryType {
  ui,
  coding,
  basic,
}

class DesignCourseHomeController extends GetxController {
  static DesignCourseHomeController get to => Get.find();

  CategoryType get categoryType => _categoryType.value;
  final _categoryType = CategoryType.ui.obs;

  void changeCategoryType(CategoryType t) {
    _categoryType.value = t;
  }
}
