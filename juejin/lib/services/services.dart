import 'package:dio/dio.dart';

const httpHeader = {
  'Accept': '*/*',
  'Accept-Encoding': 'gzip, deflate, br',
  'Accept-Language': 'zh-CN,zh;q=0.9',
  'Connection': 'keep-alive',
  'Host': 'gold-tag-ms.juejin.im',
  'Origin': 'https://juejin.im',
  'Referer': 'https://juejin.im/',
  'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36',
  'X-Juejin-Src': 'web',
  'X-Juejin-Client': '',
  'X-Juejin-Token': '',
  'X-Juejin-Uid': '',
};

var dio = Dio(BaseOptions(
  headers: httpHeader,
));

Future<T> httpGet<T>(String path, [Map<String, dynamic> params]) async {
  try {
    final resp = await dio.get<T>(
      path,
      queryParameters: params,
    );
    
    return resp.data;
  } catch (e) {
    print({'path': path, 'params': params, 'err': e});
    return null;
  }
}