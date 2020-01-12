enum DoubanCategory {
  Movie,
  Book,
  Music
}

class DoubanModel {
  static String getDoubanTitle(DoubanCategory cat) {
    if (cat == DoubanCategory.Movie) {
      return '电影';
    } else if (cat == DoubanCategory.Book) {
      return '图书';
    } else {
      return '音乐';
    }
  }

  static List<String> getMoreTitle(DoubanCategory cat) {
    if (cat == DoubanCategory.Movie) {
      return ['近期热映', '猜你喜欢', '豆瓣热门'];
    } else if (cat == DoubanCategory.Book) {
      return ['新书速递', '今日推荐', '豆瓣热门'];
    } else {
      return ['新碟榜', '豆瓣热门'];
    }
  }
}