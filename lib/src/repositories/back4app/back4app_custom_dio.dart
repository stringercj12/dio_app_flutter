import 'package:dio/dio.dart';
import 'package:dio_app_flutter/src/repositories/back4app/back4app_dio_interceptors.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Back4AppCustomDio {
  final _dio = Dio();

  Dio get dio => _dio;

  Back4AppCustomDio() {
    _dio.options.headers['Content-Type'] = "application/json";
    _dio.options.baseUrl = dotenv.get("BACK4APP_BASE_URL");
    _dio.interceptors.add(Back4AppDioInterceptor());
  }
}
