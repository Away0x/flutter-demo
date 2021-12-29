import 'package:get/route_manager.dart';
import 'package:learnui/constants/routes.dart';
import 'package:learnui/pages/home/index.dart';

class Pages {
  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: Pages.initial,
      binding: HomeBinding(),
      page: () => const HomePage(),
    ),
  ];
}
