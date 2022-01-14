> 学习 [Best-Flutter-UI-Templates](https://github.com/mitesh77/Best-Flutter-UI-Templates)

- MaterialApp
- SafeArea
- Scaffold
- Container
- SizedBox
- Row
- Column
- Center
- Padding
- Expanded
- Stack
- IgnorePointer
- InkWell
- Divider
- AspectRatio
- PhysicalShape
- Material: 可以用来设置阴影
```dart
Material(
    elevation: 5,
    shadowColor: Colors.grey[100],
    child: Container(),
)
```

- ClipRRect: 将 child 剪裁为圆角矩形
- ClipRect: 将 child 剪裁为给定的矩形大小
- AnimatedBuilder
- Transform
- ScaleTransition
- Text
- ListTile
- Icon
- AnimatedIcon
- FutureBuilder
- SlideTransition: 平移动画
- MediaQuery.removePadding
- WidgetsBindingOberver: 监听 app 生命周期变化
- AtomaticKeepAliveClientMixin
- AppBar 
- BottomNavigationBar
- TabBar

- SingleChildScrollView
- NestedScrollView: 容器内有多种样式的滚动

## 点击空白处隐藏键盘
```dart
// 方式一
Scaffold(
    body: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: () {
            // 传入空的焦点
            FocusScope.of(context).requestFocus(FocusNode());

            /*
                // 要某个 text field 获取焦点可以这样
                var focus = FocusNode();
                var text = TextField(focusNode: focus);
                FocusScope.of(context).requestFocus(focus);
            */
        },
        child: ...
    ),
)

// 方式二
Scaffold(
    body: GestureDetector(
        onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
            }
        },
        child: ...,
    ),
);
```