import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/services/index.dart';
import 'package:flutter_template/store/index.dart';
import 'package:flutter_template/utils/loading.dart';
import 'package:get/get.dart';

class Global {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initSystemUI();
    await initUI();
    await initBinding();
  }

  static Future<void> initSystemUI() async {
    // 强制竖屏
    await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    // 设置沉浸式导航
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: !GetPlatform.isWeb && GetPlatform.isAndroid
          ? Brightness.dark
          : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
  }

  static Future<void> initUI() async {
    Loading();
  }

  static Future<void> initBinding() async {
    await Get.putAsync<StorageService>(() => StorageService().init());
    Get.put<ConfigStore>(ConfigStore());
    Get.put<AuthStore>(AuthStore());
  }
}
