import 'package:chatty/routes/names.dart';
import 'package:get/get.dart';

import './state.dart';

class MessageController extends GetxController {
  final state = MessageState();

  void getProfile() async {
    await Get.toNamed(AppRoutes.Profile);
  }
}
