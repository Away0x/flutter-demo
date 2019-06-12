import 'package:flutter/material.dart';

// 顶级页面 tabbar index 控制
class TabIndexProvide with ChangeNotifier {

  int currentTabIndex = 0;

  changeTabIndex(int index) {
    currentTabIndex = index;
    notifyListeners();
  }

  // 切换到购物车页面
  gotoCartPage(BuildContext context, [bool pop = true]) {
    changeTabIndex(2);
    if (pop) {
      Navigator.pop(context);
    }
  }

  // 切换到分类页面
  gotoCategoryPage(BuildContext context, [bool pop = true]) {
    changeTabIndex(1);
    if (pop) {
      Navigator.pop(context);
    }
  }
}