import 'package:flutter/material.dart';
import 'package:flutter_template/config/index.dart';
import 'package:flutter_template/routes/middlewares/index.dart';
import 'package:get/get.dart';

import 'package:flutter_template/pages/welcome/index.dart';
import 'package:flutter_template/pages/signin/index.dart';
import 'package:flutter_template/pages/home/index.dart';

class AppPages {
  static List<String> history = [];

  static const initial = AppRoutes.initial;

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.initial,
      binding: WelcomePageBinding(),
      middlewares: [
        RouteWelcomeMiddleware(),
      ],
      page: () => const WelcomePage(),
    ),
    GetPage(
      name: AppRoutes.signIn,
      binding: SignInPageBinding(),
      page: () => const SignInPage(),
    ),
    GetPage(
      name: AppRoutes.home,
      binding: HomePageBinding(),
      middlewares: [
        RouteAuthMiddleware(),
      ],
      page: () => const HomePage(),
    ),
  ];
}
