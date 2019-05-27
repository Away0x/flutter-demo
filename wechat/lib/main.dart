import 'package:flutter/material.dart';
import 'package:wechat/constants.dart' show AppColors;
import 'package:wechat/app.dart';

void main() {
  runApp(
    MaterialApp(
      title: '微信',
      theme: ThemeData.light().copyWith(
        primaryColor: Color(AppColors.AppBarColor),
        cardColor: Color(AppColors.AppBarColor)
      ),
      home: AppScreen(),
    )
  );
}