import 'package:flutter/material.dart';
import 'package:flutter_template/config/index.dart';
import 'package:get/get.dart';

import 'package:flutter_template/store/index.dart';

class RouteAuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (AuthStore.to.isLogin ||
        route == AppRoutes.initial ||
        route == AppRoutes.signIn) {
      return null;
    }

    // Future.delayed(
    //   const Duration(seconds: 1),
    //   () => Get.snackbar("提示", "登录过期,请重新登录"),
    // );
    return const RouteSettings(name: AppRoutes.signIn);
  }
}
