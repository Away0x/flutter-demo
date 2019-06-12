import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:baixing_shop/provide/tab_index.dart';
import 'package:baixing_shop/provide/cart.dart';
import 'package:baixing_shop/model/detail.dart';

class DetailBottom extends StatelessWidget {

  final GoodInfo data;

  DetailBottom(this.data);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CartProvider>(context);

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
            onTap: () {
              // 切换到购物车页面
              Provider.of<TabIndexProvide>(context).gotoCartPage(context);
            },
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
            onTap: () {
              // 加入购物车
              provider.save(
                goodsId: data.goodsId,
                goodsName: data.goodsName,
                count: 1,
                price: data.presentPrice,
                images: data.image1,
              );
              Fluttertoast.showToast(
                msg: '加入购物车成功',
                gravity: ToastGravity.CENTER,
              );
            },
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
            onTap: () {
              // 清空购物车
              provider.clean();
              Fluttertoast.showToast(
                msg: '购买中',
                gravity: ToastGravity.CENTER,
              );
            },
          ),
        ],
      ),
    );
  }
}