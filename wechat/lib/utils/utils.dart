
// 判断图片是否来自网络
bool isAvatarFromNet(String avatarPath) {
  return avatarPath.indexOf('http') == 0 || avatarPath.indexOf('https') == 0;
}