import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
// import 'package:flutter/rendering.dart';

import 'package:baixing_shop/pages/index/index.dart';
import 'package:baixing_shop/router/router.dart';
import 'package:baixing_shop/application.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // debugPaintSizeEnabled = true;

    final router = Router();
    MyRouter.configureRoutes(router);
    Application.router = router;

    return MaterialApp(
      title: '百姓生活+',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Application.router.generator,
      theme: ThemeData(
        primaryColor: Colors.pink,
      ),
      home: IndexPage(),
    );
  }
}
