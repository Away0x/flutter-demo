import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:learnui/layouts/home/home_layout.dart';
import 'package:learnui/styles/theme.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: HomeLayout(
            drawerWidth:
                MediaQuery.of(context).size.width * 0.75, // 抽屉宽度占屏幕 0.75
            screenView: const Text('asdasd'),
          ),
        ),
      ),
    );
  }
}
