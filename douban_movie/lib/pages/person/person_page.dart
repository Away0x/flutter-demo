import 'package:douban_movie/base/root_page.dart';
import 'package:flutter/material.dart';

class PersonPage extends StatefulWidget {
  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return RootPage(
      title: '喜欢',
      hasLeading: false,
      tabbar: _buildTabbar(),
      body: TabBarView(
        controller: _tabController,
        children: _buildTabBarViews(),
      ),
    );
  }

  TabBar _buildTabbar() {
    return TabBar(
      controller: _tabController,
      onTap: _onTabBarTapped,
      unselectedLabelColor: Colors.white,
      indicatorColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
      labelPadding: EdgeInsets.only(bottom: 8),
      tabs: <Widget>[
        Text('影视',),
        Text('图书',),
        Text('音乐',),
      ],
    );
  }

  void _onTabBarTapped(int index) {

  }

  List<Widget> _buildTabBarViews() {
    return [1, 2, 3].map((i) {
      return _buildList();
    }).toList();
  }

  Widget _buildList() {
    return Container();
  }

}