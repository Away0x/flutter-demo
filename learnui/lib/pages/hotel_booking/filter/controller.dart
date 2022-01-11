import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'model/popular_filter_list.dart';

class HotelBookingFilterController extends GetxController {
  static HotelBookingFilterController get to => Get.find();

  final popularFilterListData =
      RxList<PopularFilterListData>(PopularFilterListData.popularFList);
  final accomodationListData =
      RxList<PopularFilterListData>(PopularFilterListData.accomodationList);

  final rangeValues = const RangeValues(100, 600).obs;
  final distValue = 50.0.obs;

  void changeRangeValues(RangeValues v) {
    rangeValues.value = v;
  }
}
