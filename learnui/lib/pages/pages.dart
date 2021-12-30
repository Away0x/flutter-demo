import 'package:get/route_manager.dart';
import 'package:learnui/constants/routes.dart';
import 'package:learnui/pages/design_course/index.dart';
import 'package:learnui/pages/fitness/index.dart';
import 'package:learnui/pages/home/index.dart';
import 'package:learnui/pages/hotel_booking/index.dart';
import 'package:learnui/pages/introduction_animation/index.dart';

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
    GetPage(
      name: Routes.hotelBooking,
      binding: HotelBookingBinding(),
      page: () => const HotelBookingPage(),
    ),
    GetPage(
      name: Routes.fitness,
      binding: FitnessBinding(),
      page: () => const FitnessPage(),
    ),
    GetPage(
      name: Routes.designCourse,
      binding: DesignCourseBinding(),
      page: () => const DesignCoursePage(),
    ),
  ];
}
