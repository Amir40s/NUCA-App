import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:nuca/domain/model/scan_detail_model.dart';
import 'package:nuca/domain/model/scan_history_model.dart';
import 'package:nuca/services/shared_preferences_service.dart';
import 'package:nuca/utils/app_constants.dart';
import '../api_clients/auth_api_client.dart';
import '../api_result.dart';

class UserRepo {
  final AuthApiClient _authApi;

  UserRepo({AuthApiClient? authApiClient})
    : _authApi = authApiClient ?? AuthApiClient();

  Future<void> _storeTokenIfExists(dynamic responseData) async {
    if (responseData is Map<String, dynamic>) {
      final data = responseData['data'];

      if (data is Map<String, dynamic>) {
        final token = data['token'];

        if (token is String && token.isNotEmpty) {
          await SharedPreferencesService.saveAccessToken(token);
        }
      }
    }
  }

  Future<ApiResult<ScanHistoryModel>> getScans({
    required String deviceId,
  }) async {
    final result = await _authApi.get(
      Endpoints.getScans,
      queryParams: {"deviceId": deviceId},
    );
    if (result is Success) {
      final scanHistory = ScanHistoryModel.fromJson(
        result.data as Map<String, dynamic>,
      );
      return Success(scanHistory);
    } else if (result is Failure) {
      return Failure(result.message, statusCode: result.statusCode);
    } else {
      return Failure("Unexpected error");
    }
  }

  Future<ApiResult<ProductResponseModel>> getScanDetails({
    required String barcode,
  }) async {
    final result = await _authApi.post(Endpoints.getScanDetails, {
      "barcode": barcode,
    });
    if (result is Success) {
      final scanHistory = ProductResponseModel.fromJson(
        result.data as Map<String, dynamic>,
      );
      return Success(scanHistory);
    } else if (result is Failure) {
      return Failure(result.message, statusCode: result.statusCode);
    } else {
      return Failure("Unexpected error");
    }
  }

  Future<ApiResult<dynamic>> createScan({required String barcode}) async {
    final result = await _authApi.post(Endpoints.createScan, {
      "barcode": barcode,
    });
    if (result is Success) {
      return Success(result.data);
    } else if (result is Failure) {
      return Failure(result.message, statusCode: result.statusCode);
    } else {
      return Failure("Unexpected error");
    }
  }

  Future<ApiResult<dynamic>> updateProfile({
    required String name,
    String? profileImagePath,
  }) async {
    try {
      final Map<String, dynamic> formDataMap = {'name': name};

      if (profileImagePath != null && profileImagePath.isNotEmpty) {
        final file = await MultipartFile.fromFile(
          profileImagePath,
          filename: profileImagePath.split('/').last,
        );
        formDataMap['profileImage'] = file;
        log("✅ Profile image attached: ${file.filename}");
      } else {
        log("⚠️ No profile image provided.");
      }

      final formData = FormData.fromMap(formDataMap);

      // Log FormData keys before sending
      log("➡️ Sending FormData:");
      formDataMap.forEach((key, value) {
        if (value is MultipartFile) {
          log(" - $key: MultipartFile(${value.filename})");
        } else {
          log(" - $key: $value");
        }
      });

      final result = await _authApi.put(
        Endpoints.updateProfile,
        formData,
        headers: {
          'Content-Type': 'multipart/form-data',
          'Authorization': 'Bearer ${SharedPreferencesService.getToken()}',
        },
      );

      log("✅ API call completed: ${result.runtimeType}");
      if (result is Success) {
        log("📦 Response data: ${result.data}");
        await _storeTokenIfExists(result.data);
        return Success(result.data);
      } else if (result is Failure) {
        log("❌ API Failure: ${result.message}, Status: ${result.statusCode}");
        return Failure(result.message, statusCode: result.statusCode);
      } else {
        log("⚠️ Unexpected result type: ${result.runtimeType}");
        return Failure("Unexpected error");
      }
    } catch (e, stack) {
      log("🔥 Exception in updateProfile: $e");
      log(stack.toString());
      return Failure("Failed to prepare form data: $e");
    }
  }
}
