import 'dart:async';
import 'dart:convert';

import 'package:ctrip/model/search_model.dart';
import 'package:http/http.dart' as http;

const SEARCH_URL = 'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';

///首页大接口
class SearchDao {
  static Future<SearchModel> fetch(String keyword) async {
    final response = await http.get(SEARCH_URL+keyword);

    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      print(result);
      return SearchModel.fromJson(result);
    } else {
      throw Exception('Failed to load home_page.json');
    }
  }
}
