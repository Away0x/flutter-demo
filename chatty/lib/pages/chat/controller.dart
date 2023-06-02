import 'dart:io';
import 'package:chatty/entities/entities.dart';
import 'package:chatty/routes/names.dart';
import 'package:chatty/services/http/http.dart';
import 'package:chatty/stores/stores.dart';
import 'package:chatty/widgets/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';

import './state.dart';

class ChatController extends GetxController {
  final state = ChatState();

  final myinputController = TextEditingController();
  ScrollController myscrollController = ScrollController();
  ScrollController inputScrollController = ScrollController();
  FocusNode contentFocus = FocusNode();
  final db = FirebaseFirestore.instance;
  bool isloadmore = true;
  double inputHeightStatus = 0;
  var listener;
  var doc_id = null;
  final token = UserStore.to.profile.token;
  File? _photo;
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();

    var data = Get.parameters;
    doc_id = data["doc_id"];
    state.to_token.value = data["to_token"] ?? "";
    state.to_name.value = data["to_name"] ?? "";
    state.to_avatar.value = data["to_avatar"] ?? "";
    state.to_online.value = data["to_online"] ?? "1";
    clear_msg_num(doc_id);
  }

  @override
  void onReady() {
    super.onReady();
    print("onReady------------");
    state.msgcontentList.clear();
    final messages = db
        .collection("message")
        .doc(doc_id)
        .collection("msglist")
        .withConverter(
          fromFirestore: Msgcontent.fromFirestore,
          toFirestore: (Msgcontent msgcontent, options) =>
              msgcontent.toFirestore(),
        )
        .orderBy("addtime", descending: true)
        .limit(15);

    listener = messages.snapshots().listen(
      (event) {
        print("current data: ${event.docs}");
        print("current data: ${event.metadata.hasPendingWrites}");
        List<Msgcontent> tempMsgList = <Msgcontent>[];
        for (var change in event.docChanges) {
          switch (change.type) {
            case DocumentChangeType.added:
              print("added----: ${change.doc.data()}");
              if (change.doc.data() != null) {
                tempMsgList.add(change.doc.data()!);
              }
              break;
            case DocumentChangeType.modified:
              print("Modified City: ${change.doc.data()}");
              break;
            case DocumentChangeType.removed:
              print("Removed City: ${change.doc.data()}");
              break;
          }
        }
        tempMsgList.reversed.forEach((element) {
          state.msgcontentList.value.insert(0, element);
        });
        state.msgcontentList.refresh();

        SchedulerBinding.instance.addPostFrameCallback((_) {
          if (myscrollController.hasClients) {
            myscrollController.animateTo(
              myscrollController.position.minScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      },
      onError: (error) => print("Listen failed: $error"),
    );

    myscrollController.addListener(() {
      // print(myscrollController.offset);
      //  print(myscrollController.position.maxScrollExtent);
      if ((myscrollController.offset + 10) >
          myscrollController.position.maxScrollExtent) {
        if (isloadmore) {
          state.isloading.value = true;
          isloadmore = false;
          asyncLoadMoreData(state.msgcontentList.length);
        }
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    print("onClose-------");
    clear_msg_num(doc_id);
  }

  @override
  void dispose() {
    listener.cancel();
    myinputController.dispose();
    inputScrollController.dispose();
    print("dispose-------");
    super.dispose();
  }

  clear_msg_num(String doc_id) async {
    var message_res = await db
        .collection("message")
        .doc(doc_id)
        .withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg msg, options) => msg.toFirestore(),
        )
        .get();
    if (message_res.data() != null) {
      var item = message_res.data()!;
      int to_msg_num = item.to_msg_num == null ? 0 : item.to_msg_num!;
      int from_msg_num = item.from_msg_num == null ? 0 : item.from_msg_num!;
      if (item.from_token == token) {
        to_msg_num = 0;
      } else {
        from_msg_num = 0;
      }
      await db
          .collection("message")
          .doc(doc_id)
          .update({"to_msg_num": to_msg_num, "from_msg_num": from_msg_num});
    }
  }

  goMore() {
    state.more_status.value = state.more_status.value ? false : true;
  }

  callAudio() async {
    state.more_status.value = false;
    Get.toNamed(AppRoutes.VoiceCall, parameters: {
      "doc_id": doc_id,
      "to_token": state.to_token.value,
      "to_name": state.to_name.value,
      "to_avatar": state.to_avatar.value,
      "call_role": "anchor"
    });
  }

  callVideo() async {
    state.more_status.value = false;
    Get.toNamed(AppRoutes.VideoCall, parameters: {
      "doc_id": doc_id,
      "to_token": state.to_token.value,
      "to_name": state.to_name.value,
      "to_avatar": state.to_avatar.value,
      "call_role": "anchor"
    });
  }

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _photo = File(pickedFile.path);
      uploadFile();
    } else {
      print('No image selected.');
    }
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _photo = File(pickedFile.path);
      uploadFile();
    } else {
      print('No image selected.');
    }
  }

  Future uploadFile() async {
    if (_photo == null) return;
    print(_photo);
    var result = await ChatAPI.upload_img(file: _photo);
    print(result.data);
    if (result.code == 0) {
      sendImageMessage(result.data!);
    } else {
      toastInfo(msg: "image error");
    }
  }

  sendMessage() async {
    print("---------------chat-----------------");
    String sendcontent = myinputController.text;
    if (sendcontent.isEmpty) {
      toastInfo(msg: "content not empty");
      return;
    }
    print("---------------chat--${sendcontent}-----------------");
    final content = Msgcontent(
      token: token,
      content: sendcontent,
      type: "text",
      addtime: Timestamp.now(),
    );

    await db
        .collection("message")
        .doc(doc_id)
        .collection("msglist")
        .withConverter(
          fromFirestore: Msgcontent.fromFirestore,
          toFirestore: (Msgcontent msgcontent, options) =>
              msgcontent.toFirestore(),
        )
        .add(content)
        .then((DocumentReference doc) {
      print('DocumentSnapshot added with ID: ${doc.id}');
      myinputController.clear();
    });
    var message_res = await db
        .collection("message")
        .doc(doc_id)
        .withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg msg, options) => msg.toFirestore(),
        )
        .get();
    if (message_res.data() != null) {
      var item = message_res.data()!;
      int to_msg_num = item.to_msg_num == null ? 0 : item.to_msg_num!;
      int from_msg_num = item.from_msg_num == null ? 0 : item.from_msg_num!;
      if (item.from_token == token) {
        from_msg_num = from_msg_num + 1;
      } else {
        to_msg_num = to_msg_num + 1;
      }
      await db.collection("message").doc(doc_id).update({
        "to_msg_num": to_msg_num,
        "from_msg_num": from_msg_num,
        "last_msg": sendcontent,
        "last_time": Timestamp.now()
      });
    }
    sendNotifications("text");
  }

  sendImageMessage(String url) async {
    state.more_status.value = false;
    print("---------------chat-----------------");
    final content = Msgcontent(
      token: token,
      content: url,
      type: "image",
      addtime: Timestamp.now(),
    );

    await db
        .collection("message")
        .doc(doc_id)
        .collection("msglist")
        .withConverter(
          fromFirestore: Msgcontent.fromFirestore,
          toFirestore: (Msgcontent msgcontent, options) =>
              msgcontent.toFirestore(),
        )
        .add(content)
        .then((DocumentReference doc) {
      print('DocumentSnapshot added with ID: ${doc.id}');
    });
    var message_res = await db
        .collection("message")
        .doc(doc_id)
        .withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg msg, options) => msg.toFirestore(),
        )
        .get();
    if (message_res.data() != null) {
      var item = message_res.data()!;
      int to_msg_num = item.to_msg_num == null ? 0 : item.to_msg_num!;
      int from_msg_num = item.from_msg_num == null ? 0 : item.from_msg_num!;
      if (item.from_token == token) {
        from_msg_num = from_msg_num + 1;
      } else {
        to_msg_num = to_msg_num + 1;
      }
      await db.collection("message").doc(doc_id).update({
        "to_msg_num": to_msg_num,
        "from_msg_num": from_msg_num,
        "last_msg": "【image】",
        "last_time": Timestamp.now()
      });
    }

    sendNotifications("text");
  }

  sendNotifications(String call_type) async {
    CallRequestEntity callRequestEntity = CallRequestEntity();
    // text,voice,video,cancel
    callRequestEntity.call_type = call_type;
    callRequestEntity.to_token = state.to_token.value;
    callRequestEntity.to_avatar = state.to_avatar.value;
    callRequestEntity.doc_id = doc_id;
    callRequestEntity.to_name = state.to_name.value;
    var res = await ChatAPI.call_notifications(params: callRequestEntity);
    print(res);
    if (res.code == 0) {
      print("sendNotifications success");
    } else {
      // Get.snackbar("Tips", "Notification error!");
      // Get.offAllNamed(AppRoutes.Message);
    }
  }

  asyncLoadMoreData(int page) async {
    final messages = await db
        .collection("message")
        .doc(doc_id)
        .collection("msglist")
        .withConverter(
          fromFirestore: Msgcontent.fromFirestore,
          toFirestore: (Msgcontent msgcontent, options) =>
              msgcontent.toFirestore(),
        )
        .orderBy("addtime", descending: true)
        .where("addtime", isLessThan: state.msgcontentList.value.last.addtime)
        .limit(10)
        .get();
    print(state.msgcontentList.value.last.content);
    print("isGreaterThan-----");
    if (messages.docs.isNotEmpty) {
      messages.docs.forEach((element) {
        var data = element.data();
        state.msgcontentList.value.add(data);
        print(data.content);
      });

      SchedulerBinding.instance.addPostFrameCallback((_) {
        isloadmore = true;
      });
    }
    state.isloading.value = false;
  }

  close_all_pop() async {
    Get.focusScope?.unfocus();
    state.more_status.value = false;
    print("------close_all_pop");
  }
}
