import 'package:chatty/stores/user.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './state.dart';

class ProfileController extends GetxController {
  final state = ProfileState();

  Future<void> goLogout() async {
    await GoogleSignIn().signOut();
    await UserStore.to.onLogout();
  }
}
