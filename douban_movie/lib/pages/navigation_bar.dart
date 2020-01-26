import 'package:flutter/material.dart';

import 'package:douban_movie/pages/home/home_page.dart';
import 'package:douban_movie/pages/person/person_page.dart';
import 'package:douban_movie/utils/screen.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  
  PageController _pageController = PageController();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index, 
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _initApp(BuildContext context) {
    ScreenUtils.screenWidth = MediaQuery.of(context).size.width;
    ScreenUtils.screenHeight = MediaQuery.of(context).size.height;
    ScreenUtils.safeTopPadding = MediaQuery.of(context).padding.top.toDouble(); // 刘海屏适配
  }

  @override
  Widget build(BuildContext context) {
    _initApp(context);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('我的')),
        ],
        onTap: _onItemTapped,
      ),
      body: PageView(
        children: <Widget>[
          HomePage(),
          PersonPage(),
        ],
        controller: _pageController,
        onPageChanged: _onPageChanged,
      ),
    );
  }
}