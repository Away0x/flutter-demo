import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:baixing_shop/model/category_goods_list_model.dart';
import 'package:baixing_shop/model/category_model.dart';
import 'package:baixing_shop/provide/child_category.dart';
import 'package:baixing_shop/provide/category_goods_list.dart';
import 'package:baixing_shop/services/api.dart';

class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {

  Widget _buildRightInkWell(BxMallSubDto item) {
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
        _getGoodsList();
      },
    );
  }

  void _getGoodsList() {
    var childCatProvider = Provider.of<ChildCategory>(context);

    getMallGoods(
      categoryId: childCatProvider.categoryId,
      categorySubId: childCatProvider.subId,
      page: 1,
    ).then((val) {
      var provider = Provider.of<CategoryGoodsListProvide>(context);

      if (val == null) {
        provider.getGoodsList([]);
        return;
      }

      List<CategoryListData> goodList = (val as List).map((v) {
        return CategoryListData.fromJson(v);
      }).toList();
      
      provider.getGoodsList(goodList);
    });
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
          return _buildRightInkWell(list[index]);
        },
      ),
    );
  }
}
