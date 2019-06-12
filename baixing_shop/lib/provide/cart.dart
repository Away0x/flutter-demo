import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const SP_KEY = 'cartInfo';

class CartProvider with ChangeNotifier {

  String cartString = '[]';

  // 添加商品到购物车
  save({
    String goodsId,
    String goodsName,
    int count,
    double price,
    String images,
  }) async {
    // 初始化 shared_preferences，获取本地存储的数据
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString(SP_KEY);
    var localData = cartString ?? json.decode(cartString.toString());
    List<Map> localList = (localData as List).cast();

    // 存储的数据是否存在
    int index = localList.indexWhere((e) => e['goodsId'] == goodsId);
    if (index != -1) {
      var item = localList[index];
      item['count'] = item['count'] + 1;
    } else {
      localList.add({
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
      });
    }

    // 存储到本地
    cartString = json.encode(localList).toString();
    sp.setString(SP_KEY, cartString);
    notifyListeners();
  }

  // 清空购物车
  clean() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove(SP_KEY);
    notifyListeners();
  }

}