// 推荐商品
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Recommend extends StatelessWidget {

  final List recommendList;

  Recommend({Key key, this.recommendList}) : super(key: key);

  Widget _buildTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 2, 0, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
      ),
      child: Text('商品推荐', style: TextStyle(color: Colors.pink)),
    );
  }

  Widget _buildItem(int index) {
    return InkWell(
      child: Container(
        height: ScreenUtil.getInstance().setHeight(330),
        width: ScreenUtil.getInstance().setWidth(250),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(left: BorderSide(width: 1, color: Colors.black12)),
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]["mallPrice"]}'),
            Text(
              '￥${recommendList[index]["price"]}',
              style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey),
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }

  Widget _buildRecommendList() {
    return Container(
      height: ScreenUtil.getInstance().setHeight(330),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context, index) {
          return _buildItem(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.getInstance().setHeight(380),
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _buildTitle(),
          _buildRecommendList(),
        ],
      ),
    );
  }
}