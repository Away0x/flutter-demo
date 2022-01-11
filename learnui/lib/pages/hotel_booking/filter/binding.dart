import 'package:get/get.dart';
import 'controller.dart';

class HotelBookingFilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HotelBookingFilterController>(
        () => HotelBookingFilterController());
  }
}
