import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import './routes.dart';

class MyRouter {

  static void register(Router router) {
    // 404
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        return Scaffold(
          appBar: AppBar(
            title: Text('页面未找到'),
          ),
          body: Center(
            child: Text('NOT FOUND'),
          ),
        );
      },
    );

    routes.forEach((path, handler) => router.define(path, handler: handler)); 
  }

}