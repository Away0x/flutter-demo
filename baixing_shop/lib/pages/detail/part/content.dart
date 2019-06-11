import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';

import '../constants.dart';

class DetailContent extends StatelessWidget {

  final String content;
  final TabIndex currentTabIndex;

  DetailContent({
    this.content,
    this.currentTabIndex,
  });

  @override
  Widget build(BuildContext context) {
    if (currentTabIndex == TabIndex.LEFT) {
      return Container(
        child: Html(data: content),
      );
    }
    
    return Container(
      width: ScreenUtil.getInstance().setWidth(750),
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      child: Text('暂时没有数据'),
    );
  }
}