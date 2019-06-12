import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:baixing_shop/provide/tab_index.dart';

import 'package:baixing_shop/pages/home/home.dart';
import 'package:baixing_shop/pages/category/category.dart';
import 'package:baixing_shop/pages/cart/cart.dart';
import 'package:baixing_shop/pages/member/member.dart';

class IndexPage extends StatelessWidget {

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

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TabIndexProvide>(context);
    var currentIndex = provider.currentTabIndex;

    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index) {
          provider.changeTabIndex(index);
        },
      ),
      body: IndexedStack(
        index: currentIndex,
        children: tabBodies,
      ),
    );
  }
}
