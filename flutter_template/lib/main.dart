import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_template/global.dart';
import 'package:flutter_template/routes/pages.dart';
import 'package:flutter_template/store/index.dart';
import 'package:flutter_template/styles/index.dart';
import 'package:flutter_template/utils/index.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
      builder: (context, child) {
        return RefreshConfiguration(
          headerBuilder: () => const ClassicHeader(),
          footerBuilder: () => const ClassicFooter(),
          hideFooterWhenNotFull: true,
          headerTriggerDistance: 80,
          maxOverScrollExtent: 100,
          footerTriggerDistance: 150,
          child: GetMaterialApp(
            // ui
            title: 'Flutter Demo',
            theme: AppTheme.light,
            debugShowCheckedModeBanner: false,
            // log
            enableLog: true,
            logWriterCallback: AppLogger.write,
            // langs
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: ConfigStore.to.languages,
            locale: ConfigStore.to.locale,
            fallbackLocale: const Locale('en', 'US'),
            // routes
            initialRoute: AppPages.initial,
            getPages: AppPages.routes,
            builder: (context, child) {
              return EasyLoading.init(builder: (context, child) {
                return Scaffold(
                  body: GestureDetector(
                    onTap: () {
                      KeyboardTools.hideKeyboard(context);
                    },
                    child: child,
                  ),
                );
              })(context, child);
            },
          ),
        );
      },
    );
  }
}
