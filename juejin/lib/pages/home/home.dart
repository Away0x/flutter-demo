import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:juejin/services/api.dart';
import './part/tab_wrapper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCategories(),
      builder: (context, snapshot) {
        // 加载中
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            // child: SpinKitHourGlass(color: Colors.blue, size: 50),
            child: CupertinoActivityIndicator(),
          );
        }

        // 加载完成
        if (snapshot.connectionState == ConnectionState.done) {
          List<dynamic> data = snapshot.data;

          // 没有数据
          if (!snapshot.hasData || snapshot.hasError || data == null || (data.length < 1)) {
            var msg = snapshot.error == null ? '暂无数据' : snapshot.error.toString();

            return Container(
              color: Color.fromRGBO(244, 245, 245, 1),
              child: Center(child: Text(msg))
            );
          }

          return TabWrapper(list: data);
        }
      },
    );
  }
}