import 'package:chatty/routes/routes.dart';
import 'package:chatty/stores/stores.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

/// check if the user has logged in
class RouteAuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (UserStore.to.isLogin ||
        route == AppRoutes.SIGN_IN ||
        // route == AppRoutes.Message ||
        route == AppRoutes.INITIAL) {
      return null;
    }

    Future.delayed(const Duration(seconds: 2),
        () => Get.snackbar("Tips", "Login expired, please login again!"));
    return const RouteSettings(name: AppRoutes.SIGN_IN);
  }
}
