import 'services.dart';

Future getCategories() async {
  final data = httpGet('https://gold-tag-ms.juejin.im/v1/categories');

  return data;
}