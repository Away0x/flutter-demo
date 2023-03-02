import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_template/styles/index.dart';

import 'controller.dart';

class SignInPage extends GetView<SignInPageController> {
  const SignInPage({super.key});

  // logo
  Widget _buildLogo() {
    return Container(
      width: 110.w,
      margin: EdgeInsets.only(top: (40 + 44.0).h), // 顶部系统栏 44px
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 76.w,
            width: 76.w,
            margin: EdgeInsets.symmetric(horizontal: 15.w),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(60.0),
                    ),
                    child: Image.asset('assets/images/icon.png'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 第三方登录
  Widget _buildThirdPartyLogin() {
    return Container(
      width: 295.w,
      margin: EdgeInsets.only(bottom: 280.h),
      child: Column(
        children: <Widget>[
          // title
          Text(
            "sign in with social networks",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.primaryText,
              fontFamily: "Avenir",
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
            ),
          ),
          // 按钮
          Padding(
              padding: EdgeInsets.only(top: 30.h, left: 50.w, right: 50.w),
              child: SizedBox(
                width: 200.w,
                height: 50.h,
                child: TextButton(
                  style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(TextStyle(
                      fontSize: 16.sp,
                    )),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (states) {
                        if (states.contains(MaterialState.focused) &&
                            !states.contains(MaterialState.pressed)) {
                          return Colors.blue;
                        } else if (states.contains(MaterialState.pressed)) {
                          return Colors.deepPurple;
                        }
                        return AppColor.primaryElementText;
                      },
                    ),
                    backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.blue[200];
                      }
                      return AppColor.primaryElement;
                    }),
                    shape:
                        MaterialStateProperty.all(const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    )),
                  ),
                  child: Text(
                    "Sign In",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.primaryElementText,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      height: 1,
                    ),
                  ),
                  onPressed: () => {
                    controller.handleSignIn(
                      email: "tong.wu@joinhorizons.com",
                      password: "123",
                    )
                  },
                ),
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: <Widget>[
            _buildLogo(),
            const Spacer(),
            _buildThirdPartyLogin(),
          ],
        ),
      ),
    );
  }
}
