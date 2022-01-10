import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnui/pages/hotel_booking/components/search_bar.dart';
import 'package:learnui/pages/hotel_booking/theme.dart';

import 'components/my_app_bar.dart';
import 'models/hotel_list_data.dart';

class HotelBookingPage extends StatefulWidget {
  const HotelBookingPage({Key? key}) : super(key: key);

  @override
  _HotelBookingPageState createState() => _HotelBookingPageState();
}

class _HotelBookingPageState extends State<HotelBookingPage>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<HotelListData> hotelList = HotelListData.hotelList;
  final ScrollController _scrollController = ScrollController();

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
                          children: const [
                            SearchBar(),
                            Text('2'),
                          ],
                        );
                      },
                      childCount: 1,
                    ),
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
}
