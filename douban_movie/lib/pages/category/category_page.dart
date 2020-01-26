import 'package:douban_movie/pages/category/category_detail_item.dart';
import 'package:douban_movie/services/category/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:douban_movie/model/douban.dart';
import 'package:douban_movie/base/root_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoryPage extends StatefulWidget {

  final DoubanCategory category;

  CategoryPage({
    Key key,
    this.category,
  });

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
  with SingleTickerProviderStateMixin {

  CategoryService _categoryService;
  TabController _tabController;
  RefreshController _refreshController;
  int _currentTab = 0;


  void _initData() {
    _categoryService = CategoryService(
      category: widget.category,
      onDataCallback: _onDataCallback,
    );

    _requestData();
  }

  void _onDataCallback() {
    _categoryService.isPageLoading = false;

    _refreshController.loadComplete();
    setState(() {});
  }

  void _requestData() {
    if (widget.category == DoubanCategory.Movie) {
      if (_currentTab == 0) {
        _categoryService.requestRecentMovie();
      } else if (_currentTab == 1 ) {
        _categoryService.requestCollectionMovie();
      } else {
        _categoryService.requestHotMovie();
      }
    } else if (widget.category == DoubanCategory.Book) {
      if (_currentTab == 0) {
        _categoryService.requestRecentBook();
      } else if (_currentTab == 1 ) {
        _categoryService.requestRecommandBook();
      } else {
        _categoryService.requestHotBook();
      }

    } else {
      if (_currentTab == 0) {
        _categoryService.requestRecentMusic();
      } else if (_currentTab == 1 ) {
        _categoryService.requestHotMusic();
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _initData();
    _tabController = TabController(vsync: this, length: _categoryService.tabbarTitles.length);
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _categoryService.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RootPage(
      title: DoubanModel.getDoubanTitle(widget.category),
      tabbar: _buildTabbar(),
      body: TabBarView(
        controller: _tabController,
        children: _buildTabBarViews(),
      ),
    );
  }

  Widget _buildTabbar() {
    return TabBar(
      controller: _tabController,
      onTap: _onTabbarTapped,
      unselectedLabelColor: Colors.white,
      indicatorColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.label, // 和字体长度一样长
      labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      labelPadding: EdgeInsets.only(bottom: 8),
      unselectedLabelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
      tabs: _buildTabs(),
    );
  }

  List<Widget> _buildTabs() {
    return _categoryService.tabbarTitles.map((s) {
      return Text(s);
    }).toList();
  }

  List<Widget> _buildTabBarViews() {
    return _categoryService.tabbarTitles.map((s) {
      return _buildList(s);
    }).toList();
  }

  Widget _buildList(String text) {
    if (_categoryService.isPageLoading) {
      return CupertinoActivityIndicator();
    }

    return SmartRefresher(
      enablePullDown: false,
      enablePullUp: true,
      controller: _refreshController,
      onLoading: _onLoading,
      child: ListView.separated(
        itemCount: _getItemCount(),
        itemBuilder: _buildListViewItem,
        separatorBuilder: (context, index) {
          return Container(height: 21);
        },
      ),
      footer: CustomFooter(
        builder: (context, mode) {
          Widget body;

          if (mode == LoadStatus.idle) {
            return Container();
          } else if (mode == LoadStatus.loading) {
            return CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text('加载失败');
          } else if (mode == LoadStatus.canLoading) {
            body = Text('release to load');
          } else {
            body = Text('No more data');
          }

          return Container(
            height: 55,
            child: Center(
              child: body,
            ),
          );
        },
      ),
    );
  }

  Widget _buildListViewItem(BuildContext context, int index) {
    if (_categoryService.isPageLoading) {
      return Container();
    }

    return CategoryDetailItem(
      context: context,
      category: widget.category,
      movie: widget.category == DoubanCategory.Movie ? _categoryService.movieList[index] : null,
      book: widget.category == DoubanCategory.Book ? _categoryService.bookList[index] : null,
      music: widget.category == DoubanCategory.Music ? _categoryService.musicList[index] : null,
    );
  }

  void _onLoading() {
    _categoryService.page++;
    _requestData();
  }

  void _onTabbarTapped(int index) {
    _currentTab = index;
    _categoryService.reset();
    _requestData();
    setState(() {});
  }

  int _getItemCount() {
    if (widget.category == DoubanCategory.Movie) {
      return _categoryService.movieList.length;
    } else if (widget.category == DoubanCategory.Book) {
      return _categoryService.bookList.length;
    } else {
      return _categoryService.musicList.length;
    }
  }

}