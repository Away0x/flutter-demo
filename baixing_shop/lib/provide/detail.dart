import 'package:flutter/material.dart';

import 'package:baixing_shop/services/api.dart';
import 'package:baixing_shop/model/detail.dart';

class DetailProvide with ChangeNotifier {

  DetailsGoodsData goodDetail;

  fetchGoodDetail(String id) async {
    await getGoodDetail(id).then((val) {
      goodDetail = val;
      notifyListeners();
    });
  }

}