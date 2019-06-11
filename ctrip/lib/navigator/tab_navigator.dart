import 'package:flutter/material.dart';

import 'package:ctrip/pages/home_page.dart';
import 'package:ctrip/pages/my_page.dart';
import 'package:ctrip/pages/search_page.dart';
import 'package:ctrip/pages/travel_page.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {

  // bottom bars
  final List<String> _barTitles = ['首页', '搜索', '旅拍', '我的'];
  final List<IconData> _barIcons = [Icons.home, Icons.search, Icons.camera_alt, Icons.account_circle];
  // page
  final PageController _controller = PageController(
    initialPage: 0,
  );
  int _currentPageIndex = 0;
  // other
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;

  BottomNavigationBarItem _buildBottomBar(int index) {
    return BottomNavigationBarItem(
      title: Text(_barTitles[index], style: TextStyle(
        color: _currentPageIndex != index ? _defaultColor : _activeColor,
      )),
      icon: Icon(_barIcons[index], color: _defaultColor),
      activeIcon: Icon(_barIcons[index], color: _activeColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPageIndex,
        items: _barTitles.asMap().keys.map((index) {
          return _buildBottomBar(index);
        }).toList(),
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentPageIndex = index;
          });
        },
      ),
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          SearchPage(),
          TravelPage(),
          MyPage(),
        ],
      ),
    );
  }
}