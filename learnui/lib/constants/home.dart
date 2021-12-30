import 'routes.dart';

class HomeList {
  HomeList({
    required this.routeName,
    required this.imagePath,
  });

  String routeName;
  String imagePath;

  static List<HomeList> list = [
    HomeList(
      routeName: Routes.introductionAnimation,
      imagePath: 'assets/introduction_animation/introduction_animation.png',
    ),
    HomeList(
      routeName: Routes.hotelBooking,
      imagePath: 'assets/hotel/hotel_booking.png',
    ),
    HomeList(
      routeName: Routes.fitness,
      imagePath: 'assets/fitness_app/fitness_app.png',
    ),
    HomeList(
      routeName: Routes.designCourse,
      imagePath: 'assets/design_course/design_course.png',
    ),
  ];
}
