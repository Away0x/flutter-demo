import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:baixing_shop/provide/cart.dart';
import 'package:baixing_shop/model/cart_info.dart';

class CartCount extends StatelessWidget {

  final CartInfoMode item;

  CartCount(this.item);

  // 减号按钮
  Widget _buildReduceBtn(BuildContext context) {
    return InkWell(
      child: Container(
        width: ScreenUtil.getInstance().setWidth(45),
        height: ScreenUtil.getInstance().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: item.count > 1 ? Colors.white : Colors.black12,
          border: Border(right: BorderSide(width: 1, color: Colors.black12)),
        ),
        child: item.count > 1 ? Text('-') : Text(' '),
      ),
      onTap: () {
        Provider.of<CartProvider>(context).reduceOrAdd(item.goodsId, ReduceOrAddAction.Reduce);
      },
    );
  }

  // 中间数量显示区域
  Widget _buildContent() {
    return Container(
      width: ScreenUtil.getInstance().setWidth(70),
      height: ScreenUtil.getInstance().setHeight(45),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text('${item.count}'),
    );
  }

  // 加号按钮
  Widget _buildAddBtn(BuildContext context) {
    return InkWell(
      child: Container(
        width: ScreenUtil.getInstance().setWidth(45),
        height: ScreenUtil.getInstance().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(left: BorderSide(width: 1, color: Colors.black12)),
        ),
        child: Text('+'),
      ),
      onTap: () {
        Provider.of<CartProvider>(context).reduceOrAdd(item.goodsId, ReduceOrAddAction.Add);
      },
    ); 
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(165),
      margin: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black12),
      ),
      child: Row(
        children: <Widget>[
          _buildReduceBtn(context),
          _buildContent(),
          _buildAddBtn(context),
        ],
      ),
    );
  }
}