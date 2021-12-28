import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:learnui/pages/root.dart';
import 'package:learnui/styles/styles.dart';

void main() async {
  await initSystemUI();
  runApp(const MyApp());
}

Future<void> initSystemUI() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 设置沉浸式导航
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness:
        !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
    systemNavigationBarColor: Colors.black,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  // 强制竖屏
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.iOS,
      ),
      home: const RootPage(),
    );
  }
}
