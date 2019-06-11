import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

const APPBAR_SCROLL_OFFSET = 100; // 页面滚动大于该值时，appbar opcity 为 1

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  double _appBarAlpha = 0;
  List _imageUrls = [
    'https://pages.ctrip.com/commerce/promote/20180718/yxzy/img/640sygd.jpg',
    'https://dimg04.c-ctrip.com/images/700u0r000000gxvb93E54_810_235_85.jpg',
    'https://dimg04.c-ctrip.com/images/700c10000000pdili7D8B_780_235_57.jpg',
  ];

  _onScroll(double offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }

    setState(() {
      _appBarAlpha = alpha;
    });
  }

  Widget _buildAppBar() {
    return Opacity(
      opacity: _appBarAlpha,
      child: Container(
        height: 80,
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text('首页'),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    // NotificationListener 监听滚动
    return NotificationListener(
      onNotification: (scrollNotification) {
        // scrollNotification.depth == 0 第 0 个 weiget 是 ListView
        if (scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0) {
          // 滚动且是列表滚动的时候
          _onScroll(scrollNotification.metrics.pixels);
        }
      },
      child: ListView(
        children: <Widget>[
          Container(
            height: 160,
            child: Swiper(
              itemCount: _imageUrls.length,
              autoplay: true,
              itemBuilder: (context, index) {
                return Image.network(_imageUrls[index], fit: BoxFit.fill,);
              },
              pagination: SwiperPagination(),
            ),
          ),
          Container(
            height: 800,
            child: ListTile(
              title: Text('哈哈'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // removePadding 去掉根元素的 top padding
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: _buildContent(),
          ),
          // 自定义 appbar
          _buildAppBar(),
        ],
      )
    );
  }
}