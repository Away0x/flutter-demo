import 'package:dio/dio.dart';

var dio = Dio();

Future<T> httpGet<T>(String path, [Map<String, dynamic> params]) async {
  try {
    final resp = await dio.get<T>(path, queryParameters: params);

    if (resp.statusCode != 200) {
      return null;
    }

    return resp.data;
  } catch (e) {
    print(e);
    return null;
  }
}