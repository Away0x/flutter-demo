import 'dart:async';

import 'package:flutter/material.dart';

import 'package:ctrip/model/home_model.dart';
import 'package:ctrip/model/common_model.dart';
import 'package:ctrip/model/grid_nav_model.dart';
import 'package:ctrip/model/sales_box_model.dart';

import 'package:ctrip/dao/home_dao.dart';

import 'package:ctrip/components/loading_container.dart';
import 'package:ctrip/components/search_bar.dart';

import './part/top_swiper.dart';
import './part/grid_nav.dart';
import './part/local_nav.dart';
import './part/sub_nav.dart';
import './part/sales_box.dart';

const APPBAR_SCROLL_OFFSET = 100; // 页面滚动大于该值时，appbar opcity 为 1
const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 美食';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  double _appBarAlpha = 0;
  bool _loading = true;

  List<CommonModel> bannerList = [];
  List<CommonModel> localNavList = [];
  GridNavModel gridNavModel;
  List<CommonModel> subNavList = [];
  SalesBoxModel salesBoxModel;

  @override
  void initState() {
    super.initState();
    print("home page load");
    loadData();
  }

  _onScroll(Notification scrollNotification) {
    // 滚动且是列表滚动的时候 (scrollNotification.depth == 0 第 0 个 weiget 是 ListView)
    if (scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0) {
      double offset = scrollNotification.metrics.pixels;
      double alpha = offset / APPBAR_SCROLL_OFFSET;

      if (alpha < 0) {
        alpha = 0;
      } else if (alpha > 1) {
        alpha = 1;
      }

      setState(() => _appBarAlpha = alpha);
    }
  }

  Future<Null> loadData() async {
    setState(() => _loading = true);

    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        bannerList = model.bannerList;
        localNavList = model.localNavList;
        gridNavModel = model.gridNav;
        subNavList = model.subNavList;
        salesBoxModel = model.salesBox;

        _loading = false;
      });
    } catch (e) {
      print(e);
      setState(() => _loading = false);
    }

    return null;
  }

  Widget get _appBar {
    var searchBar = SearchBar(
      searchBarType: _appBarAlpha > 0.2 ? SearchBarType.homeLight : SearchBarType.home,
      defaultText: SEARCH_BAR_DEFAULT_TEXT,
      inputBoxClick: _jumpToSearch,
      speakClick: _jumpToSpeak,
      leftButtonClick: () {},
    );

    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              // appbar 渐变遮罩背景
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 80,
            decoration: BoxDecoration(
              color: Color.fromARGB((_appBarAlpha * 255).toInt(), 255, 255, 255),
            ),
            child: searchBar,
          ),
        ),
        // 阴影
        Container(
          height: _appBarAlpha > 0.2 ? 1 : 0,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 1)],
          ),
        ),
      ],
    );
  }

  Widget get _content {
    const EdgeInsets padding = EdgeInsets.fromLTRB(7, 4, 7, 4);

    // NotificationListener 监听滚动
    return NotificationListener(
      onNotification: (Notification scrollNotification) => _onScroll(scrollNotification),
      child: ListView(
        children: <Widget>[
          Container(height: 160, child: TopSwipper(bannerList)),
          Padding(padding: padding, child: LocalNav(localNavList: localNavList)),
          Padding(padding: padding, child: GridNav(gridNavModel: gridNavModel)),
          Padding(padding: padding, child: SubNav(subNavList: subNavList)),
          Padding(padding: padding, child: SalesBox(salesBox: salesBoxModel)),
        ],
      ),
    );
  }

  _jumpToSearch() {
    
  }

  _jumpToSpeak() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: LoadingContainer(
        isLoading: _loading,
        child:  Stack(
          children: <Widget>[
            // removePadding 去掉根元素的 top padding (否则默认顶部会有一点 padding(status bar))
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              // 下拉刷新
              child: RefreshIndicator(
                onRefresh: () async {
                  setState(() => _loading = true);
                  return Timer(Duration(seconds: 1), () => loadData()); // 保证 loading 至少显示 1s
                },
                child: NotificationListener(
                  onNotification: (Notification scrollNotification) => _onScroll(scrollNotification),
                  child: _content,
                )
              ),
            ),
            // 自定义 appbar
            _appBar,
          ],
        ),
      ),
    );
  }
}