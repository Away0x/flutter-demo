// 热卖商品
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:baixing_shop/application.dart';

class HotGoods extends StatelessWidget {

  final List<Map> hotGoodsList;

  HotGoods({Key key, this.hotGoodsList}) : super(key: key);

  Widget _buildTitle() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
      ),
      child: Text('火爆专区'),
    );
  }

  Widget _buildList(BuildContext context) {
    if (hotGoodsList.length == 0) {
      return Text(' ');
    }

    return Wrap(
      spacing: 2,
      children: hotGoodsList.map((val) {
        return InkWell(
          child: Container(
            width: ScreenUtil.getInstance().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(bottom: 3),
            child: Column(
              children: <Widget>[
                Image.network(val['image'], width: ScreenUtil.getInstance().setWidth(370)),
                Text(
                  val['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.pink, fontSize: ScreenUtil.getInstance().setSp(26)),
                ),
                Row(
                  children: <Widget>[
                    Text('￥${val["mallPrice"]}'),
                    Text('￥${val["price"]}', style: TextStyle(color: Colors.black26,
                      decoration: TextDecoration.lineThrough)),
                  ],
                ),
              ],
            ),
          ),
          onTap: () {
            Application.router.navigateTo(context, '/detail?id=${val['goodsId']}');
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildTitle(),
          _buildList(context),
        ],
      ),
    );
  }
}