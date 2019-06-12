import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:baixing_shop/services/api.dart';
import 'package:baixing_shop/model/detail.dart';

import './constants.dart';

import './part/top_area.dart';
import './part/explain.dart';
import './part/tabbar.dart';
import './part/content.dart';
import './part/bottom.dart';

class DetailPage extends StatefulWidget {
  
  final String goodsId;
  
  DetailPage(this.goodsId);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TabIndex currentTabIndex = TabIndex.LEFT;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('商品详情'),
      ),
      body: FutureBuilder(
        future: getGoodDetail(widget.goodsId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = DetailsGoodsData.fromJson(snapshot.data);

            return Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    DetailTopArea(data),
                    SizedBox(height: 10),
                    DetailExplain(),
                    SizedBox(height: 10),
                    DetailTabbar(
                      currentIndex: currentTabIndex,
                      clickTabCallBack: (index) {
                        setState(() {
                          currentTabIndex = index;
                        });
                      },
                    ),
                    DetailContent(currentTabIndex: currentTabIndex, content: data.goodInfo?.goodsDetail),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: DetailBottom(data.goodInfo),
                ),
              ],
            );
          } else {
            // return Text('加载中 ${widget.goodsId}');
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
        },
      ),
    );
  }
}
