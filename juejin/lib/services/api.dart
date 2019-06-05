import 'services.dart';

// 获取分类
Future getCategories() async {
  final data = await httpGet('https://gold-tag-ms.juejin.im/v1/categories', headers: httpHeader);

  if (data == null) {
    return null;
  }

  return data['d']['categoryList'];
}

// 获取文章列表
Future getArticleList({String category, int limit = 20}) async {
  final data = await httpGet(
    'https://timeline-merger-ms.juejin.im/v1/get_entry_by_rank',
    params: {
      'src': httpHeader['X-Juejin-Src'],
      'limit': limit,
      'category': category,
    },
  );

  if (data == null) {
    return null;
  }

  return data['d']['entrylist'];
}