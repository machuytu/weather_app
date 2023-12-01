enum NetworkException {
  noInternet,
  noServiceFound,
  invalidFormat,
  timeout,
  unknown,
  tokenDie,
  nO
}

class NetworkResponse<T> {
  bool isSuccess;
  int? statusCode;
  T? body;
  NetworkException? networkEXC;
  String? message;
  NetworkResponse({
    this.isSuccess = false,
    this.statusCode,
    this.body,
    this.networkEXC = NetworkException.nO,
    this.message,
  });
}
