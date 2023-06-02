import 'package:flutter/material.dart';

class AppTheme {
  static const horizontalMargin = 16.0;
  static const radius = 10.0;

  /// 页面背景颜色
  static const Color scaffoldBackground = Color(0xFFFFFFFF);

  /// 主要背景颜色
  // static const Color primaryBackground = Color(0xFF5C78FF);
  /// 主要文本颜色
  static const Color primaryText = Color(0xFF333333);

  /// 次要文本颜色
  static const Color secondaryText = Color(0xFF74788D);

  /// 高亮颜色
  static const Color accentColor = Color(0xFF5C78FF);

  /// 次要颜色
  static const Color secondaryColor = Color(0xFFDEE3FF);

  /// 警告颜色
  static const Color warnColor = Color(0xFFFFB822);

  /// 边框颜色
  static const Color borderColor = Color(0xFFDEE3FF);
  static const Color pinkColor = Color(0xFFF77866);
  static const Color yellowColor = Color(0xFFFFB822);

  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: scaffoldBackground,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    primaryColor: accentColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: accentColor,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: primaryText,
      ),
      titleTextStyle: TextStyle(
        color: primaryText,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      toolbarTextStyle: TextStyle(
        color: primaryText,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: scaffoldBackground,
      unselectedLabelStyle: TextStyle(fontSize: 12),
      selectedLabelStyle: TextStyle(fontSize: 12),
      unselectedItemColor: Color(0xffA2A5B9),
      selectedItemColor: accentColor,
    ),
    tabBarTheme: const TabBarTheme(
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: accentColor,
      unselectedLabelColor: secondaryText,
    ),
  );
}
