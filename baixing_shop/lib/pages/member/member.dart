import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget {

  Widget _buildHeader() {
    return Container(
      width: ScreenUtil.getInstance().setWidth(750),
      padding: EdgeInsets.all(20),
      color: Colors.pinkAccent,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 15),
            height: 100,
            child: ClipOval(
              child: Image.network('https://iocaffcdn.phphub.org/uploads/images/201710/14/1/s5ehp11z6s.png'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Text(
              'Away0x',
              style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(36), color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderTitle() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text('我的订单'),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  Widget _buildOrderTypeItem(String title, IconData icon) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(187),
      child: Column(
        children: <Widget>[
          Icon(icon, size: 30),
          Text(title),
        ],
      ),
    );
  }

  Widget _buildOrderType() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: ScreenUtil.getInstance().setWidth(750),
      height: ScreenUtil.getInstance().setHeight(150),
      padding: EdgeInsets.only(top: 20),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          _buildOrderTypeItem('待付款', Icons.party_mode),
          _buildOrderTypeItem('待发货', Icons.query_builder),
          _buildOrderTypeItem('待收货', Icons.directions_car),
          _buildOrderTypeItem('待评价', Icons.content_paste),
        ],
      ),
    );
  }

  Widget _buildActionItem(String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
      ),
      child: ListTile(
        leading: Icon(Icons.blur_circular),
        title: Text(title),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  Widget _buildActionList() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _buildActionItem('领取优惠券'),
          _buildActionItem('已领取优惠券'),
          _buildActionItem('地址管理'),
          _buildActionItem('客服电话'),
          _buildActionItem('关于我们'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会员中心'),
      ),
      body: ListView(
        children: <Widget>[
          _buildHeader(),
          _buildOrderTitle(),
          _buildOrderType(),
          _buildActionList(),
        ],
      ),
    );
  }
}