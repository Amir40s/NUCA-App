// import 'package:easykey/core/constants/app_constants.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// import '../api_clients/auth_api_client.dart';
// import '../api_result.dart';

// class AuthRepository {
//   final AuthApiClient _authApi;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();

//   AuthRepository({AuthApiClient? authApiClient}) : _authApi = authApiClient ?? AuthApiClient();

//   Future<ApiResult> signUp({
//     required String name,
//     required String email,
//     required String password,
//     required String phoneNumber,
//     required String fcmToken,

//   }) async {
//     final data = {
//       "name": name,
//       "email": email,
//       "password": password,
//       "phoneNumber": phoneNumber,
//       "fcmToken": fcmToken,
//     };

//     return await _authApi.post(Endpoints.signUp, data);
//   }

//   Future<ApiResult> sendOtp({
//     required String phoneNumber,
//     required String email,
//   }) async {
//     final data = {"phoneNumber": phoneNumber,"email" : email};

//     return await _authApi.post(Endpoints.sendOtp, data);
//   }

//   Future<ApiResult> verifyOtp({
//     required String phoneNumber,
//     required String otp,
//   }) async {
//     final data = {"otp": otp, "phoneNumber": phoneNumber};

//     return await _authApi.post(Endpoints.verifyOtp, data);
//   }

//   Future<ApiResult> sendOtpToChip({
//     required String phoneNumber,
//   }) async {
//     final data = {"phoneNumber": phoneNumber,};

//     return await _authApi.post(Endpoints.sendOtpToChip, data);
//   }

//   Future<ApiResult> login({
//     required String email,
//     required String password,
//     required String fcmToken,
//   }) async {
//     final data = {
//       "email": email,
//       "password": password,
//       "fcmToken" :fcmToken
//     };

//     return await _authApi.post(Endpoints.login, data);
//   }

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
// }
