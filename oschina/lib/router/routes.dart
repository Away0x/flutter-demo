import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'package:oschina/pages/home/home.dart';
import 'package:oschina/pages/publish/publish.dart';
import 'package:oschina/pages/black_house/black_house.dart';
import 'package:oschina/pages/about/about.dart';
import 'package:oschina/pages/settings/settings.dart';

int _getParamsInt({Map<String, List<String>> params, String key, int defaultVal = 0}) {
  return int.parse(params[key]?.first ?? '$defaultVal');
}

final Map<String, Handler> routes = {
  // 首页
  '/': Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return HomePage(initialTabIndex: _getParamsInt(params: params, key: 'tabindex'));
    },
  ),
  // 发布动态
  '/publish': Handler(
    handlerFunc: (context, params) => PublishPage(),
  ),
  // 动态小黑屋
  '/black_house': Handler(
    handlerFunc: (context, parmas) => BlackHousePage()
  ),
  // 关于
  '/about': Handler(
    handlerFunc: (context, parmas) => AboutPage()
  ),
  // 设置
  '/settings': Handler(
    handlerFunc: (context, parmas) => SettingsPage()
  ),
};