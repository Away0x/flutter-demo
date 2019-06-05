// gird 导航
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavGrid extends StatelessWidget {

  final List navList;

  NavGrid({Key key, this.navList}) : super(key: key);

  Widget _buildItem(BuildContext context, item) {
    return InkWell(
      child: Column(
        children: <Widget>[
          Image.network(item['image'], width: ScreenUtil.getInstance().setWidth(95)),
          Text(item['mallCategoryName'])
        ],
      ),
      onTap: () {
        print('点击了导航');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (navList.length > 10) {
      navList.removeRange(10, navList.length);
    }
    
    return Container(
      height: ScreenUtil.getInstance().setHeight(270),
      padding: EdgeInsets.all(3),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(4),
        children: navList.map((item) {
          return _buildItem(context, item);
        }).toList(),
      ),
    );
  }
}