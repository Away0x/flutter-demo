import 'package:flutter/material.dart';

import 'package:juejin/app.dart';

import 'package:juejin/pages/search/search.dart';
import 'package:juejin/pages/share_article/share_article.dart';
import 'package:juejin/pages/put_hot/put_hot.dart';
import 'package:juejin/pages/books/books.dart';
import 'package:juejin/pages/activities/activities.dart';
import 'package:juejin/pages/login/login.dart';
import 'package:juejin/pages/settings/settings.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        splashColor: Colors.transparent,
        bottomAppBarColor: Color.fromRGBO(244, 245, 245, 1),
        scaffoldBackgroundColor: Color.fromRGBO(244, 245, 245, 1),
        backgroundColor: Color.fromRGBO(244, 245, 245, 1),
        primaryIconTheme: IconThemeData(color: Colors.blue),
        indicatorColor: Colors.blue,
        iconTheme: IconThemeData(size: 18),
        primaryTextTheme: TextTheme(title: TextStyle(color: Colors.black, fontSize: 16)),
      ),
      home: AppIndex(),
      routes: <String, WidgetBuilder>{
        '/search': (context) => SearchPage(),
        '/share_article': (context) => ShareArticlePage(),
        '/put_hot': (context) => PutHotPage(),
        '/books': (context) => BooksPage(),
        '/activities': (context) => ActivitiesPage(),
        '/login': (context) => LoginPage(),
        '/settings': (context) => SettingsPage(),
      },
    )
  );
}
