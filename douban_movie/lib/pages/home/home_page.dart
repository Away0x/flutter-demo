import 'package:flutter/material.dart';

import 'package:douban_movie/components/search_bar/search_bar.dart';
import 'package:douban_movie/base/root_page.dart';
import 'package:douban_movie/model/douban.dart';
import 'package:douban_movie/pages/category/category_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return RootPage(
      body: Stack(
        children: <Widget>[
          Container(),
          _buildTopWidget(),
          _buildBottomWidget(),
        ],
      ),
    );
  }

  Widget _buildTopWidget() {
    return Container(
      height: 170,
      color: Color(0xFF33C9FF),
      child: SafeArea(
        child: Container(
          height: 52,
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: 20, right: 20, left: 15),
          child: _buildSearchBar(),
        ),
      ),
    );
  }

  Widget _buildBottomWidget() {
    return Positioned(
      top: 150,
      child: Container(
        width: 300,
        height: 500,
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _onSearchBarTapped,
          child: SearchBar(
            isEnable: false,
          ),
        ),
        Image(
          width: 16,
          height: 16,
          image: AssetImage('lib/images/scan.png'),
        ),
      ],
    );
  }

  void _onSearchBarTapped() {
    // Navigator.pushNamed(context, '/search');
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return CategoryPage(category: DoubanCategory.Movie);
      },
    ));
  }

}