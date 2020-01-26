import 'package:flutter/material.dart';

class RankContainer extends StatelessWidget {

  final String title;
  final int rank;
  final double score;

  final Color backgroundColor;
  final double titleSize;
  final double width;
  final double heigth;
  final double starWidth;

  RankContainer({
    Key key,
    @required this.rank,
    @required this.score,
    this.title,
    this.backgroundColor,
    this.titleSize = 16,
    this.width = 90,
    this.heigth = 40,
    this.starWidth = 10
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.heigth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: this.width,            
            child: Text(
              this.title == null ? '默认' : this.title,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: titleSize, color: backgroundColor == null ? Color(0xDE000000) : backgroundColor),
            ),
          ),
          Container(
            width: this.width > 90 ? 90 : this.width,
            height: 14,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {                      
                      if (index < rank) {
                        return Image(
                          width: starWidth,
                          height: starWidth,
                          image: AssetImage('lib/images/star_blue.png'),
                        );
                      } else {
                        return Image(
                          width: starWidth,
                          height: starWidth,
                          image: AssetImage('lib/images/star_grey.png'),
                        );
                      }
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Container(width: 2);
                    }
                  ),
                ),
                Text(
                  '$score',
                  style: TextStyle(fontSize: 10, color: backgroundColor == null ? Color(0xFF999999) : backgroundColor),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}