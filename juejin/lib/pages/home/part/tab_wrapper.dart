import 'package:flutter/material.dart';

import './article_list.dart';

class TabWrapper extends StatefulWidget {

  final List list;

  TabWrapper({Key key, this.list}) : super(key: key);

  @override
  _TabWrapperState createState() => _TabWrapperState();
}

class _TabWrapperState extends State<TabWrapper> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.list.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(244, 245, 245, 1),
          automaticallyImplyLeading: true,
          titleSpacing: 0,
          title: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            tabs: widget.list.map((t) {
              return Tab(text: t['name']);
            }).toList(),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add, color: Colors.blue),
              onPressed: () {
                Navigator.pushNamed(context, '/share_article');
              },
            ),
          ],
        ),
        body: TabBarView(
          children: widget.list.map((t) {
            return ArticleList(category: t);
          }).toList(),
        ),
      ),
    );
  }
}
