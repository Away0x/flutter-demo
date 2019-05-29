import 'package:flutter/material.dart';

class DiscoverItemData {
  final String icon;
  final String title;
  final bool showBottomDivider;
  final bool showBottomBlank;

  const DiscoverItemData({
    @required this.icon,
    @required this.title,
    this.showBottomDivider: false,
    this.showBottomBlank: false,
  });
}

List<DiscoverItemData> discoverData = [
  const DiscoverItemData(
    icon: 'assets/images/ic_social_circle.png',
    title: '朋友圈',
    showBottomBlank: true,
  ),

  const DiscoverItemData(
    icon: 'assets/images/ic_quick_scan.png',
    title: '扫一扫',
    showBottomDivider: true,
  ),
  const DiscoverItemData(
    icon: 'assets/images/ic_shake_phone.png',
    title: '摇一摇',
    showBottomBlank: true,
  ),

  const DiscoverItemData(
    icon: 'assets/images/ic_feeds.png',
    title: '看一看',
    showBottomDivider: true,
  ),
  const DiscoverItemData(
    icon: 'assets/images/ic_quick_search.png',
    title: '搜一搜',
    showBottomBlank: true,
  ),

  const DiscoverItemData(
    icon: 'assets/images/ic_people_nearby.png',
    title: '附近的人',
    showBottomDivider: true,
  ),
  const DiscoverItemData(
    icon: 'assets/images/ic_bottle_msg.png',
    title: '漂流瓶',
    showBottomBlank: true,
  ),

  const DiscoverItemData(
    icon: 'assets/images/ic_shopping.png',
    title: '购物',
    showBottomDivider: true,
  ),
  const DiscoverItemData(
    icon: 'assets/images/ic_game_entry.png',
    title: '游戏',
    showBottomBlank: true,
  ),

  const DiscoverItemData(
    icon: 'assets/images/ic_mini_program.png',
    title: '小程序',
    showBottomBlank: true,
  ),
];
