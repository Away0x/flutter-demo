import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:baixing_shop/services/api.dart';
import 'package:baixing_shop/model/category_big_list_model.dart';
import 'package:baixing_shop/model/category_big_model.dart';
import 'package:baixing_shop/provide/child_category.dart';

class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {

  List<CategoryBigModel> list = [];
  int listIndex = 0;

  @override
  void initState() {
    _getCategory();
    super.initState();
  }

  void _getCategory() async {
    var resource = await getCategory();
    CategoryBigListModel data = CategoryBigListModel.fromJson(resource);

    setState(() {
      list = data.data;
    });

    if (list[0].bxMallSubDto.length != 0) {
      Provider.of<ChildCategory>(context).getChildCategory(list[0].bxMallSubDto);
    }
  }

  Widget _buildLeftInkWell(int index) {
    bool isClicked = false;
    isClicked = index == listIndex;

    var item = list[index];

    return InkWell(
      child: Container(
        height: ScreenUtil.getInstance().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 10),
        decoration: BoxDecoration(
          color: isClicked ? Color.fromRGBO(236, 238, 239, 1) : Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
        ),
        child: Text(item.mallCategoryName, style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(28))),
      ),
      onTap: () {
        if (isClicked) { return; }

        setState(() {
          listIndex = index;
        });

        List childList = item.bxMallSubDto;

        Provider.of<ChildCategory>(context).getChildCategory(childList);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(180),
      decoration: BoxDecoration(
        border: Border(right: BorderSide(width: 1, color: Colors.black12)),
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _buildLeftInkWell(index);
        },
      ),
    );
  }
}