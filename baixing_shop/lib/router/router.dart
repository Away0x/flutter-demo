import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'package:baixing_shop/pages/detail/detail.dart';

Handler detailHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String goodsId = params['id'].first;

    return DetailPage(goodsId);
  }
);

class MyRouter {
  static String root = '/';
  static String detailPage = '/detail';

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print('ROUTE WAS NOT FOUND');
      },
    );

    router.define(detailPage, handler: detailHandler);
  }

}