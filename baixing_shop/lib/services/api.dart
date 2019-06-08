import './services.dart';

// 获取首页数据
Future getHomeData() async {
  var resource = await httpPOST('wxmini/homePageContent', data: {
    'lon': 115.02932,
    'lat': 35.76189,
  });

  if (resource['code'] == '0') {
    return resource['data'];
  }

  return resource;
}

// 获取首页热卖商品
Future getHotGoodsData({int page = 1}) async {
  var resource = await httpPOST('wxmini/homePageBelowConten', data: {
    'page': page,
  });

  if (resource['code'] == '0') {
    return resource['data'];
  }

  return resource;
}

// 获取商品分类
Future getCategory() async {
  var resource = await httpPOST('wxmini/getCategory');

  if (resource['code'] == '0') {
    return resource['data'];
  }

  return resource;
}