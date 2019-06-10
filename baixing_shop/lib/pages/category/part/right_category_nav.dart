import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:baixing_shop/provide/child_category.dart';

class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {

  Widget _buildRightInkWell(String item) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Text(item, style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(28))),
      ),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<ChildCategory>(context).childCategoryList;

    return Container(
      height: ScreenUtil.getInstance().setHeight(80),
      width: ScreenUtil.getInstance().setWidth(570),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _buildRightInkWell(list[index].mallSubName);
        },
      ),
    );
  }
}