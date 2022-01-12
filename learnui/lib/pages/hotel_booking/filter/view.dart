import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnui/pages/hotel_booking/filter/controller.dart';
import 'package:learnui/pages/hotel_booking/theme.dart';

import 'components/my_app_bar.dart';
import 'components/my_range_slider.dart';
import 'components/my_slider.dart';

class HotelBookingFilterPage extends GetView<HotelBookingFilterController> {
  const HotelBookingFilterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HotelBookingTheme.buildLightTheme().backgroundColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              const MyAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildPriceBarFilter(),
                      const Divider(height: 1),
                      _buildPopularFilter(),
                      const Divider(height: 1),
                      _buildDistanceFilter(),
                      const Divider(height: 1),
                      _buildAllAccommodation(),
                    ],
                  ),
                ),
              ),
              const Divider(height: 1),
              _buildApplyButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceBarFilter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Price (for 1 night)',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.grey,
              fontSize: Get.width > 360 ? 18 : 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Obx(
          () => MyRangeSlider(
            values: controller.rangeValues,
            onChangeRangeValues: (v) {
              controller.changeRangeValues(v);
            },
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildPopularFilter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            'Popular filters',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.grey,
              fontSize: Get.width > 360 ? 18 : 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: GetBuilder<HotelBookingFilterController>(
            id: controller.popularBuildKey,
            builder: (_) => Column(
              children: _getList(),
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  List<Widget> _getList() {
    final List<Widget> noList = [];
    var count = 0;
    const int columnCount = 2;
    var len = controller.popularFilterListData.length;

    for (int i = 0; i < len / columnCount; i++) {
      final List<Widget> listUI = <Widget>[];
      for (int i = 0; i < columnCount; i++) {
        try {
          final date = controller.popularFilterListData[count];
          listUI.add(Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                    onTap: () {
                      controller.changePopularSelect(date);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            date.isSelected
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: date.isSelected
                                ? HotelBookingTheme.buildLightTheme()
                                    .primaryColor
                                : Colors.grey.withOpacity(0.6),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            date.titleTxt,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
          if (count < controller.popularFilterListData.length - 1) {
            count += 1;
          } else {
            break;
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      }
      noList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: listUI,
      ));
    }
    return noList;
  }

  Widget _buildDistanceFilter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            'Distance from city center',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.grey,
              fontSize: Get.width > 360 ? 18 : 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Obx(
          () => MySlider(
            distValue: controller.distValue,
            onChangedistValue: (v) {
              controller.changeDistValue(v);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAllAccommodation() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            'Type of Accommodation',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.grey,
              fontSize: Get.width > 360 ? 18 : 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: GetBuilder<HotelBookingFilterController>(
            id: controller.accomodationBuildKey,
            builder: (_) => Column(
              children: _buildAccomodationList(),
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  List<Widget> _buildAccomodationList() {
    final List<Widget> noList = <Widget>[];
    for (int i = 0; i < controller.accomodationListData.length; i++) {
      final date = controller.accomodationListData[i];
      noList.add(
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            onTap: () {
              controller.checkAppPosition(i);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      date.titleTxt,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  CupertinoSwitch(
                    activeColor: date.isSelected
                        ? HotelBookingTheme.buildLightTheme().primaryColor
                        : Colors.grey.withOpacity(0.6),
                    onChanged: (value) {
                      controller.checkAppPosition(i);
                    },
                    value: date.isSelected,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      if (i == 0) noList.add(const Divider(height: 1));
    }
    return noList;
  }

  Widget _buildApplyButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: HotelBookingTheme.buildLightTheme().primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(24.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              blurRadius: 8,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            highlightColor: Colors.transparent,
            onTap: () {
              Get.back();
            },
            child: const Center(
              child: Text(
                'Apply',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
