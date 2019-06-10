import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:baixing_shop/provide/category_goods_list.dart';
import 'package:baixing_shop/model/category_goods_list_model.dart';

class GoodsList extends StatefulWidget {
  @override
  _GoodsListState createState() => _GoodsListState();
}

class _GoodsListState extends State<GoodsList> {



  Widget _buildGoodImage(String imgPath) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(200),
      child: Image.network(imgPath),
    );
  }

  Widget _buildGoodName(String name) {
    return Container(
      padding: EdgeInsets.all(5),
      width: ScreenUtil.getInstance().setWidth(370),
      child: Text(
        name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(28)),
      ),
    );
  }

  Widget _buildGoodPrice(double presentPrice, double oriPrice) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: ScreenUtil.getInstance().setWidth(370),
      child: Row(
        children: <Widget>[
          Text('价格: ￥$presentPrice', style: TextStyle(color: Colors.pink, fontSize: ScreenUtil.getInstance().setSp(30))),
          Text('￥$oriPrice', style: TextStyle(color: Colors.black26, decoration: TextDecoration.lineThrough)),
        ],
      ),
    );
  }

  Widget _buildItem(CategoryListData item) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
        ),
        child: Row(
          children: <Widget>[
            _buildGoodImage(item.image),
            Column(
              children: <Widget>[
                _buildGoodName(item.goodsName),
                _buildGoodPrice(item.presentPrice, item.oriPrice),
              ],
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    List<CategoryListData> list = Provider.of<CategoryGoodsListProvide>(context).goodList;

    if (list.length == 0) {
      return Center(child: Text('暂时没有数据'));
    }

    return Expanded(
      child: Container(
        width: ScreenUtil.getInstance().setWidth(570),
        child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _buildItem(list[index]);
        },
      ),
      ),
    );
  }
}