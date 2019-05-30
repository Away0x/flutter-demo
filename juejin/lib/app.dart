import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:juejin/pages/home/home.dart';
import 'package:juejin/pages/hot/hot.dart';
import 'package:juejin/pages/discovery/discovery.dart';
import 'package:juejin/pages/mine/mine.dart';

class AppIndex extends StatefulWidget {
  @override
  _AppIndexState createState() => _AppIndexState();
}

class _AppIndexState extends State<AppIndex> {
  final List<BottomNavigationBarItem> tabs = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text('首页'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.conversation_bubble),
      title: Text('沸点'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text('发现'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: Text('我'),
    ),
  ];

  int currentPageIndex = 0;
  List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = [
      HomePage(),
      HotPage(),
      DiscoveryPage(),
      MinePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1),
      bottomNavigationBar:  BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentPageIndex,
        items:  tabs,
        onTap: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
      body: pages[currentPageIndex],
    );
  }
}