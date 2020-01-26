import 'package:douban_movie/utils/app_utils.dart';
import 'package:douban_movie/utils/cast_utils.dart';

class Movie {
  String id = '';
  String title = '';
  double rating = 0;
  int rank = 0;
  List genres = List();
  List casts = List();
  String durations = '';
  List directors = List();
  String year = '';
  String image = '';
  int collectionCount = 0;

  Movie.castFromMap(dynamic map) {
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

    if (map['genres'] != null && map['genres'] is List) {
      genres = map['genres'];
    }  

    if (map['casts'] != null && map['casts'] is List) {
      for (dynamic cast in map['casts']) {
        casts.add(Cast._castFromMap(cast));
      }      
    }     

    if (map['directors'] != null && map['directors'] is List) {
      for (dynamic cast in map['directors']) {
        directors.add(Cast._castFromMap(cast));
      }      
    }     

    if (map['durations'] != null && map['durations'] is List) {
      List durationList = map['durations'];
      if (durationList.length > 0) {
        durations = durationList[0];
      }      
    }  

    if (map['collect_count'] != null) {
      collectionCount = map['collect_count'];
    }      

    if (map['year'] != null) {
      year = map['year'];
    }  

    if (map['images'] != null && map['images'] is Map) {
      Map images = map['images'];
      if (images['large'] != null) {
        image = images['large'];
      }
    }                
  }
}

class Cast {
  String alt = '';
  String avatar = '';
  String name = '';
  String id = '';

  Cast._castFromMap(dynamic map) {
    if (map['alt'] != null) {
      alt = map['alt'];
    }

    if (map['avatars'] != null && map['avatars'] is Map) {
      Map avatars = map['avatars'];
      if (avatars['large'] != null) {
        avatar = avatars['large'];
      }
    }

    if (map['name'] != null) {
      name = map['name'];
    }

    if (map['id'] != null) {
      id = map['id'];
    }            
  }
}