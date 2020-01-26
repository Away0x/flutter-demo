import 'package:douban_movie/model/douban.dart';

class Watch {
  DoubanCategory category;
  String id;

  Watch(this.category, this.id);

  Watch.fromMap(Map<String, dynamic> map) {
    category = DoubanCategory.values[map['category']];
    id = map['id'];
  }      

  Map toJson() {
    Map map = new Map();
    map["category"] = category.index;
    map["id"] = id;
    return map;
  }    

  static List<Watch> fromList(List list) {
    List<Watch> watchList = List();
    for (dynamic item in list) {
      watchList.add(Watch.fromMap(item));
    }

    return watchList;
  }
}