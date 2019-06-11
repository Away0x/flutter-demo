/// 轮播图
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:baixing_shop/router/router.dart';
import 'package:baixing_shop/application.dart';

class MySwiper extends StatelessWidget {

  final List swiperData;

  MySwiper({Key key, this.swiperData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.getInstance().setHeight(333),
      width: ScreenUtil.getInstance().setWidth(750),
      child: Swiper(
        pagination: SwiperPagination(),
        autoplay: true,
        itemCount: swiperData.length,
        itemBuilder: (context, index) {
          var item = swiperData[index];

          return InkWell(
            child: Image.network("${swiperData[index]['image']}", fit: BoxFit.fill),
            onTap: () {
              Application.router.navigateTo(context, '${MyRouter.detailPage}?id=${item['goodsId']}');
            },
          );
        },
      ),
    );
  }
}