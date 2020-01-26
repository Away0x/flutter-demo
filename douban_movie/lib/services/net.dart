import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

typedef void onResponseCallback(int statusCode, dynamic resultMap);

class NetworkHelper {
  static NetworkHelper shared = NetworkHelper();

  //Movie
  void requestCertainMovieInfo(String name, onResponseCallback callback) {
    String encodeName = Uri.encodeComponent('"$name"');
    String url = 'http://sas.qq.com/cgi-bin/db/data?t=%5B%22ke_coding_movie%22%5D&q=%7Bke_coding_movie(_page:1,_limit:1,title:${encodeName})%7Bid,title,rating%7Bmax,average,stars,min,details%7Bscore_1,score_2,score_3,score_4,score_5%7D%7D,genres,casts%7Balt,avatars%7Bsmall,large,medium%7D,name,name_en,id%7D,durations,mainland_pubdate,pubdates,has_video,collect_count,original_title,subtype,directors%7Balt,avatars%7Bsmall,large,medium%7D,name,id%7D,year,images%7Bsmall,large,medium%7D,alt%7D%7D';

    _getNetworkData(url, callback);
  }

  void requestDoubanList(String url, onResponseCallback callback) {
    _getNetworkData(url, callback);
  }

  void _getNetworkData(String url, onResponseCallback callback) async {
    BaseOptions options = BaseOptions(
      method: 'get',
      baseUrl: url,
      connectTimeout: 5000,
      receiveTimeout: 100000,
      contentType: ContentType.json,
      responseType: ResponseType.plain,
      //headers: {'host' : "fudao.qq.com",}
    );
    Dio dio = Dio(options);

    try {
      Response response = await dio.get(url);

      callback(response.statusCode, jsonDecode(response.data));

    } on DioError catch(e) {
      print('network fail');
      if(e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else{
        print(e.request);
        print(e.message);
      }
      callback(404, Map());
    }
  }
}