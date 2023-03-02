import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_template/styles/index.dart';
import 'package:flutter_template/widgets/drawer/index.dart';

import 'controller.dart';

class HomePage extends GetView<HomePageController> {
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
          body: GetBuilder<HomePageController>(
            builder: (controller) {
              return DrawerLayout(
                screenIndex: controller.drawerIndex,
                drawerWidth: Get.width * 0.75, // 抽屉宽度占屏幕 0.75
                screenView: controller.screenView,
                onDrawerCall: (drawerIndex) {
                  controller.changeIndex(drawerIndex);
                },
                onLogout: () {
                  controller.logout();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
