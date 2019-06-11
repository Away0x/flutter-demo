import 'package:flutter/material.dart';
import 'package:baixing_shop/model/category_model.dart';

final all = BxMallSubDto(
  mallSubId: '',
  mallCategoryId: '',
  mallSubName: '全部',
  comments: 'null',
);

// ChangeNotifier: 不用管理听众
class ChildCategory with ChangeNotifier {

  List<BxMallSubDto> childCategoryList = [];
  String categoryId = '4'; // 大类 id
  String subId = ''; // 小类 id
  int page = 1; // 列表页数
  String noMoreText = ''; // 显示更多的标识

  _reset({bool resetCat = true}) {
    if (resetCat) {
      childCategoryList = [all];
    }
    subId = '';
    page = 1;
    noMoreText = '';
  }

  getChildCategory(List<BxMallSubDto> list, String categoryid) {
    _reset();
    categoryId = categoryid;

    childCategoryList.addAll(list);
    notifyListeners();
  }

  // 选择了子类
  selectSubCategory(String subid) {
    _reset(resetCat: false);
    subId = subid;
    notifyListeners();
  }

  addPage() {
    page++;
    notifyListeners();
  }

  changeNoMoreText(String text) {
    noMoreText = text;
    notifyListeners();
  }

}