import './services.dart';

// 处理 response
dynamic _resolveResp(dynamic data) {
  if (data['code'] == '0') {
    return data['data'];
  }

  return data;
}

// 获取首页数据
Future getHomeData() async {
  var resource = await httpPOST('wxmini/homePageContent', data: {
    'lon': 115.02932,
    'lat': 35.76189,
  });

  return _resolveResp(resource);
}

// 获取首页热卖商品
Future getHotGoodsData({int page = 1}) async {
  var resource = await httpPOST('wxmini/homePageBelowConten', data: {
    'page': page,
  });

  return _resolveResp(resource);
}

// 获取商品分类
Future getCategory() async {
  var resource = await httpPOST('wxmini/getCategory');

  return _resolveResp(resource);
}

// 获取分类的商品列表
Future getMallGoods({String categoryId, String categorySubId = '', int page = 1}) async {
  var resource = await httpPOST('wxmini/getMallGoods', data: {
    'categoryId': categoryId,
    'categorySubId': categorySubId,
    'page': page,
  });

  return _resolveResp(resource);
}