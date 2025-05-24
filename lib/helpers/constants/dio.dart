import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../singleton/base_singelton.dart';

class CustomDio with BaseSingleton {
  static CustomDio? _instance;
  static CustomDio get instance {
    _instance ??= CustomDio._init();
    return _instance!;
  }

  final dio = Dio();

  CustomDio._init();
  initilaze() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          log("onRequest", name: "dio");
          log(options.headers.toString(), name: "options");
          log(options.path, name: "path");
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          String token = prefs.getString("token") ?? "";
          if (token != "") {
            options.headers["Authorization"] = "Bearer $token";
            log(token, name: "token");
          }

          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          return handler.next(response);
        },
        onError: (DioException error, ErrorInterceptorHandler handler) async {
          if (error.response?.statusCode == 401) {}
          return handler.next(error);
        },
      ),
    );
  }
}
