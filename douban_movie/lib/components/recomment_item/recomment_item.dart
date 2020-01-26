import 'package:flutter/material.dart';

import 'package:douban_movie/model/douban.dart';
import 'package:douban_movie/pages/category/category_page.dart';
import 'package:douban_movie/components/display_item/display_item.dart';

class RecommentItem extends StatelessWidget {

  final BuildContext context;
  final DoubanCategory category;

  RecommentItem({
    Key key,
    @required this.context,
    this.category = DoubanCategory.Book,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      padding: EdgeInsets.only(left: 15),
      child: Column(
        children: <Widget>[
          _buildTitle(),
          Container(height: 10),
          DisplayItem(),
        ],
      ),
    );
  }

  void _onMoreTapped() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return CategoryPage(category: category);
      },
    ));
  }

  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          DoubanModel.getDoubanTitle(category),
          style: TextStyle(
            fontSize: 26,
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: _onMoreTapped,
          child: Padding(
            padding: EdgeInsets.only(right: 10),
            child: Text(
              '更多',
              style: TextStyle(fontSize: 14, color: Colors.green),
            ),
          ),
        ),
      ],
    );
  }
}