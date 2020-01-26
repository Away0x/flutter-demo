import 'package:douban_movie/components/rank_container/rank_container.dart';
import 'package:douban_movie/model/book.dart';
import 'package:douban_movie/model/douban.dart';
import 'package:douban_movie/model/movie.dart';
import 'package:douban_movie/model/music.dart';
import 'package:douban_movie/pages/detail/movie_detail_page.dart';
import 'package:douban_movie/utils/app_utils.dart';
import 'package:flutter/material.dart';

class CategoryDetailItem extends StatelessWidget {

  final BuildContext context;
  final DoubanCategory category;
  final Movie movie;
  final Book book;
  final Music music;

  CategoryDetailItem({
    this.context,
    this.category,
    this.movie,
    this.book,
    this.music
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onItemTapped,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.only(left: 24, right: 24, top: 9),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FadeInImage.assetNetwork(
              width: 86,
              height: 112,
              fit: BoxFit.fill,
              placeholder: 'lib/images/scan.png',
              image: _getImageUrl(),
            ),
            Container(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RankContainer(
                  title: _getDetailTitle(),
                  score: _getDetailScore(),
                  width: 220,
                  heigth: 40,
                  rank: _getDetailRank(),
                ),
                Container(height: 3),
                Container(
                  width: 220,
                  child: Text(
                    _getBrief(),
                    style: TextStyle(fontSize: 10, color: Color(0xFF999999)),
                    maxLines: 5,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped() {
//    Navigator.push(context, MaterialPageRoute(builder: (context) {
//      if (category == DoubanCategory.Movie) {
//        return MovieDetailPage(movie: movie);
//      } else if (category == DoubanCategory.Book) {
//        return BookDetailPage(book: book,);
//      } else {
//        return MusicDetailPage(music: music,);
//      }
//    }));
  }

  String _getImageUrl() {
    if (category == DoubanCategory.Movie) {
      return movie.image;
    } else if (category == DoubanCategory.Book) {
      return book.image;
    } else {
      return music.image;
    }
  }

  String _getDetailTitle() {
    if (category == DoubanCategory.Movie) {
      return movie.title;
    } else if (category == DoubanCategory.Book) {
      return book.title;
    } else {
      return music.title;
    }
  }

  double _getDetailScore() {
    if (category == DoubanCategory.Movie) {
      return movie.rating;
    } else if (category == DoubanCategory.Book) {
      return book.rating;
    } else {
      return music.rating;
    }
  }

  int _getDetailRank() {
    if (category == DoubanCategory.Movie) {
      return movie.rank;
    } else if (category == DoubanCategory.Book) {
      return book.rank;
    } else {
      return music.rank;
    }
  }

  String _getBrief() {
    if (category == DoubanCategory.Movie) {
      //'2019/中国大陆/剧情 喜剧/90分钟 / 王大陆 / 魏大勋 / 曾梦雪 / 贾冰 / 岳旸 / 李歌 / 田羽生/伟大的愿望       019/中国大陆/剧情 喜剧/90分钟 / 王大陆 / 魏大勋 / 曾梦雪 / 贾冰 / 岳旸 / 李歌 / 田羽生/伟大的愿望   ',
      return '${movie.year}/ ${AppUtil.getTextString(movie.genres)}/ ${movie.durations}${AppUtil.getTextStringFromCasts(movie.casts)}';
    } else if (category == DoubanCategory.Book) {
      //[德] 罗德里希·普塔克 / Roderich Ptak /出版社: 后浪丨中国友谊出版公司
      String translator = AppUtil.getTextString(book.translator);
      return '${AppUtil.getTextString(book.author)} / ${book.pubdate} / 出版社: ${book.publisher} ${translator == '' ? '' : '/ 翻译: ' '${translator}'}';
    } else {
      return '${AppUtil.getTextString(music.tags)}';
    }
  }

}
