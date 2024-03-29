import 'package:flutter/material.dart';

import 'package:ctrip/model/common_model.dart';
import 'package:ctrip/components/webview.dart';

class LocalNav extends StatelessWidget {

  final List<CommonModel> localNavList;

  const LocalNav({Key key, @required this.localNavList}) : super(key: key);

  Widget _item(BuildContext context, CommonModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => WebView(
            url: model.url,
            statusBarColor: model.statusBarColor,
            hideAppBar: model.hideAppBar,
          ),
        ));
      },
      child: Column(
        children: <Widget>[
          Image.network(model.icon, width: 32, height: 32),
          Text(model.title, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _items(BuildContext context) {
    if (localNavList == null) return null;

    List<Widget> items = [];

    localNavList.forEach((m) {
      items.add(_item(context, m));
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // 均匀排列
      children: items,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }
}