import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnui/constants/drawer.dart';

import 'components/home.dart';
import 'components/help.dart';
import 'components/feed_back.dart';
import 'components/invite.dart';
import 'components/share.dart';
import 'components/about.dart';

var screenMap = {
  DrawerIndex.home: () => const Home(),
  DrawerIndex.help: () => const Help(),
  DrawerIndex.feedBack: () => const FeedBack(),
  DrawerIndex.invite: () => const Invite(),
  DrawerIndex.share: () => const Share(),
  DrawerIndex.about: () => const About(),
};

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  DrawerIndex drawerIndex = DrawerIndex.home;
  Widget? screenView;

  @override
  void onInit() {
    super.onInit();
    screenView = const Home();
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndexdata == drawerIndex) return;
    var buildFn = screenMap[drawerIndexdata];
    if (buildFn == null) return;
    screenView = buildFn();
    drawerIndex = drawerIndexdata;
    update();
  }
}
