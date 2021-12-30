import 'package:flutter/material.dart';
import 'package:learnui/constants/drawer.dart';

class DrawerListItem {
  DrawerListItem({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    required this.index,
    this.imageName = '',
  });

  String labelName;
  Icon? icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex index;
}
