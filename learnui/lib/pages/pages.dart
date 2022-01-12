import 'package:get/route_manager.dart';
import 'package:learnui/constants/routes.dart';
import 'package:learnui/pages/home/index.dart';
import 'package:learnui/pages/introduction_animation/index.dart';
import 'package:learnui/pages/hotel_booking/index.dart';
import 'package:learnui/pages/design_course/index.dart';
import 'package:learnui/pages/fitness/index.dart';

class Pages {
  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: Pages.initial,
      binding: HomeBinding(),
      page: () => const HomePage(),
    ),

    GetPage(
      name: Routes.introductionAnimation,
      binding: IntroductionAnimationBinding(),
      page: () => const IntroductionAnimationPage(),
    ),

    // ---------- HotelBooking ----------
    GetPage(
      name: Routes.hotelBooking,
      binding: HotelBookingHomeBinding(),
      page: () => const HotelBookingHome(),
    ),
    GetPage(
      name: Routes.hotelBookingFilter,
      binding: HotelBookingFilterBinding(),
      page: () => const HotelBookingFilterPage(),
      fullscreenDialog: true,
    ),

    GetPage(
      name: Routes.fitness,
      binding: FitnessBinding(),
      page: () => const FitnessPage(),
    ),

    // ---------- DesignCourse ----------
    GetPage(
      name: Routes.designCourse,
      binding: DesignCourseHomeBinding(),
      page: () => const DesignCourseHomePage(),
    ),
    GetPage(
      name: Routes.designCourseInfo,
      binding: DesignCourseInfoBinding(),
      page: () => const DesignCourseInfoPage(),
    ),
  ];
}
