import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnui/constants/routes.dart';
import 'package:learnui/pages/hotel_booking/theme.dart';

import 'models/hotel_list_data.dart';
import 'components/my_app_bar.dart';
import 'components/calendar_popup_view.dart';
import 'components/filter_bar.dart';
import 'components/search_bar.dart';
import 'components/time_bar.dart';

class HotelBookingHome extends StatefulWidget {
  const HotelBookingHome({Key? key}) : super(key: key);

  @override
  _HotelBookingHomeState createState() => _HotelBookingHomeState();
}

class _HotelBookingHomeState extends State<HotelBookingHome>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<HotelListData> hotelList = HotelListData.hotelList;
  final ScrollController _scrollController = ScrollController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: HotelBookingTheme.buildLightTheme(),
      child: Scaffold(
        body: Column(
          children: [
            MyAppBar(
              title: 'Explore',
              onBack: () {
                Get.back();
              },
            ),
            Expanded(
                child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Column(
                          children: [
                            SearchBar(
                              onSearch: (text) {
                                Get.defaultDialog(middleText: 'Search: $text');
                              },
                            ),
                            TimeBar(
                              startDate: startDate,
                              endDate: endDate,
                              onChooseDate: () {
                                showDemoDialog();
                              },
                            ),
                          ],
                        );
                      },
                      childCount: 1,
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true, // 是否固定头布局
                    floating: true, // 是否浮动头布局
                    // delegate: 设置布局
                    delegate: ContestTabHeader(FilterBar(
                      onFilter: () {
                        Get.toNamed(Routes.hotelBookingFilter);
                      },
                    )),
                  ),
                ];
              },
              body: Container(
                color: HotelBookingTheme.buildLightTheme().backgroundColor,
                child: const Center(
                  child: Text('body'),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  void showDemoDialog() {
    var maximumDate = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day + 10);

    Get.dialog(
      CalendarPopupView(
        barrierDismissible: true,
        minimumDate: DateTime.now(),
        maximumDate: maximumDate,
        initialEndDate: endDate,
        initialStartDate: startDate,
        onApplyClick: (DateTime startData, DateTime endData) {
          setState(() {
            startDate = startData;
            endDate = endData;
          });
        },
        onCancelClick: () {},
      ),
    );
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  const ContestTabHeader(
    this.searchUI,
  );
  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
