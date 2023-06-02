import 'dart:convert';

import 'package:chatty/entities/user.dart';
import 'package:chatty/routes/routes.dart';
import 'package:chatty/services/http/http.dart';
import 'package:chatty/stores/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../widgets/toast.dart';
import './state.dart';

class SignInController extends GetxController {
  final state = SignInState();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['openid'],
  );

  Future<void> handleSignIn(String type) async {
    // 1. email, 2: google, 3: facebook, 4: apple, 5: phone
    try {
      if (type == "phone number") {
        print("... you are logging in with phone number ...");
      } else if (type == "google") {
        var user = await _googleSignIn.signIn();
        if (user != null) {
          String? displayName = user.displayName;
          String email = user.email;
          String id = user.id;
          String photoUrl = user.photoUrl ?? "assets/icons/google.png";
          LoginRequestEntity loginPanelListRequestEntity = LoginRequestEntity(
            name: displayName,
            email: email,
            open_id: id,
            avatar: photoUrl,
            type: 2,
          );
          print(jsonEncode(loginPanelListRequestEntity));
          asyncPostAllData(loginPanelListRequestEntity);
        }
      } else {
        print("... loging type not sure ...");
      }
    } catch (e) {
      if (kDebugMode) {
        print("...error with login $e");
      }
    }
  }

  asyncPostAllData(LoginRequestEntity loginRequestEntity) async {
    EasyLoading.show(
      indicator: const CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
    );
    var result = await UserAPI.login(params: loginRequestEntity);
    if (result.code == 0) {
      await UserStore.to.saveProfile(result.data!);
      EasyLoading.dismiss();
      Get.offAllNamed(AppRoutes.Message);
    } else {
      EasyLoading.dismiss();
      toastInfo(msg: 'internet error');
    }
  }
}
