import 'package:flutter/material.dart';

import 'package:douban_movie/utils/screen.dart';
import 'package:douban_movie/model/douban.dart';
import 'package:douban_movie/components/rank_container/rank_container.dart';

class DisplayItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: _buildItem,
        separatorBuilder: (context, index) {
          return Container(
            width: (ScreenUtils.screenWidth - 4 * 80 - 10 - 15) / 3,
          );
        },
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: <Widget>[
          FadeInImage.assetNetwork(
            width: 80,
            height: 112,
            fit: BoxFit.fill,
            placeholder: 'lib/images/scan.png',
            image: 'https://xpt.ischool365.com:8043/group1/M00/21/2C/CgoKc14YaHmAVQTPAANNtCsc4YU428.png',
          ),
          Container(height: 10),
          RankContainer(
            width: 80,
            heigth: 36,
            rank: 4,
            score: 7.6,
          ),
        ],
      ),
    );
  }


  // String _getImageUrl(int index) {
  //   if (items.length <= index) return '';

  //   if (category == DoubanCategory.Movie && items[index] is Movie) {
  //     Movie movie = items[index];
  //     return movie.image;
  //   } else if (category == DoubanCategory.Book && items[index] is Book) {
  //     Book book = items[index];
  //     return book.image;
  //   } else {
  //     Music music = items[index];
  //     return music.image;
  //   }
  // }

  // String _getItemTitle(int index) {
  //   if (items.length <= index) return '';

  //   if (category == DoubanCategory.Movie && items[index] is Movie) {
  //     Movie movie = items[index];
  //     return movie.title;
  //   } else if (category == DoubanCategory.Book && items[index] is Book) {
  //     Book book = items[index];
  //     return book.title;
  //   } else {
  //     Music music = items[index];
  //     return music.title;
  //   }
  // }  

  // double _getItemScore(int index) {
  //   if (items.length <= index) return 0.0;

  //   if (category == DoubanCategory.Movie && items[index] is Movie) {
  //     Movie movie = items[index];
  //     return movie.rating;
  //   } else if (category == DoubanCategory.Book && items[index] is Book) {
  //     Book book = items[index];
  //     return book.rating;
  //   } else {
  //     Music music = items[index];
  //     return music.rating;
  //   }
  // }    

  // int _getItemRank(int index) {
  //   if (items.length <= index) return 0;

  //   if (category == DoubanCategory.Movie && items[index] is Movie) {
  //     Movie movie = items[index];
  //     return movie.rank;
  //   } else if (category == DoubanCategory.Book && items[index] is Book) {
  //     Book book = items[index];
  //     return book.rank;
  //   } else {
  //     Music music = items[index];
  //     return music.rank;
  //   }
  // }  
}