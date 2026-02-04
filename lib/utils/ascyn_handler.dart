import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nuca/core/network/api_result.dart';
import 'package:nuca/utils/app_utils.dart';
import 'package:nuca/utils/async_state_handler.dart';

class AsyncHandler {
  static Future<Resource<T>> handleResourceCall<T>({
    required Future<ApiResult<T>> Function() asyncCall,
    BuildContext? context,
    String loadingMessage = "Loading...",
    bool showLoading = true,
    void Function()? onLoading,
    void Function(T data)? onSuccess,
    void Function(String message)? onError,
  }) async {
    try {
      if (showLoading) {
        if (onLoading != null) {
          onLoading();
        } else {
          EasyLoading.show(status: loadingMessage);
        }
      }

      final result = await asyncCall();

      if (showLoading && onLoading == null) EasyLoading.dismiss();

      if (result is Success<T>) {
        if (onSuccess != null) onSuccess(result.data);
        return Resource.success(data: result.data);
      } else if (result is Failure) {
        if (onError != null) {
          onError(result.message);
        } else if (context != null) {
          AppUtils.showMessage(context: context, result.message, isError: true);
        } else {
          debugPrint("Error: ${result.message}");
        }
        return Resource.error(message: result.message);
      } else {
        const unknownError = "Unknown error occurred";
        if (onError != null)
          onError(unknownError);
        else if (context != null)
          AppUtils.showMessage(context: context, unknownError, isError: true);
        else
          debugPrint("Error: $unknownError");
        return const Resource.error(message: unknownError);
      }
    } catch (e) {
      if (showLoading && onLoading == null) EasyLoading.dismiss();

      if (onError != null)
        onError(e.toString());
      else if (context != null)
        AppUtils.showMessage(context: context, e.toString(), isError: true);
      else
        debugPrint("Error: $e");

      return Resource.error(message: e.toString());
    }
  }
}
