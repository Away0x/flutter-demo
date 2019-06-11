import 'package:flutter/material.dart';

import 'package:baixing_shop/model/category_goods_list_model.dart';

class CategoryGoodsListProvide with ChangeNotifier {

  List<CategoryListData> goodList = [];

  // 点击大类时更换商品列表
  getGoodsList(List<CategoryListData> list) {
    goodList = list;
    notifyListeners();
  }

  addToList(List<CategoryListData> list) {
    goodList.addAll(list);
    notifyListeners();
  }

}