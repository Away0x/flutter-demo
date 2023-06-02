import 'package:chatty/entities/entities.dart';
import 'package:get/get.dart';

class ChatState {
  RxList<Msgcontent> msgcontentList = <Msgcontent>[].obs;
  var to_token = "".obs;
  var to_name = "".obs;
  var to_avatar = "".obs;
  var to_online = "1".obs;
  RxBool more_status = false.obs;
  RxBool isloading = false.obs;
  RxInt inputHeight = 50.obs;
}
