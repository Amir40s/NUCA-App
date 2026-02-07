import 'package:nuca/services/shared_preferences_service.dart';
import 'package:nuca/utils/app_constants.dart';
import '../api_clients/auth_api_client.dart';
import '../api_result.dart';

class AuthRepository {
  final AuthApiClient _authApi;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthRepository({AuthApiClient? authApiClient})
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

  Future<ApiResult<dynamic>> selectPreference({
    required String deviceId,
    required String country,
    required String currency,
  }) async {
    final data = {
      "currency": currency,
      "deviceId": deviceId,
      "country": country,
    };

    final result = await _authApi.post(Endpoints.selectPreferences, data);

    if (result is Success) {
      return Success(result.data);
    } else if (result is Failure) {
      return Failure(result.message, statusCode: result.statusCode);
    } else {
      return Failure("Unexpected error");
    }
  }

  Future<ApiResult<dynamic>> loginWithGoogle({
    required String name,
    required String email,
    required bool isLogin,
    required String profileImage,
    required String currency,
    required String country,
  }) async {
    final data = {
      "isLogin": isLogin,
      "profileImage": profileImage,
      "email": email,
      "name": name,
      "currency": currency,
      "country": country,
    };

    final result = await _authApi.post(Endpoints.googleLogin, data);
    if (result is Success) {
      await _storeTokenIfExists(result.data);
      return Success(result.data);
    } else if (result is Failure) {
      return Failure(result.message, statusCode: result.statusCode);
    } else {
      return Failure("Unexpected error");
    }
  }

  Future<ApiResult<dynamic>> login({
    required String email,
    required String password,
  }) async {
    final data = {"email": email, "password": password};

    final result = await _authApi.post(Endpoints.login, data);

    if (result is Success) {
      await _storeTokenIfExists(result.data);
      return Success(result.data);
    } else if (result is Failure) {
      return Failure(result.message, statusCode: result.statusCode);
    } else {
      return Failure("Unexpected error");
    }
  }

  Future<ApiResult<dynamic>> signUp({
    required String name,
    required String email,
    required String currency,
    required String country,
    required String password,
  }) async {
    final data = {
      "name": name,
      "email": email,
      "password": password,
      "currency": currency,
      "country": country,
    };

    final result = await _authApi.post(Endpoints.sigUp, data);

    if (result is Success) {
      await _storeTokenIfExists(result.data);
      return Success(result.data);
    } else if (result is Failure) {
      return Failure(result.message, statusCode: result.statusCode);
    } else {
      return Failure("Unexpected error");
    }
  }
}
