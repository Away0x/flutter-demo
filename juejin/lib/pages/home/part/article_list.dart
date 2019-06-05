import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:juejin/services/api.dart';

class ArticleList extends StatefulWidget {

  final Map category;

  ArticleList({Key key, this.category}) : super(key: key);

  @override
  _ArticleListState createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  List articleList;

  _buildArticleItem(articleData) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.only(top: 10, bottom: 10),
      color: Colors.white,
      child: FlatButton(
        padding: EdgeInsets.all(0),
        child: Column(
          children: <Widget>[
            Text(articleData['title']),
          ],
        ),
        onPressed: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getArticleList(category: widget.category['id']),
      builder: (context, snapshot) {
        // 加载中
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }

        // 加载完成
        if (snapshot.connectionState == ConnectionState.done) {
          List<dynamic> data = snapshot.data;

          // 没有数据
          if (!snapshot.hasData || snapshot.hasError || data == null || (data.length < 1)) {
            var msg = snapshot.error == null ? '暂无数据' : snapshot.error.toString();

            return Container(
              color: Color.fromRGBO(244, 245, 245, 1),
              child: Center(child: Text(msg))
            );
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              var item = data[index];
              return _buildArticleItem(item);
            },
          );
        }
      },
    );
  }
}