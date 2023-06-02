import 'package:chatty/routes/routes.dart';
import 'package:get/get.dart';

import './state.dart';

class WelcomeController extends GetxController {
  WelcomeController();

  final title = "Chatty .";
  final state = WelcomeState();

  @override
  void onReady() {
    super.onReady();
    print(" WelcomeController ");
    Future.delayed(
        const Duration(seconds: 3), () => Get.offAllNamed(AppRoutes.Message));
  }
}
