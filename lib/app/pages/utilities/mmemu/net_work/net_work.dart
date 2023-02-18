import 'package:dio/dio.dart';
import 'package:my_cving/app/config/constant.dart';

class NetWorkMmenu {
  final Dio dio = Dio(BaseOptions(
    headers: {
      'appid': 'mmenu-admin.android.1.25.78+773',
      'lang': 'en',
    },
    baseUrl: baseUrlMmenu,
  ))
    ..interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

  static final NetWorkMmenu _singleton = NetWorkMmenu._internal();

  factory NetWorkMmenu() {
    return _singleton;
  }

  NetWorkMmenu._internal();

  setAuthorization(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }
}
