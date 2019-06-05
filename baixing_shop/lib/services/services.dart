import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:convert';

const API_ROOT = 'http://v.jspang.com:8088/baixing/';

var dio = Dio(BaseOptions(
  contentType: ContentType.parse('application/x-www-form-urlencoded'),
));

Future<T> httpGET<T>(String path, {params}) async {
  try {
    Response resp = await dio.get(API_ROOT + path, queryParameters: params);

    if (resp.statusCode == 200) {
      var data = json.decode(resp.data.toString());
      return data;
    }
    
    throw Exception('$path 网络错误');
  } catch (e) {
    throw Exception('$path 网络错误: $e');
  }
}

Future<T> httpPOST<T>(String path, {data}) async {
  try {
    Response resp = await dio.post(API_ROOT + path, data: data);

    if (resp.statusCode == 200) {
      var data = json.decode(resp.data.toString());
      return data;
    }
    print(resp.statusCode);
    
    throw Exception('$path 网络错误');
  } catch (e) {
    throw Exception('$path 网络错误: $e');
  }
}