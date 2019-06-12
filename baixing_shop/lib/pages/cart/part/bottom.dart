import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:baixing_shop/components/confirm_alert/confirm_alert.dart';
import 'package:baixing_shop/provide/cart.dart';
import 'package:baixing_shop/model/cart_info.dart';

class CartBottom extends StatelessWidget {

  final List<CartInfoMode> list;

  CartBottom(this.list);

  Widget _buildSelectAllBtn(BuildContext context, bool allChecked) {
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: allChecked,
            activeColor: Colors.pink,
            onChanged: (bool val) {
              Provider.of<CartProvider>(context).allChecked(val);
            },
          ),
          Text('全选'),
        ],
      ),
    );
  }

  Widget _buildAllPriceArea(double price) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(430),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil.getInstance().setWidth(280),
                child: Text(
                  '合计',
                  style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(36)),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: ScreenUtil.getInstance().setWidth(150),
                child: Text(
                  '￥$price',
                  style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(36), color: Colors.red),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerRight,
            width: ScreenUtil.getInstance().setWidth(430),
            child: Text(
              '满10元免配送费，预购免配送费',
              style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(22), color: Colors.black38),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverBtn(BuildContext context, int count, double price) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(160),
      padding: EdgeInsets.only(left: 10),
      child: InkWell(
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(3)),
          child: Text(
            '结算($count)',
            style: TextStyle(color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        onTap: () {
          if (count == 0) {
            Fluttertoast.showToast(msg: '请先选择要购买的商品', gravity: ToastGravity.CENTER);
            return;
          }
          
          _overAlert(context, price);
        },
      ),
    );
  }

  _overAlert(BuildContext context, double price) {
    String _price = price.toStringAsFixed(2);
    ConfirmAlert(
      context: context,
      title: '应付款 $_price 元，是否确定购买',
      sureButtonPress: () {
        Provider.of<CartProvider>(context).clean();
        Fluttertoast.showToast(msg: '已购买，付款 $_price 元', gravity: ToastGravity.CENTER);
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    int count = 0;
    double allPrice = 0;
    int checkedLength = 0;

    list.forEach((v) {
      if (!v.isCheck) { return; }

      count += v.count;
      allPrice += (v.price * v.count);
      checkedLength += 1;
    });

    return Container(
      margin: EdgeInsets.all(5),
      width: ScreenUtil.getInstance().setWidth(750),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          _buildSelectAllBtn(context, checkedLength == list.length),
          _buildAllPriceArea(allPrice),
          _buildOverBtn(context, count, allPrice),
        ],
      ),
    );
  }
}