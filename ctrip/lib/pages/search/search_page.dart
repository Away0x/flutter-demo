import 'package:flutter/material.dart';

import 'package:ctrip/components/search_bar.dart';

import 'package:ctrip/dao/search_dao.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  @override
  void initState() {
    print("search page load");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SearchBar(
            hideLeft: true,
            defaultText: "haha",
            hint: "!23",
            leftButtonClick: () {
              Navigator.pop(context);
            },
            onChanged: _onTextChanged,
          ),
          InkWell(
            onTap: () {
              _loadData();
            },
            child: Text('get'),
          ),
        ],
      ),
    );
  }

  _onTextChanged(String text) {
    print(text);
  }

  _loadData() {
    SearchDao.fetch('长城').then((data) {
    });
  }
}