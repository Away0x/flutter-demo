import 'services.dart';

// 获取分类
Future getCategories() async {
  final data = await httpGet('https://gold-tag-ms.juejin.im/v1/categories');

  if (data == null) {
    return null;
  }

  return data['d']['categoryList'];
}

// 获取文章列表
Future getArticleList({String category, int limit = 20}) async {
  final data = await httpGet(
    'https://timeline-merger-ms.juejin.im/v1/get_entry_by_rank',
    {
      'limit': limit,
      'category': category,
      'src': '',
    },
  );
   print(data);
  if (data == null) {
    return null;
  }

  return data['d']['entryLList'];
}