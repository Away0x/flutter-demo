import 'package:flutter_template/config/index.dart';
import 'package:flutter_template/store/index.dart';
import 'package:get/get.dart';

import 'state.dart';

class WelcomePageController extends GetxController {
  static WelcomePageController get to => Get.find();

  final state = WelcomePageState();

  changePage(int index) {
    state.index.value = index;
  }

  gotoSignInPage() async {
    await ConfigStore.to.saveAlreadyOpen();
    Get.offAndToNamed(AppRoutes.signIn);
  }
}
