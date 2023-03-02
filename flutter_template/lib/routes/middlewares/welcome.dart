import 'package:flutter/material.dart';
import 'package:flutter_template/config/index.dart';
import 'package:flutter_template/store/index.dart';
import 'package:flutter_template/utils/index.dart';

import 'package:get/get.dart';

class RouteWelcomeMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return null;
    bool isFirstOpen = ConfigStore.to.isFirstOpen;
    AppLogger.logger.d(isFirstOpen);

    if (!isFirstOpen) return null;

    return const RouteSettings(name: AppRoutes.home);
  }
}
