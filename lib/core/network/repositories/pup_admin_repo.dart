// import 'dart:developer';
// import '../../constants/app_constants.dart';
// import '../api_clients/auth_api_client.dart';
// import '../api_result.dart';

// class PupAdminRepo {
//   final AuthApiClient _apiClient = AuthApiClient();

//   Future<ApiResult> orderKeys({
//     required int quantity,
//     required String terminalId,
//   }) async {
//     final data = {
//       "quantity": quantity,
//       "terminalId": terminalId,
//     };

//     return await _apiClient.post(Endpoints.orderKeys, data);
//   }

//   Future<ApiResult> orderKeysWithCredit({
//     required bool useCredits,
//     required String orderId,
//   }) async {
//     final data = {
//       "useCredits": useCredits,
//     };

//     return await _apiClient.post("${AppConstants.apiBaseUrl}/payment/orders/$orderId/checkout", data);
//   }

//   Future<ApiResult> updateTime({
//     required String pupAdminId,
//     required String terminalId,
//     required String day,
//     required String openTime,
//     required String closeTime,
//     required bool is24Hours ,
//   }) async {
//     final data = {
//       "pupAdminId": pupAdminId,
//       "terminalId": terminalId,
//       "openingHours": [
//         {
//           "dayOfWeek": day,
//           "openingTime": openTime,
//           "closingTime": closeTime,
//           "isHoliday": is24Hours,
//         },
//       ]
//     };

//     return await _apiClient.put(Endpoints.updateTime, data);
//   }
//  Future<ApiResult> sendWishlist({
//     required String userId,
//     required String suggestion,

//   }) async {
//     final data = {
//       "userId": userId,
//       "suggestion": suggestion,

//     };

//     return await _apiClient.post(Endpoints.suggestPlace, data);
//   }
//   Future<ApiResult> fetchPupStats({
//     required String terminalId,
//     required String period,
//     required String type,
//   }) async {
//     try {
//       final endpoint = '/terminals/terminals/$terminalId/statistics';
//       final queryParams = {
//         'period': period,
//         'type': type,
//       };

//       log("▶️ Fetching Stats: $endpoint?period=$period&type=$type");

//       return await _apiClient.get(
//         endpoint,
//         queryParams: queryParams,
//       );
//     } catch (e) {
//       log("❌ Error fetching stats: $e");
//       return Failure("Something went wrong: $e");
//     }
//   }
//   Future<ApiResult> checkoutKeys({
//     required String orderId,
//   }) async {
//     final body = {
//       'orderId': orderId,
//     };
//     return await _apiClient.post("${AppConstants.apiBaseUrl}/payment/orders/checkout",body);
//   }
//   Future<ApiResult> getLockers({
//     required String terminalId,
//   }) async {
//     return await _apiClient.get(
//       "${AppConstants.apiBaseUrl}/terminals/terminals/$terminalId/lockers",
//     );
//   }

//   Future<ApiResult> verifySession({
//     required String sessionId,
//   }) async {
//     return await _apiClient.get(
//       "${Endpoints.verifySession}$sessionId",
//       headers: {
//         // Uses the AuthApiClient interceptor token by default; add extra headers here if needed
//         // 'Authorization': 'Bearer yourToken',
//       },
//     );
//   }

//   //get credit

//   Future<ApiResult> getCreditBalance() async {
//     final result = await _apiClient.get(Endpoints.getCreditBalance);

//     if (result is Success) {
//       try {
//         final data = result.data;
//         log("Raw credit balance response: $data");
//         return result;
//       } catch (e) {
//         log("Failed to parse credit balance: $e");
//         return Failure("Failed to parse credit balance: $e");
//       }
//     } else if (result is Failure) {
//       log("API returned failure: ${result.error}");
//       return Failure(result.error);
//     }
//     log("Unknown error while fetching credit balance");
//     return Failure("Unknown error");
//   }

//   Future<ApiResult> requestPayout({
//     required String amount,
//     required String note,

//   }) async {
//     final data = {
//       "amount": amount,
//       "paymentMethod": "cash",
//       "notes": note


//     };

//     return await _apiClient.post(Endpoints.requestPayout, data);
//   }
// }