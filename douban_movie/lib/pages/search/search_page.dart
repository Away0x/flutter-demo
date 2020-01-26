import 'package:douban_movie/base/root_page.dart';
import 'package:douban_movie/components/search_bar/search_bar.dart';
import 'package:douban_movie/pages/search/search_word.dart';
import 'package:douban_movie/services/search/search.dart';
import 'package:douban_movie/utils/app_utils.dart';
import 'package:douban_movie/utils/screen.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  List<String> recentWords = List();
  SearchService _searchService;

  @override
  void initState() {
    super.initState();

    _searchService = SearchService();
    _searchService.readRecentSearch().then((onValue) {
      if (onValue == '') {
        return;
      }
      recentWords = AppUtil.spiltWord(onValue);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return RootPage(
      body: ListView( // 使用 listview 实现具体高度由内容撑开
        physics: const NeverScrollableScrollPhysics(), // 禁止用户上下滑动
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            color: Color(0XFF333C9FF),
            child: Column(
              children: <Widget>[
                _buildTopWidget(),
                _buildRecentSeachContainer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopWidget() {
    final safeTopPadding = ScreenUtils.safeTopPadding;

    return Container(
      height: safeTopPadding + 52,
      padding: EdgeInsets.only(top: safeTopPadding + 20, right: 20, left: 15),
      child: _buildSearchBar(),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SearchBar(
          isEnable: true,
          onSubmit: _onSubmitted,
        ),
        GestureDetector(
          onTap: _onCancelTapped,
          child: Text(
            '取消',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white
            ),
          ),

        ),
      ],
    );
  }

  Widget _buildRecentSeachContainer() {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 12, 12, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                '最近搜索',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white
                ),
              ),
              GestureDetector(
                onTap: _onClearTapped,
                child: Text(
                    '清除',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white
                    )
                ),
              )
            ],
          ),
           _buildSearchWordList(),
        ],
      ),
    );
  }

  Widget _buildSearchWordList() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Wrap(
        direction: Axis.horizontal, // 排列方向，默认水平方向排列
        alignment: WrapAlignment.start, // 子控件在主轴上的对齐方式
        spacing: 10.0, // 主轴上子控件中间的间距
        runAlignment: WrapAlignment.start, // 子控件在交叉轴上的对齐方式
        runSpacing: 10.0, // 交叉轴上子控件之间的间距
        crossAxisAlignment: WrapCrossAlignment.start, // 交叉轴上子控件的对齐方式
        textDirection: TextDirection.ltr, // 水平方向上子控件的起始位置
        verticalDirection: VerticalDirection.down, // 垂直方向上子控件的起始位置
        children: recentWords.map((i) {
          return SearchWord(word: '$i');
        }).toList(),
      ),
    );
  }

  void _onSubmitted(String value) {
    _searchService.saveInput(AppUtil.componentWords(value, recentWords));
  }

  void _onCancelTapped() {
    Navigator.pop(context);
  }

  void _onClearTapped() {

  }

}