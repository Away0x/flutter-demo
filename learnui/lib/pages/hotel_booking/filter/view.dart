import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnui/pages/hotel_booking/filter/controller.dart';
import 'package:learnui/pages/hotel_booking/theme.dart';

import 'components/my_app_bar.dart';
import 'components/my_range_slider.dart';

class HotelBookingFilterPage extends GetView<HotelBookingFilterController> {
  const HotelBookingFilterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HotelBookingTheme.buildLightTheme().backgroundColor,
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
                  ],
                ),
              ),
            ),
          ],
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
            values: controller.rangeValues.value,
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
          child: Column(
            children: _getList(),
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
    var len = controller.popularFilterListData.value.length;
    for (int i = 0; i < len / columnCount; i++) {
      final List<Widget> listUI = <Widget>[];
      for (int i = 0; i < columnCount; i++) {}
    }
    return noList;
  }
}
