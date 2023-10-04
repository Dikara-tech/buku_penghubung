import 'package:dio/dio.dart';

class ErrorInterceptor extends QueuedInterceptorsWrapper {
  @override
  Future<void> onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    // check if data is map with zero data and make it null
    if (response.data is Map<String, dynamic>) {
      final dynamic data = (response.data as Map<String, dynamic>)['data'];
      if (data != null && data is Map<String, dynamic> && data.isEmpty) {
        final newResponse = response.data as Map<String, dynamic>;
        newResponse['data'] = null;

        return handler.next(Response<dynamic>(
          requestOptions: response.requestOptions,
          data: newResponse,
          statusCode: response.statusCode,
          statusMessage: response.statusMessage,
          extra: response.extra,
          isRedirect: response.isRedirect,
          headers: response.headers,
          redirects: response.redirects,
        ));
      }
    }
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (((err.response?.data is Map<String, dynamic>) &&
            (err.response?.data as Map<String, dynamic>)['code'] == null) ||
        err.response?.statusCode == 403) {
      return handler.next(DioException(
        requestOptions: err.requestOptions,
        error: 404,
        message: 'Internal server error, please contact our customer support',
        response: Response<Map<String, dynamic>>(
          requestOptions: err.requestOptions,
          data: <String, dynamic>{
            'code': 404,
            'message':
                'Internal server error, please contact our customer support',
          },
        ),
      ));
    }

    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionTimeout) {
      return handler.next(DioException(
        requestOptions: err.requestOptions,
        error: 5002,
        message: 'Connection timeout, please try again',
        response: Response<Map<String, dynamic>>(
          requestOptions: err.requestOptions,
          data: <String, dynamic>{
            'code': 5005,
            'message': 'Connection timeout, please try again',
          },
        ),
      ));
    }
    if (err.response?.data is Map<String, dynamic>) {
      final dynamic data = (err.response?.data as Map<String, dynamic>)['data'];

      if (data != null &&
          data is Map<String, dynamic> &&
          data.isNotEmpty &&
          data['message'] != null &&
          data['message'] is String?) {
        return handler.next(DioException(
          requestOptions: err.requestOptions,
          error: 5002,
          message: data['message'] as String? ??
              'Internal server error, please contact our customer support',
          response: Response<Map<String, dynamic>>(
            requestOptions: err.requestOptions,
            data: <String, dynamic>{
              'code': 5005,
              'message': data['message'] as String? ??
                  'Internal server error, please contact our customer support',
            },
          ),
        ));
      }
    }

    return handler.next(err);
  }
}
