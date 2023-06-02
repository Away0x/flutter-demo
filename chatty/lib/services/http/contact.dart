import 'package:chatty/entities/entities.dart';
import 'package:chatty/utils/http.dart';

class ContactAPI {
  static Future<ContactResponseEntity> postContact() async {
    var response = await HttpUtil().post(
      'api/contact',
    );
    return ContactResponseEntity.fromJson(response);
  }
}
