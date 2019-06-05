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