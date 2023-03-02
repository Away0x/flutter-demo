import 'package:flutter/material.dart';
import 'package:flutter_template/store/index.dart';
import 'package:get/get.dart';
import 'package:flutter_template/constants/index.dart';

// import 'widgets/home.dart';
import 'widgets/help.dart';
import 'widgets/feed_back.dart';
import 'widgets/invite.dart';

var screenMap = {
  DrawerIndex.home: () => const Help(),
  DrawerIndex.help: () => const Help(),
  DrawerIndex.feedBack: () => const FeedBack(),
  DrawerIndex.invite: () => const Invite(),
};

class HomePageController extends GetxController {
  static HomePageController get to => Get.find();

  DrawerIndex drawerIndex = DrawerIndex.help;
  Widget? screenView;

  @override
  void onInit() {
    super.onInit();
    screenView = screenMap[DrawerIndex.home]!();
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndexdata == drawerIndex) return;
    var buildFn = screenMap[drawerIndexdata];
    if (buildFn == null) return;
    screenView = buildFn();
    drawerIndex = drawerIndexdata;
    update();
  }

  void logout() {
    AuthStore.to.logout();
  }
}
