import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:flutter/rendering.dart';

import './provide/child_category.dart';
import './pages/index/index.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // debugPaintSizeEnabled = true;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => ChildCategory()),
      ],
      child: Container(
        child: MaterialApp(
          title: '百姓生活+',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.pink,
          ),
          home: IndexPage(),
        ),
      ),
    );
  }
}
