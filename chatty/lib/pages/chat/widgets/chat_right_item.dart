import 'package:chatty/routes/names.dart';
import 'package:chatty/utils/date.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:chatty/entities/entities.dart';
import 'package:chatty/values/values.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

Widget RightRichTextContainer(String textContent) {
  const urlPattern =
      r"[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:._\+-~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:_\+.~#?&\/\/=]*)";
  List<InlineSpan> widgets = [];

  textContent.splitMapJoin(
    RegExp(urlPattern, caseSensitive: false, multiLine: false),
    onMatch: (Match match) {
      final matchText = match[0];
      if (matchText != null) {
        widgets.add(TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Uri u = Uri.parse(matchText);
                launchUrl(u);
              },
            text: matchText,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.primaryElementText,
              decoration: TextDecoration.underline,
            )));
      }
      return '';
    },
    onNonMatch: (String text) {
      if (text.isNotEmpty) {
        widgets.add(TextSpan(
            text: text,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.primaryElementText,
            )));
      }
      return '';
    },
  );
  return RichText(
    text: TextSpan(children: [...widgets]),
  );
}

Widget ChatRightItem(Msgcontent item) {
  return Container(
    padding: EdgeInsets.only(top: 10.w, left: 20.w, right: 20.w, bottom: 10.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: 250.w, //
                minHeight: 40.w //
                ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 0.w, top: 0.w),
                  padding: EdgeInsets.only(
                      top: 10.w, bottom: 10.w, left: 10.w, right: 10.w),
                  decoration: BoxDecoration(
                    color: AppColors.primaryElement,
                    borderRadius: BorderRadius.all(Radius.circular(5.w)),
                  ),
                  child: item.type == "text"
                      ? RightRichTextContainer("${item.content}")
                      : ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 90.w, //
                          ),
                          child: GestureDetector(
                            child:
                                CachedNetworkImage(imageUrl: "${item.content}"),
                            onTap: () {
                              Get.toNamed(AppRoutes.Photoimgview,
                                  parameters: {"url": item.content ?? ""});
                            },
                          )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.h),
                  child: Text(
                      item.addtime == null
                          ? ""
                          : duTimeLineFormat(
                              (item.addtime as Timestamp).toDate()),
                      style: TextStyle(
                          fontSize: 10.sp,
                          color: AppColors.primarySecondaryElementText)),
                )
              ],
            )),
      ],
    ),
  );
}
