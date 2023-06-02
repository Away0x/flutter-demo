import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatty/pages/chat/widgets/chat_list.dart';
import 'package:chatty/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Obx(
        () => SafeArea(
          child: ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const ChatList(),
                Positioned(
                  bottom: 0.h,
                  child: Container(
                    width: 360.w,
                    constraints:
                        BoxConstraints(maxHeight: 170.h, minHeight: 70.h),
                    padding: EdgeInsets.only(
                        left: 20.w, right: 20.w, bottom: 10.h, top: 10.h),
                    color: AppColors.primaryBackground,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: 270.w,
                            constraints: BoxConstraints(
                                maxHeight: 170.h, minHeight: 30.h),
                            padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                            decoration: BoxDecoration(
                              color: AppColors.primaryBackground,
                              border: Border.all(
                                  color: AppColors.primarySecondaryElementText),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Row(children: [
                              Container(
                                width: 220.w,
                                constraints: BoxConstraints(
                                    maxHeight: 150.h, minHeight: 20.h),
                                child: TextField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  controller: controller.myinputController,
                                  autofocus: false,
                                  decoration: InputDecoration(
                                    hintText: "Message...",
                                    isDense: true,
                                    contentPadding: EdgeInsets.only(
                                        left: 10.w, top: 0, bottom: 0),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    disabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    hintStyle: const TextStyle(
                                      color:
                                          AppColors.primarySecondaryElementText,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                child: SizedBox(
                                  width: 40.w,
                                  height: 40.h,
                                  child: Image.asset("assets/icons/send.png"),
                                ),
                                onTap: () {
                                  controller.sendMessage();
                                },
                              )
                            ])),
                        GestureDetector(
                            child: Container(
                                height: 40.w,
                                width: 40.w,
                                padding: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryElement,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      offset: const Offset(
                                          1, 1), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40.w)),
                                ),
                                child: controller.state.more_status.value
                                    ? Image.asset("assets/icons/by.png")
                                    : Image.asset("assets/icons/add.png")),
                            onTap: () {
                              controller.goMore();
                            }),
                      ],
                    ),
                  ),
                ),
                controller.state.more_status.value
                    ? Positioned(
                        right: 20.w,
                        bottom: 70.h,
                        height: 200.w,
                        width: 40.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              child: Container(
                                  height: 40.w,
                                  width: 40.w,
                                  padding: EdgeInsets.all(10.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryBackground,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        offset: const Offset(
                                            1, 1), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40.w)),
                                  ),
                                  child: Image.asset("assets/icons/file.png")),
                              onTap: () {
                                controller.imgFromGallery();
                              },
                            ),
                            GestureDetector(
                              child: Container(
                                  height: 40.w,
                                  width: 40.w,
                                  padding: EdgeInsets.all(10.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryBackground,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        offset: const Offset(
                                            1, 1), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40.w)),
                                  ),
                                  child: Image.asset("assets/icons/photo.png")),
                              onTap: () {
                                controller.imgFromCamera();
                              },
                            ),
                            GestureDetector(
                              child: Container(
                                  height: 40.w,
                                  width: 40.w,
                                  padding: EdgeInsets.all(10.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryBackground,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        offset: const Offset(
                                            1, 1), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40.w)),
                                  ),
                                  child: Image.asset("assets/icons/call.png")),
                              onTap: () {
                                controller.callAudio();
                              },
                            ),
                            GestureDetector(
                              child: Container(
                                  height: 40.w,
                                  width: 40.w,
                                  padding: EdgeInsets.all(10.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryBackground,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        offset: const Offset(
                                            1, 1), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40.w)),
                                  ),
                                  child: Image.asset("assets/icons/video.png")),
                              onTap: () {
                                controller.callVideo();
                              },
                            ),
                          ],
                        ))
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primaryBackground,
      title: Obx(() {
        return Container(
          padding: EdgeInsets.only(top: 0.w, left: 0.w, right: 0.w),
          child: Text(
            "${controller.state.to_name}",
            overflow: TextOverflow.clip,
            maxLines: 1,
            style: TextStyle(
              fontFamily: 'Avenir',
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
              fontSize: 16.sp,
            ),
          ),
        );
      }),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 20.w),
          child: Stack(alignment: Alignment.center, children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: AppColors.primarySecondaryBackground,
                borderRadius: BorderRadius.all(Radius.circular(22.w)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              // ignore: unnecessary_null_comparison
              child: controller.state.to_avatar.value == null
                  ? const Image(
                      image: AssetImage('assets/images/account_header.png'),
                    )
                  : CachedNetworkImage(
                      imageUrl: controller.state.to_avatar.value,
                      height: 44.w,
                      width: 44.w,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(
                            22.w,
                          )),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                            colorFilter: const ColorFilter.mode(
                              Colors.red,
                              BlendMode.colorBurn,
                            ),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => const Image(
                        image: AssetImage(
                          'assets/images/account_header.png',
                        ),
                      ),
                    ),
            ),
            Positioned(
              bottom: 5.w,
              right: 0.w,
              height: 14.w,
              child: Container(
                width: 14.w,
                height: 14.w,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2.w,
                    color: AppColors.primaryElementText,
                  ),
                  color: controller.state.to_online.value == "1"
                      ? AppColors.primaryElementStatus
                      : AppColors.primarySecondaryElementText,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.w),
                  ),
                ),
              ),
            )
          ]),
        )
      ],
    );
  }
}
