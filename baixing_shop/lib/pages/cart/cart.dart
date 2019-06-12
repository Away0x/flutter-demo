import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:baixing_shop/model/cart_info.dart';
import 'package:baixing_shop/provide/cart.dart';
import 'package:baixing_shop/provide/tab_index.dart';

import './part/item.dart';
import './part/bottom.dart';

class CartPage extends StatelessWidget {

  Widget _buildListView(List<CartInfoMode> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return CartItem(list[index]);
      },
    );
  }
 
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: FutureBuilder(
        future: provider.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == null || (snapshot.data as List).length == 0) {
              return Center(
                child: RaisedButton(
                  child: Text('购物车空空如也，前往添加'),
                  onPressed: () {
                    Provider.of<TabIndexProvide>(context).gotoCategoryPage(context, false);
                  },
                ),
              );
            }

            return Stack(
              children: <Widget>[
                _buildListView(snapshot.data),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: CartBottom(snapshot.data),
                ),
              ],
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text('加载中... ${snapshot.error.toString()}'));
          }
          return Center(child: Text('加载中...'));
        },
      ),
    );
  }
}