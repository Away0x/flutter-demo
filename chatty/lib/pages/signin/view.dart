import 'package:chatty/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import './controller.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarySecondaryBackground,
      body: Center(
        child: Column(
          children: [
            _buildLogo(),
            _buildThirdPartyLogin("Google", "google"),
            _buildThirdPartyLogin("Facebook", "facebook"),
            _buildThirdPartyLogin("Apple", "apple"),
            _buildOrWidget(),
            _buildThirdPartyLogin("phone number", null),
            SizedBox(height: 35.h),
            _buildSignUpWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      margin: EdgeInsets.only(top: 100.h, bottom: 80.h),
      child: Text(
        'Chatty .',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.primaryText,
          fontWeight: FontWeight.bold,
          fontSize: 34.sp,
        ),
      ),
    );
  }

  Widget _buildThirdPartyLogin(String loginType, String? logo) {
    var hasLogo = logo != null;

    return GestureDetector(
      onTap: () {
        print("sign up from here third party($loginType)");
        controller.handleSignIn("google");
      },
      child: Container(
        width: 295.w,
        height: 44.h,
        padding: EdgeInsets.all(10.h),
        margin: EdgeInsets.only(bottom: 15.h),
        decoration: BoxDecoration(
          color: AppColors.primaryBackground,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment:
              hasLogo ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            hasLogo
                ? Container(
                    padding: EdgeInsets.only(left: 40.w, right: 30.w),
                    child: Image.asset("assets/icons/$logo.png"),
                  )
                : const SizedBox(),
            Text(
              "Sign in with $loginType",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryText,
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrWidget() {
    return Container(
      margin: EdgeInsets.only(top: 20.h, bottom: 35.h),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              indent: 50,
              height: 2.h,
              color: AppColors.primarySecondaryElementText,
            ),
          ),
          const Text("  or  "),
          Expanded(
            child: Divider(
              endIndent: 50,
              height: 2.h,
              color: AppColors.primarySecondaryElementText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpWidget() {
    return GestureDetector(
      onTap: () {
        print("sign up");
      },
      child: Column(
        children: [
          Text(
            "Already have an account",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 12.sp,
            ),
          ),
          GestureDetector(
            child: Text(
              "Sign up here",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryElement,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
