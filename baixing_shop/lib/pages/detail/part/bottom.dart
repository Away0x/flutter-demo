import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(750),
      height: ScreenUtil.getInstance().setHeight(80),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          InkWell(
            child: Container(
              width: ScreenUtil.getInstance().setWidth(110),
              alignment: Alignment.center,
              child: Icon(Icons.shopping_cart, size: 35, color: Colors.red),
            ),
            onTap: () {},
          ),
          InkWell(
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil.getInstance().setWidth(320),
              height: ScreenUtil.getInstance().setHeight(80),
              color: Colors.green,
              child: Text(
                '加入购物车',
                style: TextStyle(color: Colors.white, fontSize: ScreenUtil.getInstance().setSp(28)),
              ),
            ),
            onTap: () {},
          ),
          InkWell(
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil.getInstance().setWidth(320),
              height: ScreenUtil.getInstance().setHeight(80),
              color: Colors.red,
              child: Text(
                '马上购买',
                style: TextStyle(color: Colors.white, fontSize: ScreenUtil.getInstance().setSp(28)),
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}