import 'package:douban_movie/utils/app_utils.dart';
import 'package:douban_movie/utils/cast_utils.dart';

class Book {
  String id = '';
  String title = '';
  double rating = 0;
  int rank = 0;  
  List author = List();
  String pubdate = '';
  List<String> tags = List();
  String image = '';
  List translator = List();
  String catalog = '';
  String alt = '';
  String publisher = '';
  String authorIntro = '';
  String summary = '';
  String price = '';

  Book.castFromMap(dynamic map) {
    if (map['id'] != null) {
      id = map['id'];
    }

    if (map['title'] != null) {
      title = map['title'];
    }

    if (map['rating'] != null && map['rating'] is Map) {
      Map ratingMap = map['rating'];
      if (ratingMap['average'] != null) {
        rating = StringToDouble(ratingMap['average']);
        rank = AppUtil.getRank(rating);
      }
    }    

    if (map['author'] != null && map['author'] is List) {
      author = map['author'];
    }     

    if (map['pubdate'] != null) {
      pubdate = map['pubdate'];
    }    

    if (map['tags'] != null && map['tags'] is List) {
      List tagList = map['tags'];
      tags = _getTagFromList(tagList);
    }

    if (map['image'] != null) {
      image = map['image'];
    }    

    if (map['translator'] != null && map['translator'] is List) {
      translator = map['translator'];
    }   

    if (map['catalog'] != null) {
      catalog = map['catalog'];
    }     

    if (map['alt'] != null) {
      alt = map['alt'];
    }   

    if (map['publisher'] != null) {
      publisher = map['publisher'];
    }    

    if (map['author_intro'] != null) {
      authorIntro = map['author_intro'];
    }  

    if (map['summary'] != null) {
      summary = map['summary'];
    }     

    if (map['price'] != null) {
      price = map['price'];
    }          
  }  

  List<String> _getTagFromList(List tagList) {
    List<String> tags = List();
    for (dynamic tag in tagList) {
      if (tag is Map && tag['name'] != null) {
        tags.add(tag['name']);
      }
    }

    return tags;
  }
}