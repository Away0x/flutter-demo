import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme.dart';
import 'components/my_app_bar.dart';
import 'components/title_view.dart';
import 'components/workout_view.dart';
import 'components/running_view.dart';
import 'components/area_list_view.dart';

class Training extends StatefulWidget {
  const Training({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  final AnimationController animationController;

  @override
  _TrainingState createState() => _TrainingState();
}

class _TrainingState extends State<Training> {
  List<Widget> listViews = [];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    _initList();
    scrollController.addListener(() {
      final offset = scrollController.offset;

      if (offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (offset <= 24 && offset >= 0) {
        if (topBarOpacity != offset / 24) {
          setState(() {
            topBarOpacity = offset / 24;
          });
        }
      } else if (offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            FutureBuilder(
              future: _getData(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const SizedBox();

                return ListView.builder(
                  controller: scrollController,
                  padding: EdgeInsets.only(
                    top: AppBar().preferredSize.height +
                        Get.mediaQuery.padding.top +
                        24,
                    bottom: 62 + Get.mediaQuery.padding.bottom,
                  ),
                  itemCount: listViews.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    widget.animationController.forward();
                    return listViews[index];
                  },
                );
              },
            ),
            MyAppBar(
              title: 'Training',
              animationController: widget.animationController,
              opacity: topBarOpacity,
            ),
            SizedBox(height: Get.mediaQuery.padding.bottom)
          ],
        ),
      ),
    );
  }

  Future<bool> _getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  void _initList() {
    const int count = 5;

    listViews.add(
      TitleView(
        titleTxt: 'Your program',
        subTxt: 'Details',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController,
            curve: const Interval(
              (1 / count) * 0,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        animationController: widget.animationController,
      ),
    );

    listViews.add(
      WorkoutView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController,
            curve: const Interval(
              (1 / count) * 2,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        animationController: widget.animationController,
      ),
    );

    listViews.add(
      RunningView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController,
            curve: const Interval(
              (1 / count) * 3,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        animationController: widget.animationController,
      ),
    );

    listViews.add(
      TitleView(
        titleTxt: 'Area of focus',
        subTxt: 'more',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController,
            curve: const Interval(
              (1 / count) * 4,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        animationController: widget.animationController,
      ),
    );

    listViews.add(
      AreaListView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController,
            curve: const Interval(
              (1 / count) * 5,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        mainScreenAnimationController: widget.animationController,
      ),
    );
  }
}
