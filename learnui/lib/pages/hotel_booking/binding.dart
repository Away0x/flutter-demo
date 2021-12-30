import 'package:get/get.dart';
import 'controller.dart';

class HotelBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HotelBookingController>(() => HotelBookingController());
  }
}
