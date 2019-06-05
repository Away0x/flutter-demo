import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './part/my_swiper.dart';
import './part/nav_grid.dart';
import './part/ad_banner.dart';
import './part/leader_phone.dart';

import '../../services/api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String homePageContent = '正在获取数据';

  @override
  Widget build(BuildContext context) {
    // 初始化适配尺寸 (以 iphone6 为基准)
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    return Scaffold(
      appBar: AppBar(title: Text('百姓生活+')),
      body: FutureBuilder(
        future: getHomeData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            List<Map> swiperData = (data['slides'] as List).cast();
            List<Map> navData = (data['category'] as List).cast();
            String adImg = data['advertesPicture']['PICTURE_ADDRESS']; // 广告图片
            String leaderImg = data['shopInfo']['leaderImage'];
            String leaderPhone = data['shopInfo']['leaderPhone'];

            return Column(
              children: <Widget>[
                MySwiper(swiperData: swiperData), // 轮播图
                NavGrid(navList: navData),        // 导航
                AdBanner(abPicture: adImg),       // 广告 banner
                LeaderPhone(leaderImg: leaderImg, leaderPhone: leaderPhone), // 店长电话
              ],
            );
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('加载中... ${snapshot.error.toString()}'));
            }
            return Center(child: Text('加载中...'));
          }
        },
      ),
    );
  }

}
