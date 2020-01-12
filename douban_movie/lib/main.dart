import 'dart:async';
import 'package:flutter/material.dart';

import 'package:douban_movie/pages/navigation_bar.dart';
import 'package:douban_movie/pages/search/search_page.dart';

void main() {
  FlutterError.onError = (details) {
    print('flutter catch error: $details');
  };

  runZoned(
    () => runApp(MyApp()),
    onError: (obj, stack) {
      print('flutter catch error, obj: $obj, \nstack: $stack');
    },
  );
}

class MyApp extends StatelessWidget {

  Map<String, WidgetBuilder> _routes() {
    return {
      '/search': (context) => SearchPage(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: _routes(),
      home: NavigationBar(),
    );
  }
}
