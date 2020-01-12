import 'package:flutter/material.dart';

import 'package:douban_movie/model/douban.dart';
import 'package:douban_movie/base/root_page.dart';

class CategoryPage extends StatefulWidget {

  final DoubanCategory category;

  CategoryPage({
    Key key,
    this.category,
  });

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
  with SingleTickerProviderStateMixin {

  TabController _tabController;
  List<String> _tabTitleList;

  @override
  void initState() {
    super.initState();

    _tabTitleList = DoubanModel.getMoreTitle(widget.category);
    _tabController = TabController(
      vsync: this, 
      length: _tabTitleList.length
    );
  }

  @override
  Widget build(BuildContext context) {
    return RootPage(
      title: DoubanModel.getDoubanTitle(widget.category),
      tabbar: _buildTabbar(),
      body: TabBarView(
        controller: _tabController,
        children: _buildTabBarViews(),
      ),
    );
  }

  Widget _buildTabbar() {
    return TabBar(
      controller: _tabController,
      unselectedLabelColor: Colors.white,
      indicatorColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.label, // 和字体长度一样长
      labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      labelPadding: EdgeInsets.only(bottom: 8),
      unselectedLabelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
      tabs: _buildTabs(),
    );
  }

  List<Widget> _buildTabs() {
    return _tabTitleList.map((s) {
      return Text(s);
    }).toList();
  }

  List<Widget> _buildTabBarViews() {
    return _tabTitleList.map((s) {
      return Text(s);
    }).toList();
  }

}