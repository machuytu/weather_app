import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../presentation/res/mess_data.dart';
import '../../../presentation/util/log_debug.dart';
import '../local/preference_provider.dart';
import 'apisubdomain.dart';
import 'network_response.dart';

mixin RestClient {
  String domain = API.domain;
  final Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: "application/json"
  };

  Future<NetworkResponse> getAsync(String pathURL,
      {Map<String, String>? query, String? apiDomain}) async {
    if (apiDomain != null) {
      domain = apiDomain;
    }

    Dio clientDio = Dio();

    NetworkResponse networkResponse = NetworkResponse();
    DioException exception =
        DioException(requestOptions: RequestOptions(path: domain + pathURL));
    try {
      log("");
      log(domain + pathURL, "GET");
      log(query.toString(), "Query Parameters");

      final response = await clientDio.get(
        domain + pathURL,
        options: Options(
          receiveDataWhenStatusError: true,
        ),
      );

      log(response.statusCode, "Status Code");
      log(response.data, "Response");

      networkResponse
        ..statusCode = response.statusCode!
        ..body = response.data;
    } on DioException catch (e) {
      exception = e;
    }
    networkResponse = processResponse(networkResponse, exception);
    return networkResponse;
  }

  Future<NetworkResponse> postAsync(
    String pathURL, {
    dynamic body,
    Map<String, String>? query,
    String? domainURL,
  }) async {
    Dio clientDio = Dio();
    NetworkResponse networkResponse = NetworkResponse();
    DioException exception = DioException(
        requestOptions: RequestOptions(path: (domainURL ?? domain) + pathURL));

    try {
      log("");
      log((domainURL ?? domain) + pathURL, "POST");
      log(query.toString(), "Query Parameters");
      log("Body: $body");
      final response = await clientDio.post(
        (domainURL ?? domain) + pathURL,
        data: body,
        options: Options(
          receiveDataWhenStatusError: true,
        ),
      );
      log(response.statusCode, "Status Code");
      log(response.data, "Response");

      networkResponse
        ..statusCode = response.statusCode
        ..body = response.data;
    } on DioException catch (e) {
      exception = e;
    }
    networkResponse = processResponse(networkResponse, exception);
    return networkResponse;
  }

  Future<NetworkResponse> putAsync(String pathURL,
      {dynamic body,
      Map<String, String>? query,
      String? domainURL,
      Map<String, String>? header}) async {
    Dio clientDio = Dio();
    NetworkResponse networkResponse = NetworkResponse();
    DioException exception = DioException(
        requestOptions: RequestOptions(path: (domainURL ?? domain) + pathURL));
    if (header != null) {
      headers.addAll(header);
    }
    try {
      log("");
      log(domain + pathURL, "PUT");
      log(query.toString(), "Query Parameters");
      log("Body: $body");
      final response = await clientDio.put(
        (domainURL ?? domain) + pathURL,
        data: body,
        options: Options(
          receiveDataWhenStatusError: true,
        ),
      );
      log(response.statusCode, "Status Code");
      log(response.data, "Response");

      networkResponse
        ..statusCode = response.statusCode
        ..body = response.data;
    } on DioException catch (e) {
      exception = e;
    }
    networkResponse = processResponse(networkResponse, exception);
    return networkResponse;
  }

  Future<NetworkResponse> deleteAsync(String pathURL,
      {dynamic body,
      String? domainURL,
      Map<String, String>? query,
      Map<String, String>? header}) async {
    Dio clientDio = Dio();
    NetworkResponse networkResponse = NetworkResponse();
    DioException exception = DioException(
        requestOptions: RequestOptions(path: (domainURL ?? domain) + pathURL));
    if (header != null) {
      headers.addAll(header);
    }
    try {
      log("");
      log((domainURL ?? domain) + pathURL, "POST");
      log(query.toString(), "Query Parameters");
      log("Body: $body");
      final response = await clientDio.delete(
        (domainURL ?? domain) + pathURL,
        data: body,
        options: Options(
          receiveDataWhenStatusError: true,
        ),
      );
      log(response.statusCode, "Status Code");
      log(response.data, "Response");

      networkResponse
        ..statusCode = response.statusCode
        ..body = response.data;
    } on DioException catch (e) {
      exception = e;
    }
    networkResponse = processResponse(networkResponse, exception);
    return networkResponse;
  }

  Future<NetworkResponse> getAsyncWithToken(String pathURL, Dio client,
      {Map<String, String>? query,
      Map<String, dynamic>? body,
      String? domainURL}) async {
    Dio clientDio = client;
    NetworkResponse networkResponse = NetworkResponse();
    DioException exception =
        DioException(requestOptions: RequestOptions(path: domain + pathURL));
    String token = await PreferenceProvider.getToken() ?? "";
    domain = domainURL ?? API.domain;
    try {
      log("");
      log(domain + pathURL, "GET");
      log(query.toString(), "Query Parameters");
      log("Bearer Token: $token");
      final response = await clientDio.get(
        domain + pathURL,
        options: Options(
          receiveDataWhenStatusError: true,
        ),
        queryParameters: body,
      );

      log(response.statusCode, "Status Code");
      log(response.data, "Response");

      networkResponse
        ..statusCode = response.statusCode
        ..body = response.data;
    } on DioException catch (e) {
      exception = e;
    }
    networkResponse = processResponse(networkResponse, exception);
    return networkResponse;
  }

  Future<NetworkResponse> postAsyncWithToken(
    String pathURL,
    Dio client, {
    dynamic body,
    Map<String, dynamic>? query,
    String? domainURL,
  }) async {
    Dio clientDio = client;
    NetworkResponse networkResponse = NetworkResponse();
    DioException exception =
        DioException(requestOptions: RequestOptions(path: domain + pathURL));
    String token = await PreferenceProvider.getToken() ?? "";
    domain = domainURL ?? API.domain;
    try {
      log("");
      log(domain + pathURL, "POST");
      log(query.toString(), "Query Parameters");
      log(body.toString(), "Body");
      log("Bearer Token: $token");
      final response = await clientDio.post(
        domain + pathURL,
        data: body,
        queryParameters: query,
        options: Options(
          receiveDataWhenStatusError: true,
        ),
      );
      log(response.statusCode, "Status Code");
      log(response.data, "Response");

      networkResponse
        ..statusCode = response.statusCode
        ..body = response.data;
    } on DioException catch (e) {
      exception = e;
    }
    networkResponse = processResponse(networkResponse, exception);
    return networkResponse;
  }

  Future<NetworkResponse> putAsyncWithToken(String pathURL, Dio client,
      {dynamic body, String? domainURL, dynamic query}) async {
    Dio clientDio = client;
    NetworkResponse networkResponse = NetworkResponse();

    String? token = await PreferenceProvider.getToken();
    Map<String, String> mapToken = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    headers.addAll(mapToken);
    try {
      log("");
      log("PUT:${domainURL ?? domain}$pathURL");
      log("Body:$body");
      log("Bearer Token: ${token!}");
      final response = await clientDio.put((domainURL ?? domain) + pathURL,
          data: body, queryParameters: query);

      log(response.statusCode, "Status Code");
      log(response.data, "Response");

      networkResponse
        ..statusCode = response.statusCode
        ..body = response.data;
      // ignore: empty_catches
    } catch (e) {}

    return networkResponse;
  }

  Future<NetworkResponse> deleteAsyncWithToken(
    String pathURL,
    Dio client, {
    Map<String, String>? query,
    dynamic body,
    String? domainURL,
  }) async {
    Dio clientDio = client;
    domain = domainURL ?? API.domain;
    NetworkResponse networkResponse = NetworkResponse();
    DioException exception =
        DioException(requestOptions: RequestOptions(path: domain + pathURL));
    String token = await PreferenceProvider.getToken() ?? "";
    Map<String, String> mapToken = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    headers.addAll(mapToken);
    try {
      log("");
      log(domain + pathURL, "DELETE");
      log(query.toString(), "Query Parameters");
      log(body.toString(), "Body");
      log("Bearer Token: $token");
      final response = await clientDio.delete(domain + pathURL,
          data: jsonEncode(body), queryParameters: query);

      log(response.statusCode, "Status Code");
      log(response.data, "Response");

      networkResponse
        ..statusCode = response.statusCode
        ..body = response.data;
    } on DioException catch (e) {
      exception = e;
    }
    networkResponse = processResponse(networkResponse, exception);
    return networkResponse;
  }

  Future<NetworkResponse> postMultiPartFormDataAsyncWithToken<T>(
    String pathURL,
    Dio client, {
    Map<String, dynamic>? query,
    Map<String, String>? header,
    String? domainURL,
    File? file,
    FormData? body,
    void Function(int, int)? onProgress,
  }) async {
    Dio clientDio = client;
    NetworkResponse networkResponse = NetworkResponse();
    DioException exception =
        DioException(requestOptions: RequestOptions(path: domain + pathURL));
    String token = await PreferenceProvider.getToken() ?? "";

    FormData formData = FormData();
    if (file != null) {
      String fileName = file.path.split('/').last;
      formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename: fileName),
      });
    }

    domain = domainURL ?? API.domain;

    CancelToken cancelToken = CancelToken();
    try {
      log("");
      log(domain + pathURL, "POST");
      log(query.toString(), "Query Parameters");
      log("Bearer Token: $token");
      Timer t = Timer(const Duration(seconds: 120), () {
        cancelToken.cancel();
      });
      final response = await clientDio.post(
        domain + pathURL,
        data: body ?? formData,
        onSendProgress: onProgress ??
            (count, total) {
              if (kDebugMode) {
                print(count / total);
              }
              t.cancel();
              int percent = (((count / total) * 100).toInt());
              if (percent == 100) {
                t.cancel();
              } else {
                t = Timer(const Duration(seconds: 90), () {
                  cancelToken.cancel();
                });
              }
            },
        cancelToken: cancelToken,
      );
      t.cancel();

      log(response.statusCode, "Status Code");
      log(response.data, "Response");

      networkResponse
        ..statusCode = response.statusCode
        ..body = response.data;
      return networkResponse;
    } on DioException catch (e) {
      exception = e;
      return networkResponse;
    } on TimeoutException catch (_) {
      // A timeout occurred.
    }
    networkResponse = processResponse(networkResponse, exception);

    networkResponse
      ..statusCode = 200
      ..body['res'] = 0;
    return networkResponse;
  }

  Future<NetworkResponse> putMultiPartFormDataAsyncWithToken<T>(
    String pathURL,
    Dio client, {
    Map<String, dynamic>? query,
    Map<String, String>? header,
    String? domainURL,
    File? file,
    dynamic body,
  }) async {
    Dio clientDio = client;
    NetworkResponse networkResponse = NetworkResponse();
    DioException exception =
        DioException(requestOptions: RequestOptions(path: domain + pathURL));
    String token = await PreferenceProvider.getToken() ?? "";
    FormData formData = FormData();

    if (file != null) {
      String fileName = file.path.split('/').last;
      formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename: fileName),
      });
    }

    domain = domainURL ?? API.domain;

    CancelToken cancelToken = CancelToken();
    try {
      log("");
      log(domain + pathURL, "PUT");
      log(query.toString(), "Query Parameters");
      log("Bearer Token: $token");

      clientDio.options.headers;
      final response = await clientDio.put(
        domain + pathURL,
        data: body ?? formData,
        onSendProgress: (count, total) {
          if (kDebugMode) {
            print(count / total);
          }
        },
        cancelToken: cancelToken,
      );

      log(response.statusCode, "Status Code");
      log(response.data, "Response");

      networkResponse
        ..statusCode = response.statusCode
        ..body = response.data;
      return networkResponse;
    } on DioException catch (e) {
      exception = e;
      return networkResponse;
    } on TimeoutException catch (_) {
      // A timeout occurred.
    }
    networkResponse = processResponse(networkResponse, exception);

    networkResponse
      ..statusCode = 200
      ..body['res'] = 0;
    return networkResponse;
  }

  processResponse(NetworkResponse networkResponse, DioException exception) {
    if (networkResponse.statusCode != null) {
      if (networkResponse.statusCode! >= 200 &&
          networkResponse.statusCode! < 401) {
        networkResponse.isSuccess = true;
        networkResponse.message = "";
        return networkResponse;
      }
    }
    log("${exception.runtimeType} |--> $exception");
    // log(exception, "Exception <--|");
    if (DioExceptionType.values.contains(exception.type)) {
      networkResponse.networkEXC = NetworkException.noInternet;
      networkResponse.message = MessData.errorInternet;
      return networkResponse;
    }
    if (DioExceptionType.values.contains(exception.type)) {
      networkResponse.networkEXC = NetworkException.noServiceFound;
      networkResponse.message = MessData.noServiceFound;
      return networkResponse;
    }
    if (exception.type == DioExceptionType.badResponse) {
      networkResponse.networkEXC = NetworkException.invalidFormat;
      networkResponse.message = MessData.invalidFormat;
      return networkResponse;
    }
    if (exception.type == DioExceptionType.connectionTimeout ||
        exception.type == DioExceptionType.receiveTimeout ||
        exception.type == DioExceptionType.sendTimeout) {
      networkResponse.networkEXC = NetworkException.timeout;
      networkResponse.message = MessData.connectTimeout;
      return networkResponse;
    }
    // statusCode case token die
    if (networkResponse.statusCode == 401) {
      networkResponse.networkEXC = NetworkException.tokenDie;
      networkResponse.message = MessData.tokenDie;
      return networkResponse;
    }
    networkResponse.networkEXC = NetworkException.unknown;
    networkResponse.message = MessData.errorUnknown;
    return networkResponse;
  }
}
