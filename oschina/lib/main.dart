import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'package:oschina/constants/style.dart';
import 'package:oschina/router/router.dart';
import 'package:oschina/application.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final router = Router();
    MyRouter.register(router);
    Application.router = router;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '开源中国',
      theme: ThemeData(
        primaryColor: Color(AppColors.APP_THEME),
      ),
      onGenerateRoute: Application.router.generator,
    );
  }
}
