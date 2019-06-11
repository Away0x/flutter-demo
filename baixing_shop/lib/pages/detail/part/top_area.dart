import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:baixing_shop/model/detail.dart';

class DetailTopArea extends StatelessWidget {

  final DetailsGoodsData goodDetail;

  DetailTopArea(this.goodDetail);

  Widget _buildGoodsImage(String url) {
    return Image.network(url, width: ScreenUtil.getInstance().setWidth(740));
  }

  Widget _buildGoodName(String name) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(740),
      padding: EdgeInsets.only(left: 15),
      child: Text(name, style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(30))),
    );
  }

  Widget _buildGoodNum(String num) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(730),
      padding: EdgeInsets.only(left: 15),
      margin: EdgeInsets.only(top: 8),
      child: Text(
        '编号: $num',
        style: TextStyle(color: Colors.black26),
      ),
    );
  }

  Widget _buildGoodPrice(double presentPrice, double oriPrice) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.only(left: 15, bottom: 10),
      width: ScreenUtil.getInstance().setWidth(730),
      child: Row(
        children: <Widget>[
          Text(
            '￥$presentPrice',
            style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(50), color: Colors.deepOrangeAccent),
          ),
          Padding(padding: EdgeInsets.only(left: 20), child: Text('市场价')),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              '￥$oriPrice',
              style: TextStyle(color: Colors.black26, decoration: TextDecoration.lineThrough),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var detail = goodDetail?.goodInfo;
    
    if (detail == null) {
      return Text('正在加载中...');
    }

    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _buildGoodsImage(detail.image1),
          _buildGoodName(detail.goodsName),
          _buildGoodNum(detail.goodsSerialNumber),
          _buildGoodPrice(detail.presentPrice, detail.oriPrice),
        ],
      ),
    );
  }
}