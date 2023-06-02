import 'package:get/get.dart';

class VoicecallState {
  RxString url = "".obs;
  RxBool isJoined = false.obs;
  RxBool openMicrophone = true.obs;
  RxBool enableSpeakerphone = true.obs;
  RxString call_time = "00:00".obs;
  RxString call_time_num = "not connected".obs;

  var channelId = "".obs;

  var to_token = "".obs;
  var to_name = "".obs;
  var to_avatar = "".obs;
  var doc_id = "".obs;
  var call_role = "audience".obs; // 1，anchor 2，audience
}
