import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

// 该白名单中的页面 url，点击返回按钮会退出 webview
const CATCH_URLS = [
  'm.ctrip.com/',
  'm.ctrip.com/html5/',
  'm.ctrip.com/html5',
];

class WebView extends StatefulWidget {

  String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  WebView({
    this.url,
    this.statusBarColor,
    this.title,
    this.hideAppBar,
    this.backForbid = false,
  }) {
    if (url != null && url.contains('ctrip.com')) {
      //fix 携程H5 http://无法打开问题
      this.url = url.replaceAll("http://", 'https://');
    }
  }

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {

  bool exiting = false; // flag 避免重复返回

  final webviewReference = FlutterWebviewPlugin();

  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;

  @override
  void initState() {
    super.initState();

    webviewReference.close();
    // url 变化时
    _onUrlChanged = webviewReference.onUrlChanged.listen((String url) {

    });

    // 页面状态变化时
    _onStateChanged = webviewReference.onStateChanged.listen((WebViewStateChanged state) {
      switch (state.type) {
        case WebViewState.startLoad: // 开始加载
          // 是 ctrip main web 的 首页 url，点击返回会退出 webview
          if (_isToMain(state.url) && !exiting) {
            if (widget.backForbid) { // 不返回上级 web 页面，重新加载该 web 页面
              webviewReference.launch(widget.url);
            } else {
              // 返回上一页
              Navigator.pop(context);
              setState(() {
                exiting = true;
              });
            }
          }
          break;
        default:
      }
    });

    // 错误监听
    _onHttpError = webviewReference.onHttpError.listen((WebViewHttpError err) {
      print(err);
    });
  }

  @override
  void dispose() {
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    webviewReference.dispose();
    super.dispose();
  }

  // 是否为 ctrip web 的 首页 url
  bool _isToMain(String url) {
    bool contain = false;

    for (final v in CATCH_URLS) {
      if (url?.endsWith(v) ?? false) {
        contain = true;
      }
    }

    return contain;
  }

  Widget _appBar(Color bgColor, Color backBtnColor) {
    // 隐藏 app bar
    if (widget.hideAppBar ?? false) {
      return Container(
        color: bgColor,
        height: 30,
      );
    }

    return Container(
      color: bgColor,
      padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(Icons.close, color: backBtnColor, size: 26),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Positioned(
              left: 0, right: 0,
              child: Center(
                child: Text(widget.title ?? '', style: TextStyle(color: backBtnColor, fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor = statusBarColorStr == 'ffffff' ? Colors.black : Colors.white;
    Color bgColor = Color(int.parse('0xff' + statusBarColorStr)); // 转换为 16 进制颜色 int 值

    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(bgColor, backButtonColor),
          Expanded(
            child: WebviewScaffold(
              url: widget.url,
              withZoom: true, // 可缩放
              withLocalStorage: true, // 启用本地存储
              hidden: true, // 是否隐藏
              // 初始化界面
              initialChild: Container(
                color: Colors.white,
                child: Center(
                  child: Text('Waitting...'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}