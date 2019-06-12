import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:baixing_shop/provide/cart.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => CartProvider()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('购物车'),
        ),
        body: Center(
          child: Text('购物车'),
        ),
      ),
    );
  }
}