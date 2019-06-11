import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:baixing_shop/model/category_goods_list_model.dart';
import 'package:baixing_shop/provide/child_category.dart';
import 'package:baixing_shop/provide/category_goods_list.dart';
import 'package:baixing_shop/services/api.dart';


Future<List<CategoryListData>> getMallGoodsUtil(BuildContext context, [bool addToList = false]) {
  var childCatProvider = Provider.of<ChildCategory>(context);

    return getMallGoods(
      categoryId: childCatProvider.categoryId,
      categorySubId: childCatProvider.subId,
      page: childCatProvider.page,
    ).then((val) {
      var provider = Provider.of<CategoryGoodsListProvide>(context);

      if (val == null) {
        if (addToList) {
          provider.addToList([]);
        } else {
          provider.getGoodsList([]);
        }
        return [];
      }

      List<CategoryListData> goodList = (val as List).map((v) {
        return CategoryListData.fromJson(v);
      }).toList();
      
      if (addToList) {
        provider.addToList(goodList); // 添加
      } else {
        provider.getGoodsList(goodList); // 覆盖
      }

      return goodList;
    });
}