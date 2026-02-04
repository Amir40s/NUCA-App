import 'package:nuca/domain/model/scan_history_model.dart';
import 'package:nuca/utils/app_constants.dart';
import '../api_clients/auth_api_client.dart';
import '../api_result.dart';

class UserRepo {
  final AuthApiClient _authApi;

  UserRepo({AuthApiClient? authApiClient})
    : _authApi = authApiClient ?? AuthApiClient();

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
}
