// 店长电话
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LeaderPhone extends StatelessWidget {

  final String leaderImg; // 店长图片
  final String leaderPhone; // 店长电话

  LeaderPhone({Key key, this.leaderImg, this.leaderPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: Image.network(leaderImg),
        onTap: _launchURL,
      ),
    );
  }

  _launchURL() async {
    String url = 'tel:' + leaderPhone;

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}