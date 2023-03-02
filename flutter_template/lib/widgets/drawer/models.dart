import 'package:flutter/material.dart';
import 'package:flutter_template/constants/index.dart';

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
