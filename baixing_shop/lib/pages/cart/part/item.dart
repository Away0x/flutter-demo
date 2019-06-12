import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:baixing_shop/components/confirm_alert/confirm_alert.dart';
import 'package:baixing_shop/provide/cart.dart';
import 'package:baixing_shop/model/cart_info.dart';
import 'package:baixing_shop/application.dart';
import 'package:baixing_shop/router/router.dart';

import './count.dart';

class CartItem extends StatelessWidget {

  final CartInfoMode item;

  CartItem(this.item);

  // 多选按钮
  Widget _buildCartCheckBox(BuildContext context) {
    return Container(
      child: Checkbox(
        value: item.isCheck,
        activeColor: Colors.pink,
        onChanged: (bool val) {
          Provider.of<CartProvider>(context).checked(item.goodsId, val);
        },
      ),
    );
  }

  // 商品图片
  Widget _buildCartImage(BuildContext context) {
    return InkWell(
      child: Container(
        width: ScreenUtil.getInstance().setWidth(140),
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black12),
        ),
        child: Image.network(item.images),
      ),
      onTap: () {
        Application.router.navigateTo(context, '${MyRouter.detailPage}?id=${item.goodsId}');
      },
    );
  }

  // 商品名称
  Widget _buildCartGoodName() {
    return Container(
      width: ScreenUtil.getInstance().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(item.goodsName),
          CartCount(item),
        ],
      ),
    );
  }

  // 商品价格
  Widget _buildCartPrice(BuildContext context) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('￥${item.price}'),
          Container(
            child: InkWell(
              child: Icon(Icons.delete_forever, color: Colors.black26, size: 30),
              onTap: () {
                // 删除商品
                _deleteGoodAlert(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  _deleteGoodAlert(BuildContext context) {
    ConfirmAlert(
      context: context,
      title: '是否确定删除该商品',
      alertType: AlertType.warning,
      sureButtonPress: () {
        Provider.of<CartProvider>(context).remove(item.goodsId);
        Fluttertoast.showToast(msg: '删除成功', gravity: ToastGravity.CENTER);
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
      ),
      child: Row(
        children: <Widget>[
          _buildCartCheckBox(context),
          _buildCartImage(context),
          _buildCartGoodName(),
          _buildCartPrice(context),
        ],
      ),
    );
  }
}