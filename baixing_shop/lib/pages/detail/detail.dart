import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:baixing_shop/provide/detail.dart';

class DetailPage extends StatelessWidget {

  final String goodsId;

  DetailPage(this.goodsId);

  Future<String> _getDetail(BuildContext context) async {
    await Provider.of<DetailProvide>(context).fetchGoodDetail(goodsId);
    return '完成加载';
  }

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
        future: _getDetail(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: Column(
                children: <Widget>[

                ],
              ),
            );
          } else {
            return Text('加载中 $goodsId');
          }
        },
      ),
    );
  }
}