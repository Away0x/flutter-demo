import 'package:get/get.dart';

import './controller.dart';

class VoicecallBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VoicecallController>(() => VoicecallController());
  }
}
