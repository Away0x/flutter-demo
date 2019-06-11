import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';

typedef ClickTabCallBack = void Function(TabIndex tabIndex);

class DetailTabbar extends StatelessWidget {

  final TabIndex currentIndex;
  final ClickTabCallBack clickTabCallBack;

  final Map<TabIndex, String> tabTitles = {
    TabIndex.LEFT: '详情',
    TabIndex.RIGHT: '评论',
  };

  DetailTabbar({
    this.currentIndex,
    this.clickTabCallBack,
  });

  Widget _buildTabItem(TabIndex index) {
    var color = index == currentIndex ? Colors.pink : Colors.black26;

    return InkWell(
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: ScreenUtil.getInstance().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: color)),
        ),
        child: Text(
          tabTitles[index],
          style: TextStyle(color: color),
        ),
      ),
      onTap: () {
        clickTabCallBack(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          _buildTabItem(TabIndex.LEFT),
          _buildTabItem(TabIndex.RIGHT),
        ],
      ),
    );
  }
}