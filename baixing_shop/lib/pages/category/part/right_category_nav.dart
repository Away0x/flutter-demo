import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:baixing_shop/model/category_goods_list_model.dart';
import 'package:baixing_shop/model/category_model.dart';
import 'package:baixing_shop/provide/child_category.dart';
import 'package:baixing_shop/provide/category_goods_list.dart';
import 'package:baixing_shop/services/api.dart';

import '../utils/utils.dart';

class RightCategoryNav extends StatelessWidget {

  Widget _buildRightInkWell(BuildContext context, BxMallSubDto item) {
    String curSubID = Provider.of<ChildCategory>(context).subId;

    return InkWell(
      child: Container(
        padding: EdgeInsets.only(top: 15, left: 5, right: 5),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil.getInstance().setSp(28),
            color: item.mallSubId == curSubID ? Colors.pink : Colors.black,
          )
        ),
      ),
      onTap: () {
        Provider.of<ChildCategory>(context).selectSubCategory(item.mallSubId);
        _getGoodsList(context);
      },
    );
  }

  void _getGoodsList(BuildContext context) {
    getMallGoodsUtil(context);
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
          return _buildRightInkWell(context, list[index]);
        },
      ),
    );
  }
}
