import 'package:flutter/material.dart';

class NavigationIconView {

  final BottomNavigationBarItem item;

  final String title;
  final String iconPath;
  final String activeIconPath;

  NavigationIconView({
    @required this.title,
    @required this.iconPath,
    @required this.activeIconPath,
  }) : item = BottomNavigationBarItem(
    title: Text(title),
    icon: Image.asset(iconPath, width: 20, height: 20),
    activeIcon: Image.asset(activeIconPath, width: 20, height: 20),
  );

}