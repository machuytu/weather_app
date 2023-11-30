import 'dart:async';
import "package:dio/dio.dart";

import '../../../presentation/util/shared_preferences.dart';
import 'apisubdomain.dart';

class Client {
  Future<Dio> init() async {
    SharedPref sharedPref = SharedPref();

    String accessToken = await sharedPref.read("accessToken");

    BaseOptions options = BaseOptions(
      contentType: Headers.jsonContentType,
      baseUrl: API.domain,
      receiveDataWhenStatusError: true,
    );
    Dio dio = Dio(options);
    dio.options.baseUrl = API.domain;
    dio.options.headers["Authorization"] = "Bearer $accessToken";
    return dio;
  }
}

class DataRequest {
  ErrorInterceptorHandler handler;
  RequestOptions requestOptions;
  DataRequest(this.handler, this.requestOptions);
}
