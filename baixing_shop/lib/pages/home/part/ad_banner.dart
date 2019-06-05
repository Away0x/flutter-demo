// 广告 banner
import 'package:flutter/material.dart';

class AdBanner extends StatelessWidget {

  final String abPicture;

  AdBanner({Key key, this.abPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(abPicture),
    );
  }
}