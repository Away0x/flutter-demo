import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnui/constants/theme.dart';
import 'package:learnui/pages/home/controller.dart';

import 'components/drawer/index.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: GetBuilder<HomeController>(
            builder: (controller) {
              return DrawerLayout(
                screenIndex: controller.drawerIndex,
                drawerWidth: Get.width * 0.75, // 抽屉宽度占屏幕 0.75
                screenView: controller.screenView,
                onDrawerCall: (drawerIndex) {
                  controller.changeIndex(drawerIndex);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
