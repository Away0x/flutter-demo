import 'package:chatty/global.dart';
import 'package:chatty/routes/routes.dart';
import 'package:chatty/values/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> main() async {
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 780),
      builder: (context, child) => GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        navigatorObservers: [AppPages.observer],
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        builder: EasyLoading.init(),
      ),
    );
  }
}
