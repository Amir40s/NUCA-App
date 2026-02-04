// import 'dart:developer';

// import 'package:easykey/core/models/user_model.dart';

// import '../../constants/app_constants.dart';
// import '../api_clients/app_api_client.dart';
// import '../api_result.dart';

// class TerminalsRepository {
//   final AppApiClient _apiClient = AppApiClient();

//   Future<ApiResult<List<UserTerminalModel>>> getAllTerminals() async {
//     final result = await _apiClient.get(Endpoints.allTerminals);

//     if (result is Success) {
//       try {
//         final data = result.data;
//         log("Raw terminals response: $data");

//         if (data is List) {
//           final terminals =
//           data.map((e) => UserTerminalModel.fromJson(e)).toList();
//           for (var t in terminals) {
//             log("Parsed Terminal: ${t.status}");
//           }
//           return Success(terminals);
//         } else {
//           log("Unexpected data format: ${data.runtimeType}");

//           return Failure("Unexpected data format");
//         }
//       } catch (e) {
//         return Failure("Failed to parse terminals: $e");
//       }
//     } else if (result is Failure) {
//       log("API returned failure: ${result.error}");
//       return Failure(result.error);
//     }
//     log("Unknown error while fetching terminals");
//     return Failure("Unknown error");
//   }
//   Future<ApiResult<List<UserTerminalModel>>> getTerminalsById(String id) async {
//     final result = await _apiClient.get("${AppConstants.apiBaseUrl}/terminals/terminals/$id");

//     if (result is Success) {
//       try {
//         final data = result.data;
//         log("Raw terminals response by id is: $data");

//         if (data is Map<String, dynamic>) {
//           // API returned a single terminal object
//           final terminal = UserTerminalModel.fromJson(data);
//           log("Parsed Terminal: ${terminal.name}");
//           return Success([terminal]); // wrap in list for consistency
//         } else if (data is List) {
//           // API returned a list of terminals (if ever)
//           final terminals = data.map((e) => UserTerminalModel.fromJson(e)).toList();
//           for (var t in terminals) {
//             log("Parsed Terminal: ${t.name}");
//           }
//           return Success(terminals);
//         } else {
//           log("Unexpected data format: ${data.runtimeType}");
//           return Failure("Unexpected data format");
//         }
//       } catch (e) {
//         log("Failed to parse terminals: $e");
//         return Failure("Failed to parse terminals: $e");
//       }
//     } else if (result is Failure) {
//       log("API returned failure: ${result.error}");
//       return Failure(result.error);
//     }

//     log("Unknown error while fetching terminals");
//     return Failure("Unknown error");
//   }
//  Future<ApiResult<List<UserTerminalModel>>> getNearestTerminalsById(String latitude,longitude,limit) async {
//     final result = await _apiClient.get("${AppConstants.apiBaseUrl}/terminals/nearest?latitude=$latitude&longitude=$longitude&limit=$limit");
//     if (result is Success) {
//       try {
//         final data = result.data;
//         log("Raw terminals response by id is: $data");

//         if (data is Map<String, dynamic>) {
//           // API returned a single terminal object
//           final terminal = UserTerminalModel.fromJson(data);
//           log("Parsed Terminal: ${terminal.name}");
//           return Success([terminal]); // wrap in list for consistency
//         } else if (data is List) {
//           // API returned a list of terminals (if ever)
//           final terminals = data.map((e) => UserTerminalModel.fromJson(e)).toList();
//           for (var t in terminals) {
//             log("Parsed Terminal: ${t.name}");
//           }
//           return Success(terminals);
//         } else {
//           log("Unexpected data format: ${data.runtimeType}");
//           return Failure("Unexpected data format");
//         }
//       } catch (e) {
//         log("Failed to parse terminals: $e");
//         return Failure("Failed to parse terminals: $e");
//       }
//     } else if (result is Failure) {
//       log("API returned failure: ${result.error}");
//       return Failure(result.error);
//     }

//     log("Unknown error while fetching terminals");
//     return Failure("Unknown error");
//   }



// }