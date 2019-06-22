import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:ctrip/model/common_model.dart';

import 'package:ctrip/components/webview.dart';

class TopSwipper extends StatelessWidget {

  final List<CommonModel> bannerList;

  const TopSwipper(this.bannerList);

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemCount: bannerList.length,
      autoplay: true,
      itemBuilder: (context, index) {
        CommonModel model = bannerList[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => WebView(
                url: model.url,
                title: model.title,
                statusBarColor: model.statusBarColor,
                hideAppBar: model.hideAppBar,
              ),
            ));
          },
          child: Image.network(model.icon, fit: BoxFit.fill,),
        );
      },
      pagination: SwiperPagination(),
    );
  }
}