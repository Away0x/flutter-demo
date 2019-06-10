import 'package:flutter/material.dart';
import 'package:baixing_shop/model/category_model.dart';

final all = BxMallSubDto(
  mallSubId: '00',
  mallCategoryId: '00',
  mallSubName: '全部',
  comments: 'null',
);

// ChangeNotifier: 不用管理听众
class ChildCategory with ChangeNotifier {

  List<BxMallSubDto> childCategoryList = [];

  getChildCategory(List<BxMallSubDto> list) {
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

}