import 'package:flutter/material.dart';

///加载进度条组件
class LoadingContainer extends StatelessWidget {

  final Widget child;
  final bool isLoading; // 是否显示 loading
  final bool cover;     // loading 是否覆盖在内容上

  const LoadingContainer({
    Key key,
    this.cover = false,
    @required this.isLoading,
    @required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !cover
      ? !isLoading ? child : _loadingView
      : Stack(
          children: <Widget>[child, isLoading ? _loadingView : Container()],
        );
  }

  Widget get _loadingView {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
