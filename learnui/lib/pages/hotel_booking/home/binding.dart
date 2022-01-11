import 'package:get/get.dart';
import 'controller.dart';

class HotelBookingHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HotelBookingHomeController>(() => HotelBookingHomeController());
  }
}
