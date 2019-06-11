// 楼层
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:baixing_shop/router/router.dart';
import 'package:baixing_shop/application.dart';

class FloorTitle extends StatelessWidget {

  final String pictureAddr; // 图片地址

  FloorTitle({Key key, this.pictureAddr}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Image.network(pictureAddr),
    );
  }
}


class FloorContent extends StatelessWidget {

  final List floorGoodsList;

  FloorContent({Key key, this.floorGoodsList}) : super(key: key);

  Widget _buildFirstRow(BuildContext context) {
    return Row(
      children: <Widget>[
        _buildGoodItem(context, floorGoodsList[0]),
        Column(
          children: <Widget>[
            _buildGoodItem(context, floorGoodsList[1]),
            _buildGoodItem(context, floorGoodsList[2]),
          ],
        ),
      ],
    );
  }

  Widget _buildOtherGoods(BuildContext context) {
    return Row(
      children: <Widget>[
        _buildGoodItem(context, floorGoodsList[3]),
        _buildGoodItem(context, floorGoodsList[4]),
      ],
    );
  }

  Widget _buildGoodItem(BuildContext context, Map good) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(375),
      child: InkWell(
        child: Image.network(good['image']),
        onTap: () {
          Application.router.navigateTo(context, '${MyRouter.detailPage}?id=${good['goodsId']}');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildFirstRow(context),
          _buildOtherGoods(context),
        ],
      ),
    );
  }
}