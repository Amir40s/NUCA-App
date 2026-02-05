import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:nuca/app/routes/app_pages.dart';
import 'package:nuca/services/app_log_service.dart';
import 'package:nuca/services/shared_preferences_service.dart';
import 'package:nuca/utils/app_constants.dart';
import '../api_result.dart';

class AuthApiClient {
  final Dio _dio;

  AuthApiClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: AppConstants.apiBaseUrl,
          connectTimeout: const Duration(seconds: 40),
          receiveTimeout: const Duration(seconds: 50),
          responseType: ResponseType.json,
        ),
      ) {
    _dio.interceptors.add(_AuthApiTokenInterceptor());
    _dio.interceptors.add(ApiLoggingInterceptor());
  }

  Options _mergeHeaders([Map<String, String>? headers]) {
    final defaultHeaders = {
      'Content-Type': Headers.jsonContentType,
      'Accept': 'application/json',
    };
    if (headers != null) defaultHeaders.addAll(headers);
    return Options(headers: defaultHeaders);
  }

  Failure _handleError(DioException error) {
    if (error.response != null) {
      final status = error.response?.statusCode ?? 0;
      final data = error.response?.data;
      log('API Error Status: $status | Response: $data');

      if (data is Map<String, dynamic> && data.containsKey('message')) {
        LogService.warning(data['message']);
        return Failure(data['message'], statusCode: status);
      } else if (data is String) {
        return Failure(data, statusCode: status);
      } else {
        return Failure(
          "Server error with status code $status",
          statusCode: status,
        );
      }
    } else {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return Failure("Connection Timeout");
        case DioExceptionType.receiveTimeout:
          return Failure("Receive Timeout");
        case DioExceptionType.badResponse:
          return Failure("Bad Response from server");
        default:
          return Failure("Unexpected error occurred");
      }
    }
  }

  Future<ApiResult<dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParams,
        options: _mergeHeaders(headers),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        LogService.info("GET $endpoint Success: ${response.data}");
        return Success(response.data);
      } else {
        return Failure(
          "GET $endpoint failed with status ${response.statusCode}",
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResult<dynamic>> post(
    String endpoint,
    dynamic data, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: jsonEncode(data),
        queryParameters: queryParameters,
        options: _mergeHeaders(headers),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        LogService.info("POST $endpoint Success: ${response.data}");
        return Success(response.data);
      } else {
        return Failure(
          "POST $endpoint failed with status ${response.statusCode}",
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResult<dynamic>> put(
    String endpoint,
    dynamic data, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    try {
      Options options = _mergeHeaders(headers);

      final response = await _dio.put(
        endpoint,
        data: data is FormData ? data : jsonEncode(data), // <-- fix here
        queryParameters: queryParams,
        options: options,
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        LogService.info("PUT $endpoint Success: ${response.data}");
        return Success(response.data);
      } else {
        return Failure(
          "PUT $endpoint failed with status ${response.statusCode}",
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResult<dynamic>> delete(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        data: data != null ? jsonEncode(data) : null,
        queryParameters: queryParams,
        options: _mergeHeaders(headers),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        LogService.info("DELETE $endpoint Success: ${response.data}");
        return Success(response.data);
      } else {
        return Failure(
          "DELETE $endpoint failed with status ${response.statusCode}",
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      return _handleError(e);
    }
  }
}

class _AuthApiTokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = SharedPreferencesService.getToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      SharedPreferencesService.clear();
      Get.offAllNamed(Routes.LOGIN);
    }
    handler.next(err);
  }
}

class ApiLoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('➡️ REQUEST');
    log('METHOD: ${options.method}');
    log('URL: ${options.baseUrl}${options.path}');
    log('HEADERS: ${options.headers}');
    log('QUERY PARAMS: ${options.queryParameters}');
    log('BODY: ${options.data}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('✅ RESPONSE');
    log('STATUS: ${response.statusCode}');
    log(
      'URL: ${response.requestOptions.baseUrl}${response.requestOptions.path}',
    );
    log('RESPONSE DATA: ${response.data}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('❌ ERROR');
    log('METHOD: ${err.requestOptions.method}');
    log('URL: ${err.requestOptions.baseUrl}${err.requestOptions.path}');
    log('STATUS: ${err.response?.statusCode}');
    log('ERROR DATA: ${err.response?.data}');
    handler.next(err);
  }
}
