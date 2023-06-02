import 'package:chatty/services/services.dart';
import 'package:chatty/stores/stores.dart';
import 'package:chatty/utils/FirbaseMessagingHandler.dart';
import 'package:chatty/utils/loading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

class Global {
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initSystemUI();
    await initUI();
    await initBinding();
    await initFirebase();
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
    Get.put<UserStore>(UserStore());
  }

  static Future<void> initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseMessaging.onBackgroundMessage(
      FirebaseMassagingHandler.firebaseMessagingBackground,
    );
    if (GetPlatform.isAndroid) {
      FirebaseMassagingHandler.flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .createNotificationChannel(FirebaseMassagingHandler.channel_call);
      FirebaseMassagingHandler.flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .createNotificationChannel(FirebaseMassagingHandler.channel_message);
    }

    FirebaseMassagingHandler.config();
  }
}
