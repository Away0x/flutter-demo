import 'package:flutter/material.dart';

import './part/left_category_nav.dart';
import './part/right_category_nav.dart';
import './part/goods_list.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('商品分类')),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategoryNav(),
                GoodsList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}