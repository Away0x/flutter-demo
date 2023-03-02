import 'package:flutter_template/store/auth.dart';
import 'package:get/get.dart';

class SignInPageController extends GetxController {
  Future<void> handleSignIn({
    required String email,
    required String password,
  }) async {
    await AuthStore.to.login();
  }
}
