import 'package:douban_movie/utils/cast_utils.dart';
import 'package:douban_movie/utils/app_utils.dart';

class Music {
  String id = '';
  String title = '';
  double rating = 0;
  int rank = 0;
  String author = '';
  String image = '';
  List tags = List();
  Attr attr;

  Music.castFromMap(dynamic map) {
    if (map['id'] != null) {
      id = map['id'];
    }

    if (map['title'] != null) {
      title = map['title'];
    }    

    if (map['rating'] != null && map['rating'] is Map) {
      Map ratingMap = map['rating'];
      if (ratingMap['average'] != null) {
        rating = StringToDouble('${ratingMap['average']}');        
        rank = AppUtil.getRank(rating);
      }
    }  

    if (map['author'] != null && map['author'] is List) {
      List authorList = map['author'];
      if (authorList.length > 0 && authorList[0] is Map) {
        Map authorMap = authorList[0];
        author = authorMap['name'];
      }
    }

    if (map['image'] != null) {
      image = map['image'];
    }    

    if (map['tags'] != null && map['tags'] is List) {
      List tagList = map['tags'];
      for (dynamic tag in tagList) {
        if (tag is Map) {
          tags.add(tag['name']);
        }
      }
    }  

    attr = Attr.castFromMap(map['attrs']);
  }  
}

class Attr {
  List publisher = List();
  List singer = List();
  List version = List();
  List pubdate = List();
  List tracks = List();

  Attr.castFromMap(dynamic map) {
    if (map['publisher'] != null && map['publisher'] is List) {
      publisher = map['publisher'];
    }        

    if (map['singer'] != null && map['singer'] is List) {
      singer = map['singer'];
    } 

    if (map['version'] != null && map['version'] is List) {
      version = map['version'];
    }   

    if (map['pubdate'] != null && map['pubdate'] is List) {
      pubdate = map['pubdate'];
    }     

    if (map['tracks'] != null && map['tracks'] is List) {
      tracks = map['tracks'];
    }                
  }
}