import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:baixing_shop/application.dart';
import 'package:baixing_shop/router/router.dart';

import 'package:baixing_shop/provide/category_goods_list.dart';
import 'package:baixing_shop/provide/child_category.dart';
import 'package:baixing_shop/model/category_goods_list_model.dart';

import '../utils/utils.dart';

class GoodsList extends StatefulWidget {
  @override
  _GoodsListState createState() => _GoodsListState();
}

class _GoodsListState extends State<GoodsList> {

  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();
  ScrollController _scrollController = ScrollController();

  Widget _buildGoodImage(String imgPath) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(200),
      child: Image.network(imgPath),
    );
  }

  Widget _buildGoodName(String name) {
    return Container(
      padding: EdgeInsets.all(5),
      width: ScreenUtil.getInstance().setWidth(370),
      child: Text(
        name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(28)),
      ),
    );
  }

  Widget _buildGoodPrice(double presentPrice, double oriPrice) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: ScreenUtil.getInstance().setWidth(370),
      child: Row(
        children: <Widget>[
          Text('价格: ￥$presentPrice', style: TextStyle(color: Colors.pink, fontSize: ScreenUtil.getInstance().setSp(30))),
          Text('￥$oriPrice', style: TextStyle(color: Colors.black26, decoration: TextDecoration.lineThrough)),
        ],
      ),
    );
  }

  Widget _buildItem(CategoryListData item) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
        ),
        child: Row(
          children: <Widget>[
            _buildGoodImage(item.image),
            Column(
              children: <Widget>[
                _buildGoodName(item.goodsName),
                _buildGoodPrice(item.presentPrice, item.oriPrice),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        Application.router.navigateTo(context, '${MyRouter.detailPage}?id=${item.goodsId}');
      },
    );
  }

  _getMoreListData() async {
    Provider.of<ChildCategory>(context).addPage();
    var list = await getMallGoodsUtil(context, true);
    
    // print(list.map((v) => v.toJson()).toList());
    if (list.length == 0) {
      Fluttertoast.showToast(
        msg: '已经到底了',
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.pink,
        textColor: Colors.white,
        fontSize: 16,
      );
      Provider.of<ChildCategory>(context).changeNoMoreText('没有更多了');
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      if (Provider.of<ChildCategory>(context).page == 1) {
        _scrollController.jumpTo(0);
      }
    } catch(e) {}

    List<CategoryListData> list = Provider.of<CategoryGoodsListProvide>(context).goodList;

    if (list.length == 0) {
      return Center(child: Text('暂时没有数据'));
    }

    return Expanded(
      child: Container(
        width: ScreenUtil.getInstance().setWidth(570),
        child: EasyRefresh(
          refreshFooter: ClassicsFooter(
            key: _footerKey,
            bgColor: Colors.white,
            textColor: Colors.pink,
            moreInfoColor: Colors.pink,
            showMore: true,
            noMoreText: Provider.of<ChildCategory>(context).noMoreText,
            moreInfo: '加载中',
            loadReadyText: '上拉加载',
          ),
          loadMore: () async {
            _getMoreListData();
          },
          child: ListView.builder(
            controller: _scrollController,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return _buildItem(list[index]);
            },
          ),
        ),
      ),
    );
  }
}