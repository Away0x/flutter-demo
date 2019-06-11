import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailExplain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: ScreenUtil.getInstance().setWidth(750),
      padding: EdgeInsets.all(10),
      child: Text(
        '说明: > 急速送达 > 正品保证',
        style: TextStyle(color: Colors.red, fontSize: ScreenUtil.getInstance().setSp(30)),
      ),
    );
  }
}