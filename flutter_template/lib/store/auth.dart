import 'package:flutter_template/config/index.dart';
import 'package:get/get.dart';
import 'package:flutter_template/entities/index.dart';

class AuthStore extends GetxController {
  static AuthStore get to => Get.find();

  bool _isLogin = false;
  String token = '';
  UserEntity? _profile;

  bool get isLogin => _isLogin;
  UserEntity get profile => _profile!;

  login() async {
    token = "123";
    _isLogin = true;
    _profile = UserEntity(
      id: "1",
      name: "Tong",
      email: "tong.wu@joinhorizons.com",
    );
    Get.offAndToNamed(AppRoutes.home);
  }

  logout() async {
    token = "";
    _isLogin = false;
    _profile = null;
    Get.offAndToNamed(AppRoutes.signIn);
  }
}
