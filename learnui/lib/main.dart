import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:learnui/constants/app.dart';
import 'package:learnui/constants/theme.dart';
import 'package:learnui/pages/pages.dart';
import 'package:learnui/tools/keyboard.dart';

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
    statusBarBrightness: !GetPlatform.isWeb && GetPlatform.isAndroid
        ? Brightness.dark
        : Brightness.light,
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
    return GetMaterialApp(
      title: AppInfo.title,
      debugShowCheckedModeBanner: false,
      enableLog: true,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.iOS,
      ),
      initialRoute: Pages.initial,
      getPages: Pages.routes,
      builder: (context, child) => Scaffold(
        // Global GestureDetector that will dismiss the keyboard
        body: GestureDetector(
          onTap: () {
            KeyboardTools.hideKeyboard(context);
          },
          child: child,
        ),
      ),
    );
  }
}
