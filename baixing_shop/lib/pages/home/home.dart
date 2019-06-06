import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import './part/my_swiper.dart';
import './part/nav_grid.dart';
import './part/ad_banner.dart';
import './part/leader_phone.dart';
import './part/recommend.dart';
import './part/floor.dart';
import './part/hot_goods.dart';

import '../../services/api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();
  String homePageContent = '正在获取数据';

  // 热卖商品
  int page = 1;
  List<Map> hotGoodsList = [];

  @override
  void initState() {
    print('home page load');
    _getHotGoods();
    super.initState();
  }

  // 获取热卖商品
  void _getHotGoods() async {
    var resource = await getHotGoodsData(page: page);
    List<Map> data = (resource as List).cast();

    setState(() {
      hotGoodsList.addAll(data);
      page++;
    });
  }

  Widget _buildRefresh({List<Widget> children}) {
    return EasyRefresh(
      refreshFooter: ClassicsFooter(
        key: _footerKey,
        bgColor: Colors.white,
        textColor: Colors.pink,
        moreInfoColor: Colors.pink,
        showMore: true,
        noMoreText: '',
        moreInfo: '加载中',
        loadReadyText: '上拉加载...',
      ),
      child: ListView(
        children: children,
      ),
      loadMore: () async {
        _getHotGoods();
      },
    );
  }

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
            List<Map> recommendList = (data['recommend'] as List).cast();

            // 楼层数据
            String floor1Title = data['floor1Pic']['PICTURE_ADDRESS'];
            String floor2Title = data['floor2Pic']['PICTURE_ADDRESS'];
            String floor3Title = data['floor3Pic']['PICTURE_ADDRESS'];
            List<Map> floor1 = (data['floor1'] as List).cast();
            List<Map> floor2 = (data['floor2'] as List).cast();
            List<Map> floor3 = (data['floor3'] as List).cast();

            return _buildRefresh(
              children: <Widget>[
                MySwiper(swiperData: swiperData), // 轮播图
                NavGrid(navList: navData),        // 导航
                AdBanner(abPicture: adImg),       // 广告 banner
                LeaderPhone(leaderImg: leaderImg, leaderPhone: leaderPhone), // 店长电话
                Recommend(recommendList: recommendList), // 推荐商品
                // 楼层数据
                FloorTitle(pictureAddr: floor1Title),
                FloorContent(floorGoodsList: floor1),
                FloorTitle(pictureAddr: floor2Title),
                FloorContent(floorGoodsList: floor2),
                FloorTitle(pictureAddr: floor3Title),
                FloorContent(floorGoodsList: floor3),
                // 热卖商品
                HotGoods(hotGoodsList: hotGoodsList),
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
