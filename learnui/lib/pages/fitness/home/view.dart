import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/bottom_bar.dart';
import 'models/tab_icon_data.dart';
import '../theme.dart';
import 'my_diary.dart';
import 'training.dart';

class FitnessPage extends StatefulWidget {
  const FitnessPage({Key? key}) : super(key: key);

  @override
  _FitnessPageState createState() => _FitnessPageState();
}

class _FitnessPageState extends State<FitnessPage>
    with TickerProviderStateMixin {
  late final AnimationController animationController;

  final List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(color: FitnessTheme.background);

  @override
  void initState() {
    for (var tab in tabIconsList) {
      tab.isSelected = false;
    }
    tabIconsList[0].isSelected = true;
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = MyDiary(animationController: animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: _getData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const SizedBox();

            return Stack(
              children: [
                tabBody,
                // bottom bar
                Column(
                  children: [
                    // 用于撑开页面, 把 bottom bar 顶到底部
                    const Expanded(child: SizedBox()),
                    BottomBar(
                      tabIconsList: tabIconsList,
                      addClick: _handleClickAdd,
                      changeIndex: _changeTab,
                    )
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<bool> _getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  void _changeTab(int index) {
    if (index == 0 || index == 2) {
      animationController.reverse().then((data) {
        if (!mounted) return;
        setState(() {
          tabBody = MyDiary(
            animationController: animationController,
          );
        });
      });
    } else if (index == 1 || index == 3) {
      animationController.reverse().then((data) {
        if (!mounted) return;
        setState(() {
          tabBody = Training(
            animationController: animationController,
          );
        });
      });
    }
  }

  void _handleClickAdd() {
    Get.defaultDialog(middleText: 'ADD');
  }
}
