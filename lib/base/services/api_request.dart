part of base;

class ApiRequest {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );
  static final Map<String, ApiRequest> _dioLogger = <String, ApiRequest>{};

  factory ApiRequest() {
    return _dioLogger.putIfAbsent('dio', () => ApiRequest._internal());
  }
  ApiRequest._internal() {
    _dio.interceptors.add(HeaderInterceptor());
    _dio.interceptors.add(ErrorInterceptor());
  }

  ApiRequest.callback({
    required int status,
    required String message,
    required Function function,
  }) {
    if (status == 0 || status == 1 || (status >= 200 && status < 400)) {
      function();
    } else {
      NetworkErrorMessage.snakebar(
        status: status,
        message: message,
      );
    }
  }

  Future<Response> get(
    String url, {
    dynamic data,
  }) {
    return _dio.get(
      url,
      data: data,
    );
  }

  Future<Response> post(
    String url, {
    dynamic data,
  }) {
    return _dio.post(
      url,
      data: data,
    );
  }

  Future<Response> put(
    String url, {
    dynamic data,
  }) {
    return _dio.put(
      url,
      data: data,
    );
  }

  Future<Response> delete(
    String url, {
    dynamic data,
  }) {
    return _dio.delete(
      url,
      data: data,
    );
  }
}

class HeaderInterceptor extends Interceptor {
  @override
  onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    if (!options.headers.containsKey('Content-Type')) {
      options.headers['Content-Type'] = 'application/json; charset=utf-8';
    }

    super.onRequest(options, handler);
  }
}

class ErrorInterceptor extends Interceptor {
  @override
  onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    Map<String, dynamic> apiError = _apiException(error: err);

    Storage storage = Storage();
    List<String> networkError = storage.get('networkError') ?? [];

    storage.set('networkError', [
      ...networkError,
      '${apiError['code']} ${err.requestOptions.path} ${apiError['message']}',
    ]);
    NetworkErrorMessage.snakebar(
      status: apiError['code'],
      message: apiError['message'],
    );
  }

  Map<String, dynamic> _apiException({
    DioException? error,
  }) {
    switch (error!.type) {
      case DioExceptionType.cancel:
        return {'code': -1, 'message': '请求取消'};
      case DioExceptionType.connectionTimeout:
        return {'code': -1, 'message': '连接超时'};
      case DioExceptionType.sendTimeout:
        return {'code': -1, 'message': '请求超时'};
      case DioExceptionType.receiveTimeout:
        return {'code': -1, 'message': '响应超时'};
      case DioExceptionType.badResponse:
        try {
          int? errCode = error.response!.statusCode;
          switch (errCode) {
            case 400:
              return {'code': errCode, 'message': '请求语法错误'};
            case 401:
              return {'code': errCode, 'message': '没有权限'};
            case 403:
              return {'code': errCode, 'message': '服务器拒绝执行'};
            case 404:
              return {'code': errCode, 'message': '无法连接服务器'};
            case 405:
              return {'code': errCode, 'message': '请求方法被禁止'};
            case 500:
              return {'code': errCode, 'message': '服务器内部错误'};
            case 502:
              return {'code': errCode, 'message': '无效的请求'};
            case 503:
              return {'code': errCode, 'message': '服务器挂了'};
            case 505:
              return {'code': errCode, 'message': '不支持HTTP协议请求'};
            default:
              return {
                'code': errCode,
                'message': error.response!.statusMessage!
              };
          }
        } on Exception catch (_) {
          return {'code': -1, 'message': '未知错误'};
        }
      default:
        return {'code': -1, 'message': error.error};
    }
  }
}

class NetworkErrorMessage {
  NetworkErrorMessage.snakebar({
    required int status,
    required String message,
  }) {
    getx.Get.snackbar(
      '网络提示',
      '$message（$status）',
      backgroundColor: Colors.black87,
      colorText: Colors.white,
      duration: const Duration(seconds: 5),
      icon: const Icon(
        Icons.error_outline,
        color: Colors.white,
        size: 26,
      ),
      mainButton: TextButton(
        child: const Text(
          '隐藏',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () => getx.Get.back(),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      snackPosition: getx.SnackPosition.BOTTOM,
      onTap: (snack) => getx.Get.back(),
    );
  }
}
