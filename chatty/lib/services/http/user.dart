import 'package:chatty/entities/entities.dart';
import 'package:chatty/utils/http.dart';

class UserAPI {
  static Future<UserLoginResponseEntity> login({
    LoginRequestEntity? params,
  }) async {
    var response = await HttpUtil().post(
      '/api/login',
      queryParameters: params?.toJson(),
    );
    return UserLoginResponseEntity.fromJson(response);
  }

  static Future<UserLoginResponseEntity> getProfile() async {
    var response = await HttpUtil().post(
      '/api/get_profile',
    );
    return UserLoginResponseEntity.fromJson(response);
  }

  static Future<BaseResponseEntity> updateProfile({
    LoginRequestEntity? params,
  }) async {
    var response = await HttpUtil().post(
      '/api/update_profile',
      queryParameters: params?.toJson(),
    );
    return BaseResponseEntity.fromJson(response);
  }
}
