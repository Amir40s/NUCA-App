import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
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
        ),
      ) {
    _dio.interceptors.add(_AuthApiTokenInterceptor());
  }

  /// Handle API Errors
  Failure _handleError(DioException error) {
    if (error.response != null) {
      log('error response is ======> ${error.response}');
      final responseData = error.response?.data;

      if (responseData is Map<String, dynamic> &&
          responseData.containsKey('message')) {
        LogService.warning(responseData['message']);
        return Failure(responseData['message']);
      }
      // If responseData is not a Map, try extracting error text
      else if (responseData is String) {
        return Failure(responseData);
      }

      return Failure("An unknown server error occurred.");
    } else if (error.type == DioExceptionType.connectionTimeout) {
      return Failure("Connection Timeout. Please try again.");
    } else if (error.type == DioExceptionType.receiveTimeout) {
      return Failure("Receive Timeout. Please try again.");
    } else if (error.type == DioExceptionType.badResponse) {
      return Failure("Bad Response. Something went wrong.");
    } else {
      return Failure("Unexpected error. Please try again.");
    }
  }

  Future<ApiResult<dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final options = headers != null ? Options(headers: headers) : null;
      Response response = await _dio.get(
        endpoint,
        queryParameters: queryParams,
        options: options,
      );
      log('get status ======> ${response.data['status']}');
      LogService.info("✅ Response: \n $endpoint ${response.data}");

      return Success(response.data);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  /// **POST Request**
  Future<ApiResult<dynamic>> post(
    String endpoint,
    dynamic data, {
    Map<String, dynamic>? files,
  }) async {
    try {
      dynamic requestData;
      Options options = Options();
      requestData = jsonEncode(data);
      options.contentType = Headers.jsonContentType;
      Response response = await _dio.post(
        endpoint,
        data: requestData,
        options: options,
      );
      LogService.info("✅ Response: \n $endpoint ${response.data}");

      return Success(response.data);
    } on DioException catch (e) {
      LogService.error("❌ API Error: $endpoint", e, e.stackTrace);
      return _handleError(e);
    }
  }

  Future<ApiResult<dynamic>> postResendOtp(
    String endpoint,
    dynamic data, {
    Map<String, dynamic>? files,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      dynamic requestData = jsonEncode(data);

      Options options = Options(contentType: Headers.jsonContentType);

      Response response = await _dio.post(
        endpoint,
        data: requestData,
        queryParameters: queryParameters,
        options: options,
      );

      LogService.info("✅ Response: \n $endpoint ${response.data}");

      return Success(response.data);
    } on DioException catch (e) {
      LogService.error("❌ API Error: $endpoint", e, e.stackTrace);
      return _handleError(e);
    }
  }

  /// **PUT Request**
  Future<ApiResult<dynamic>> put(
    String endpoint,
    dynamic data, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final requestData = jsonEncode(data);
      final options = Options(contentType: Headers.jsonContentType);

      Response response = await _dio.put(
        endpoint,
        data: requestData,
        queryParameters: queryParams,
        options: options,
      );

      LogService.info("✅ PUT Response: \n $endpoint ${response.data}");
      return Success(response.data);
    } on DioException catch (e) {
      LogService.error("❌ PUT API Error: $endpoint", e, e.stackTrace);
      return _handleError(e);
    }
  }

  /// **DELETE Request**
  Future<ApiResult<dynamic>> delete(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    dynamic data,
  }) async {
    try {
      final requestData = data != null ? jsonEncode(data) : null;
      final options = Options(contentType: Headers.jsonContentType);

      Response response = await _dio.delete(
        endpoint,
        data: requestData,
        queryParameters: queryParams,
        options: options,
      );

      LogService.info("✅ DELETE Response: \n $endpoint ${response.data}");
      return Success(response.data);
    } on DioException catch (e) {
      LogService.error("❌ DELETE API Error: $endpoint", e, e.stackTrace);
      return _handleError(e);
    }
  }
}

class _AuthApiTokenInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await SharedPreferencesService.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }
}
