import 'package:flutter/material.dart';

enum SearchBarType{
  home, // 首页 search bar
  homeLight, // 首页 search bar (高亮状态)
  noraml,
}

class SearchBar extends StatefulWidget {

  final bool enabled; // 是否禁止搜索
  final bool hideLeft; // 是否隐藏左边按钮
  final SearchBarType searchBarType; // search bar 样式
  final String hint; // 提示文案
  final String defaultText;
  final void Function() leftButtonClick;
  final void Function() rightButtonClick;
  final void Function() speakClick;
  final void Function() inputBoxClick;
  final ValueChanged<String> onChanged;

  const SearchBar({
    Key key,
    this.searchBarType = SearchBarType.noraml,
    this.enabled = true,
    this.hideLeft,
    this.hint,
    this.defaultText,
    this.leftButtonClick,
    this.rightButtonClick,
    this.speakClick,
    this.inputBoxClick,
    this.onChanged,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  bool showClearBtn = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // 设置默认文字
    if (widget.defaultText != null) {
      setState(() {
        _controller.text = widget.defaultText;
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchBarType == SearchBarType.noraml
      ? _genNormalSearch()
      : _genHomeSearch();
  }

  Widget _genNormalSearch() {
    return Container(
      child: Row(
        children: <Widget>[
          _wrapTap(
            Container(
              padding: EdgeInsets.fromLTRB(6, 5, 10, 5),
              child: (widget?.hideLeft ?? false)
                ? null 
                : Icon(Icons.arrow_back_ios, color: Colors.grey, size: 26),
            ),
            widget.leftButtonClick,
          ),
          Expanded(
            flex: 1,
            child: _inputBox(),
          ),
          _wrapTap(
            Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Text('搜索', style:TextStyle(color: Colors.blue, fontSize: 17)),
            ),
            widget.rightButtonClick,
          ),
        ],
      ),
    );
  }

  Widget _genHomeSearch() {
    return Container(
      child: Row(
        children: <Widget>[
          _wrapTap(
            Container(
              padding: EdgeInsets.fromLTRB(6, 5, 5, 5),
              child: Row(
                children: <Widget>[
                  Text(
                    '上海',
                    style: TextStyle(color: _homeFontColor(), fontSize: 14),
                  ),
                  Icon(Icons.expand_more, color: _homeFontColor(), size: 22),
                ],
              ),
            ), widget.leftButtonClick
          ),
          Expanded(
            flex: 1,
            child: _inputBox(),
          ),
          _wrapTap(
            Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Icon(Icons.comment, color: _homeFontColor(), size: 26),
            ),
            widget.rightButtonClick,
          ),
        ],
      ),
    );
  }

  Widget _wrapTap(Widget child, void Function() callback) {
    return GestureDetector(
      child: child,
      onTap: () {
        if (callback != null) callback();
      },
    );
  }

  Widget _inputBox() {
    Color inputBoxColor;
    if (widget.searchBarType == SearchBarType.home) {
      inputBoxColor = Colors.white;
    } else {
      inputBoxColor = Color(int.parse('0xffededed'));
    }

    return Container(
      height: 30,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: inputBoxColor,
        borderRadius: BorderRadius.circular(widget.searchBarType == SearchBarType.noraml ? 5 : 15),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.search, size: 20,
            color: (widget.searchBarType == SearchBarType.noraml) ? Color(0xffa9a9a9) : Colors.blue),
          Expanded(
            flex: 1,
            child: widget.searchBarType == SearchBarType.noraml
              ? TextField(controller: _controller, onChanged: _onChanged, autofocus: true,
                  style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w300),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    border: InputBorder.none,
                    hintText: widget.hint ?? '',
                    hintStyle: TextStyle(fontSize: 15),
                  ))
              : _wrapTap(
                Container(
                  child: Text(
                    widget.defaultText,
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ),
                widget.inputBoxClick,
              ),
          ),
          _tailBtn(),
        ],
      ),
    );
  }

  _onChanged(String text) {
    setState(() {
      showClearBtn = text.length > 0;
    });

    if (widget.onChanged != null) {
      widget.onChanged(text);
    }
  }

  Widget _tailBtn() {
    if (!showClearBtn) {
      return _wrapTap(
        Icon(Icons.mic, size: 22, color: widget.searchBarType == SearchBarType.noraml ? Colors.blue : Colors.grey),
        widget.speakClick
      );
    }
    
    return _wrapTap(
      Icon(Icons.clear, size: 22, color: Colors.grey),
      () {
        setState(() {
          _controller.clear();
        });
        _onChanged('');
      }
    );
  }

  Color _homeFontColor() {
    return widget.searchBarType == SearchBarType.homeLight
      ? Colors.black54
      : Colors.white;
  }
}