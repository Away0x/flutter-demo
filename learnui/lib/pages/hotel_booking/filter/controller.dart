import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'model/popular_filter_list.dart';

class HotelBookingFilterController extends GetxController {
  static HotelBookingFilterController get to => Get.find();

  final popularFilterListData = PopularFilterListData.popularFList;
  final popularBuildKey = 'Popular';
  final accomodationListData = PopularFilterListData.accomodationList;
  final accomodationBuildKey = 'Accomodation';

  final rangeValues = const RangeValues(100, 600).obs;
  final distValue = 50.0.obs;

  void changeRangeValues(RangeValues v) => rangeValues.value = v;

  void changeDistValue(double v) => distValue.value = v;

  void changePopularSelect(PopularFilterListData date) {
    date.isSelected = !date.isSelected;
    update([popularBuildKey]);
  }

  void checkAppPosition(int index) {
    if (index == 0) {
      if (accomodationListData[0].isSelected) {
        for (var d in accomodationListData) {
          d.isSelected = false;
        }
      } else {
        for (var d in accomodationListData) {
          d.isSelected = true;
        }
      }
    } else {
      accomodationListData[index].isSelected =
          !accomodationListData[index].isSelected;

      int count = 0;
      for (int i = 0; i < accomodationListData.length; i++) {
        if (i != 0) {
          final data = accomodationListData[i];
          if (data.isSelected) count += 1;
        }
      }

      if (count == accomodationListData.length - 1) {
        accomodationListData[0].isSelected = true;
      } else {
        accomodationListData[0].isSelected = false;
      }
    }

    update([accomodationBuildKey]);
  }
}
