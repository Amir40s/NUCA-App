import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:nuca/services/app_log_service.dart';
import 'package:nuca/services/shared_preferences_service.dart';
import 'package:flutter/foundation.dart';
import 'package:nuca/utils/app_constants.dart';
import '../api_result.dart';

class AppApiClient {
  final Dio _dio;

  AppApiClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: AppConstants.apiBaseUrl,
          connectTimeout: const Duration(seconds: 40),
          receiveTimeout: const Duration(seconds: 50),
        ),
      ) {
    _dio.interceptors.add(AuthInterceptor());
  }

  /// Handle API Errors
  Failure _handleError(DioException error) {
    if (error.response != null) {
      debugPrintThrottled('response error ======> ${error.response}');
      final responseData = error.response?.data;

      if (responseData is Map<String, dynamic> &&
          responseData.containsKey('message')) {
        LogService.warning(responseData['message']);
        return Failure(responseData['message']);
      } else if (responseData is String) {
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
  }) async {
    try {
      Response response = await _dio.get(
        endpoint,
        queryParameters: queryParams,
      );
      final data = response.data;
      if (data is Map<String, dynamic>) {
        print('status======> ${data['status']}');
      }
      LogService.info("✅ Response: \n $endpoint $data");

      return Success(response.data);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResult<dynamic>> post(
    String endpoint,
    dynamic data, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  }) async {
    try {
      Response response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParams,
        options: Options(headers: headers),
      );

      LogService.info("✅ POST Response: \n $endpoint ${response.data}");
      return Success(response.data);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResult<dynamic>> patch(String endpoint, dynamic data) async {
    try {
      Response response = await _dio.patch(endpoint, data: data);

      LogService.info("✅ PATCH Response: \n $endpoint ${response.data}");
      return Success(response.data);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  /// **PUT Request**
  Future<ApiResult<dynamic>> put(String endpoint, dynamic data) async {
    try {
      Response response = await _dio.put(endpoint, data: data);
      print('put status ======> ${response.data['status']}');
      LogService.info("✅ Response: \n $endpoint ${response.data}");

      return Success(response.data);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }
}

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String? token = await SharedPreferencesService.getAccessToken();

    if (token != null && token.isNotEmpty) {
      // Token is available
      options.headers['Authorization'] = 'Bearer $token';
      log("🔥 Token attached: $token");
    } else {
      // No token found
      log("❌ No token found, sending request without Authorization header");
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      String? refreshToken = await SharedPreferencesService.getRefreshToken();
      print('refresh token ======> $refreshToken');

      if (refreshToken != null) {
        try {
          final response = await Dio().post(
            "${AppConstants.apiBaseUrl}/auth/refresh-tokens",
            data: {"refreshToken": refreshToken},
            options: Options(contentType: Headers.jsonContentType),
          );

          LogService.debug('Refreshing tokens $refreshToken \n $response');

          if (response.statusCode == 200) {
            final newAccessToken = response.data["accessToken"];
            final newRefreshToken = response.data["refreshToken"];

            if (newAccessToken != null && newRefreshToken != null) {
              await SharedPreferencesService.saveLoginData(
                newAccessToken,
                newRefreshToken,
                err.requestOptions.headers['userId'],
              );

              LogService.info('New Tokens Saved Successfully');
              err.requestOptions.headers['Authorization'] =
                  'Bearer $newAccessToken';
              final retryResponse = await Dio().fetch(err.requestOptions);
              return handler.resolve(retryResponse);
            }
          }
        } catch (e) {
          LogService.info('Refreshing tokens $e');
          LogService.error("Token refresh failed", e);
        }
      }
    }
    return handler.next(err);
  }
}
