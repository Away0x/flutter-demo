import 'package:douban_movie/services/net.dart';
import 'package:douban_movie/model/book.dart';
import 'package:douban_movie/model/douban.dart';
import 'package:douban_movie/model/movie.dart';
import 'package:douban_movie/model/music.dart';
import 'package:douban_movie/utils/app_utils.dart';

class CategoryService {
  final DoubanCategory category;
  final void Function() onDataCallback;

  CategoryService({
    this.category,
    this.onDataCallback
  }) {
    tabbarTitles = DoubanModel.getMoreTitle(category);
  }


  bool isPageLoading = true;
  int page = 1;
  bool isCollection = false;
  bool isHot = false;
  bool isNew = false;

  List<String> tabbarTitles;
  List movieList = List();
  List bookList = List();
  List musicList = List();

  void reset() {
    movieList.clear();
    bookList.clear();
    musicList.clear();
    page = 1;
    isPageLoading = true;
    isCollection = false;
    isHot = false;
    isNew = false;
  }

  //Movie
  void requestRecentMovie() {
    String url = 'http://sas.qq.com/cgi-bin/db/data?t=%5B%22ke_coding_movie%22%5D&q=%7Bke_coding_movie(_page:$page,_limit:10,year:%22%252019%25%22)%7Bid,title,rating%7Bmax,average,stars,min,details%7Bscore_1,score_2,score_3,score_4,score_5%7D%7D,genres,casts%7Balt,avatars%7Bsmall,large,medium%7D,name,name_en,id%7D,durations,mainland_pubdate,pubdates,has_video,collect_count,original_title,subtype,directors%7Balt,avatars%7Bsmall,large,medium%7D,name,id%7D,year,images%7Bsmall,large,medium%7D,alt%7D%7D';
    NetworkHelper.shared.requestDoubanList(url, _onMovieCallback);
  }

  void requestCollectionMovie() {
    isCollection = true;
    String url = 'http://sas.qq.com/cgi-bin/db/data?t=%5B%22ke_coding_movie%22%5D&q=%7Bke_coding_movie(_page:$page,_limit:10)%7Bid,title,rating%7Bmax,average,stars,min,details%7Bscore_1,score_2,score_3,score_4,score_5%7D%7D,genres,casts%7Balt,avatars%7Bsmall,large,medium%7D,name,name_en,id%7D,durations,mainland_pubdate,pubdates,has_video,collect_count,original_title,subtype,directors%7Balt,avatars%7Bsmall,large,medium%7D,name,id%7D,year,images%7Bsmall,large,medium%7D,alt%7D%7D';
    NetworkHelper.shared.requestDoubanList(url, _onMovieCallback);
  }

  void requestHotMovie() {
    NetworkHelper.shared.requestDoubanList('https://api.douban.com/v2/movie/top250?apikey=0b2bdeda43b5688921839c8ecb20399b', _onHotMovieCallback);
  }

  void _onMovieCallback(int statusCode, dynamic resultMap) {
    if (statusCode == 200 && resultMap is Map) {
      for (dynamic result in resultMap['result']) {

        if (isCollection) {
          Movie movie = Movie.castFromMap(result);
          if (movie.collectionCount > 100000) {
            movieList.add(movie);
          }
        } else {
          movieList.add(Movie.castFromMap(result));
        }
      }

      // if (isCollection && movieList.length == 0) {
      //   requestCollectionMovie();
      //   return;
      // }

      isCollection = false;
      onDataCallback();
    }
  }

  void _onHotMovieCallback(int statusCode, dynamic resultMap) {
    if (statusCode == 200 && resultMap is Map) {
      for (dynamic result in resultMap['subjects']) {
        movieList.add(Movie.castFromMap(result));
      }

      onDataCallback();
    }
  }

  //Book
  void requestRecentBook() {
    String url = 'http://sas.qq.com/cgi-bin/db/data?t=%5B%22ke_coding_book%22%5D&q=%7Bke_coding_book(_page:$page,_limit:10,pubdate:%222019%25%22)%7Bid,title,rating%7Bmax,numRaters,average,min%7D,subtitle,author,pubdate,tags%7Bcount,name,title%7D,origin_title,image,binding,translator,catalog,pages,images%7Bsmall,large,medium%7D,alt,publisher,isbn10,isbn13,url,alt_title,author_intro,summary,price,ebook_price,ebook_url,series%7Bid,title%7D%7D%7D';
    NetworkHelper.shared.requestDoubanList(url, _onBookCallback);
  }

  void requestRecommandBook({int limit = 10}) {
    int currentDay = AppUtil.getCurrentDay();
    String url = 'http://sas.qq.com/cgi-bin/db/data?t=%5B%22ke_coding_book%22%5D&q=%7Bke_coding_book(_page:$page,_limit:10,pubdate:%22%25$currentDay%25%22)%7Bid,title,rating%7Bmax,numRaters,average,min%7D,subtitle,author,pubdate,tags%7Bcount,name,title%7D,origin_title,image,binding,translator,catalog,pages,images%7Bsmall,large,medium%7D,alt,publisher,isbn10,isbn13,url,alt_title,author_intro,summary,price,ebook_price,ebook_url,series%7Bid,title%7D%7D%7D';
    NetworkHelper.shared.requestDoubanList(url, _onBookCallback);
  }

  void requestHotBook() {
    isHot = true;
    String url = 'http://sas.qq.com/cgi-bin/db/data?t=%5B%22ke_coding_book%22%5D&q=%7Bke_coding_book(_page:$page,_limit:10)%7Bid,title,rating%7Bmax,numRaters,average,min%7D,subtitle,author,pubdate,tags%7Bcount,name,title%7D,origin_title,image,binding,translator,catalog,pages,images%7Bsmall,large,medium%7D,alt,publisher,isbn10,isbn13,url,alt_title,author_intro,summary,price,ebook_price,ebook_url,series%7Bid,title%7D%7D%7D';
    NetworkHelper.shared.requestDoubanList(url, _onBookCallback);
  }

  void _onBookCallback(int statusCode, dynamic resultMap) {
    if (statusCode == 200 && resultMap is Map) {
      for (dynamic result in resultMap['result']) {
        if (isHot) {
          Book book = Book.castFromMap(result);
          if (book.rank > 4) {
            bookList.add(book);
          }
        } else {
          bookList.add(Book.castFromMap(result));
        }
      }

      if (isHot && bookList.length == 0) {
        requestHotBook();
        return;
      }

      isHot = false;
      onDataCallback();
    }
  }


  //Muisic
  void requestRecentMusic() {
    isNew = true;
    String url = 'http://sas.qq.com/cgi-bin/db/data?t=%5B%22ke_coding_music%22%5D&q=%7Bke_coding_music(_page:$page,_limit:10)%7Bid,title,alt,rating%7Bmax,average,numRaters,min%7D,author%7Bname%7D,alt_title,image,tags%7Bcount,name%7D,mobile_link,attrs%7Bpublisher,singer,version,pubdate,title,media,tracks,discs%7D%7D%7D';
    NetworkHelper.shared.requestDoubanList(url, _onMusicCallback);
  }

  void _onMusicCallback(int statusCode, dynamic resultMap) {
    if (statusCode == 200 && resultMap is Map) {
      for (dynamic result in resultMap['result']) {
        if (isNew) {
          Music music = Music.castFromMap(result);
          List pubdateList = music.attr.pubdate;
          if (pubdateList.length > 0 && pubdateList[0].toString().startsWith('2012')) {
            musicList.add(music);
          }
        } else {
          musicList.add(Music.castFromMap(result));
        }
      }

      if (isNew && musicList.length == 0) {
        requestRecentMusic();
        return;
      }

      isNew = false;
      onDataCallback();
    }
  }

  void requestHotMusic() {
    isHot = true;
    String url = 'http://sas.qq.com/cgi-bin/db/data?t=%5B%22ke_coding_music%22%5D&q=%7Bke_coding_music(_page:$page,_limit:10)%7Bid,title,alt,rating%7Bmax,average,numRaters,min%7D,author%7Bname%7D,alt_title,image,tags%7Bcount,name%7D,mobile_link,attrs%7Bpublisher,singer,version,pubdate,title,media,tracks,discs%7D%7D%7D';
    NetworkHelper.shared.requestDoubanList(url, _onHotMusicCallback);
  }

  void _onHotMusicCallback(int statusCode, dynamic resultMap) {
    if (statusCode == 200 && resultMap is Map) {
      for (dynamic result in resultMap['result']) {
        if (isHot) {
          Music music = Music.castFromMap(result);
          if (music.rank > 4) {
            musicList.add(music);
          }
        } else {
          musicList.add(Music.castFromMap(result));
        }
      }

      if (isHot && musicList.length == 0) {
        requestHotMusic();
        return;
      }

      isHot = false;
      onDataCallback();
    }
  }

}