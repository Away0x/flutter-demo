import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../home/home.dart';
import '../category/category.dart';
import '../cart/cart.dart';
import '../member/member.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
   
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text('首页')),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), title: Text('分类')),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.shopping_cart), title: Text('购物车')),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled), title: Text('会员中心')),
  ];

  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage(),
  ];

  int currentIndex = 0;
  var currentPage;
  PageController _pageController;

  @override
  void initState() {
    currentPage = tabBodies[currentIndex];
    _pageController = PageController();
      // ..addListener(() {
      //   if (currentPage != _pageController.page.round()) {
      //     setState(() {
      //       currentPage = _pageController.page.round();
      //     });
      //   }
      // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            // currentPage = tabBodies[currentIndex];
          });
        },
      ),
      body: IndexedStack(
        index: currentIndex,
        children: tabBodies,
      ),
    );
  }
}
