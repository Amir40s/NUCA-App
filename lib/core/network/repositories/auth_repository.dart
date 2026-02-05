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
    required String deviceId,
    required bool isLogin,
  }) async {
    final data = {
      "isLogin": isLogin,
      "deviceId": deviceId,
      "email": email,
      "name": name,
    };

    final result = await _authApi.post(Endpoints.googleLogin, data);
    if (result is Success) {
      return Success(result.data);
    } else if (result is Failure) {
      return Failure(result.message, statusCode: result.statusCode);
    } else {
      return Failure("Unexpected error");
    }
  }

  // Future<ApiResult> sendOtp({
  //   required String phoneNumber,
  //   required String email,
  // }) async {
  //   final data = {"phoneNumber": phoneNumber,"email" : email};

  //   return await _authApi.post(Endpoints.sendOtp, data);
  // }

  // Future<ApiResult> verifyOtp({
  //   required String phoneNumber,
  //   required String otp,
  // }) async {
  //   final data = {"otp": otp, "phoneNumber": phoneNumber};

  //   return await _authApi.post(Endpoints.verifyOtp, data);
  // }

  // Future<ApiResult> sendOtpToChip({
  //   required String phoneNumber,
  // }) async {
  //   final data = {"phoneNumber": phoneNumber,};

  //   return await _authApi.post(Endpoints.sendOtpToChip, data);
  // }

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
    required String deviceId,
    required String email,
    required String password,
  }) async {
    final data = {
      "deviceId": deviceId,
      "name": name,
      "email": email,
      "password": password,
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

  //   Future<ApiResult> resendOtp({
  //     required String email,
  //   }) async {
  //     return await _authApi.postResendOtp(Endpoints.resendOtp, {},
  //         queryParameters: {'email': email});
  //   }
  // // google login

  //   Future<ApiResult> loginGoogle({
  //     required String idToken,
  //   }) async {
  //     final data = {
  //       "idToken": idToken,
  //     };

  //     return await _authApi.post(Endpoints.googleLogin, data);
  //   }
  //   Future<ApiResult> continueWithGoogle() async {

  //     try{
  //       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //       final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth.accessToken,
  //         idToken: googleAuth.idToken,
  //       );
  //       // Assuming you want to sign in with Firebase as well
  //       await FirebaseAuth.instance.signInWithCredential(credential);

  //       if (googleAuth.idToken != null) {
  //         return Success(googleAuth.idToken);
  //       } else {
  //         return Failure("Google ID Token is null");
  //       }

  //     }catch(e){
  //       print(e);
  //       return Failure(e.toString());
  //     }
  //   }
  //   Future<ApiResult> checkUser({
  //     required String email,
  //   }) async {
  //     final data = {
  //       "email": email,
  //     };

  //     return await _authApi.post(Endpoints.checkUser, data);
  //   }

  //   Future<ApiResult> checkUserByEmail({required String email}) async {
  //     final data = {
  //       "email": email,
  //     };
  //     return await _authApi.post(Endpoints.checkUser, data);
  //   }

  //   //get current user data
  //   Future<ApiResult> fetchCurrentUser({
  //     required String id,
  //   }) async {

  //     return await _authApi.get('${AppConstants.apiBaseUrl}/users/$id',);
  //   }  Future<ApiResult> fetchGoogleCurrentUser({
  //     required String id,
  //   }) async {

  //     return await _authApi.get('${AppConstants.apiBaseUrl}/users/v1/$id',);
  //   }
}
