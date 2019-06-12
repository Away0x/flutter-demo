import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:baixing_shop/model/cart_info.dart';

const SP_KEY = 'cartInfo';

enum ReduceOrAddAction {
  Add,    // 加
  Reduce, // 减
}

class CartProvider with ChangeNotifier {

  String cartString = '[]'; // 购物车数据
  
  // 同步数据到本地存储中
  _sync(List<CartInfoMode> list) async {
    cartString = json.encode(list.map((v) => v.toJson()).toList()).toString();
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(SP_KEY, cartString);
  }

  Future<List<CartInfoMode>> _getLocalList() async {
    // 初始化 shared_preferences，获取本地存储的数据
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString(SP_KEY);
    var localData = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> localList = (localData as List).cast();
    List<CartInfoMode> cartInfoList = [];
    localList.forEach((v) {
      cartInfoList.add(CartInfoMode.fromJson(v));
    });

    return cartInfoList;
  }

  // 获取数据
  Future<List<CartInfoMode>> fetchData() async {
    var localList = await _getLocalList();
    return localList;
  }

  // 添加商品到购物车
  save({
    String goodsId,
    String goodsName,
    int count,
    double price,
    String images,
  }) async {
    var localList = await _getLocalList();

    // 存储的数据是否存在
    int index = localList.indexWhere((e) => e.goodsId == goodsId);
    if (index != -1) {
      var item = localList[index];
      item.count = item.count + 1; // 已存在 +1
    } else {
      var temp = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
        'isCheck': true,
      };
      localList.add(CartInfoMode.fromJson(temp));
    }

    // 存储到本地
    _sync(localList);
    notifyListeners();
  }

  // 清空购物车
  clean() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove(SP_KEY);
    notifyListeners();
  }

  // 删除商品
  remove(String goodId) async {
    var localList = await _getLocalList();
    localList.removeWhere((v) => v.goodsId == goodId);
    _sync(localList);
    notifyListeners();
  }

  // 全选商品
  allChecked(bool checked) async {
    var localList = await _getLocalList();
    localList.forEach((v) => v.isCheck = checked);
    _sync(localList);
    notifyListeners();
  }

  // 选中、取消选中商品
  checked(String goodId, bool checked) async {
    var localList = await _getLocalList();
    int index = localList.indexWhere((v) => v.goodsId == goodId);
    if (index == -1) { return; }

    localList[index].isCheck = checked;
    _sync(localList);
    notifyListeners();
  }

  // 商品数量加减
  reduceOrAdd(String goodId, ReduceOrAddAction action) async {
    var localList = await _getLocalList();
    int index = localList.indexWhere((v) => v.goodsId == goodId);
    if (index == -1) { return; }

    var item = localList[index];
    if (action == ReduceOrAddAction.Add) {
      item.count++;
    } else if (action == ReduceOrAddAction.Reduce) {
      if (item.count <= 1) { return; }
      item.count--;
    }

    _sync(localList);
    notifyListeners();
  }

}