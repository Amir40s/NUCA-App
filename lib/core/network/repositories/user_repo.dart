import 'dart:developer';
import '../../constants/app_constants.dart';
import '../api_clients/app_api_client.dart';
import '../api_clients/auth_api_client.dart';
import '../api_result.dart';

class UserRepo {
  final AppApiClient _apiClient = AppApiClient();
  final AuthApiClient _authClient = AuthApiClient();

  Future<ApiResult> fetchUserKeys({
    required String userId,
  }) async {
    try {
      const endpoint = '/keys/assigned';
      final query = {'userId': userId};
      final fullUrl = 'https://13.60.27.4$endpoint?userId=$userId';

      log("▶️ Fetching User Keys: $fullUrl");

      return await _apiClient.get(
        endpoint,
        queryParams: query,
      );
    } catch (e) {
      log("❌ Error fetching keys: $e");
      return Failure("Something went wrong: $e");
    }
  }

  Future<ApiResult> fetchUserNotifcations({
    required String userId,
  }) async {
    try {
      const endpoint = '/test/notifications';
      final query = {'userId': userId};
      final fullUrl = 'https://13.60.27.4$endpoint?userId=$userId';
      log("▶️ Fetching User Keys: $fullUrl");

      return await _apiClient.get(
        endpoint,
        queryParams: query,
      );
    } catch (e) {
      log("❌ Error fetching keys: $e");
      return Failure("Something went wrong: $e");
    }
  }

  Future<ApiResult> fetchUserKeyEvents({
    required String keyId,
  }) async {
    try {
      const endpoint = '/keys/activity-logs/details';
      final query = {'keyId': keyId};
      final fullUrl = 'https://13.60.27.4$endpoint?keyId=$keyId';

      log("▶️ Fetching User Keys: $fullUrl");

      return await _apiClient.get(
        endpoint,
        queryParams: query,
      );
    } catch (e) {
      log("❌ Error fetching keys: $e");
      return Failure("Something went wrong: $e");
    }
  }

  Future<ApiResult> updateKeyName({
    required String keyId,
    required String userId,
    required String keyName,
  }) async {
    try {
      final endpoint = Endpoints.updateKeyName;

      final body = {
        "keyId": keyId,
        "userId": userId,
        "keyName": keyName,
      };

      log("✏️ Updating Key Name: $body");
      log("📡 Sending PATCH to: $endpoint");

      return await _apiClient.patch(
        endpoint,
        body,
      );
    } catch (e) {
      log("❌ Error updating key name: $e");
      return Failure("Something went wrong: $e");
    }
  }

  Future<ApiResult> updateUserProfile({
    required String userId,
    required String avatar,
  }) async {
    try {
      final endpoint = Endpoints.updateProfile;
      final body = {
        "userId": userId,
        "avatarUrl": avatar,
      };

      log("✏️ Updating User Profile: $body");
      log("📡 Sending PATCH to: $endpoint");

      return await _apiClient.patch(
        endpoint,
        body,
      );
    } catch (e) {
      log("❌ Error updating profile: $e");
      return Failure("Something went wrong: $e");
    }
  }

  Future<ApiResult> updateUserInfo({
    String? userId,
    String? name,
    String? email,
  }) async {
    try {
      final endpoint = Endpoints.updateProfileInfo;

      final body = {
        "userId": userId,
        "name": name,
        "email": email,
      };

      log("✏️ Updating Key Name: $body");
      log("📡 Sending PATCH to: $endpoint");

      return await _apiClient.patch(
        endpoint,
        body,
      );
    } catch (e) {
      log("❌ Error updating key name: $e");
      return Failure("Something went wrong: $e");
    }
  }

  Future<ApiResult> updateLocation({
    String? phoneNumber,
    String? latitude,
    String? longitude,
  }) async {
    try {
      final endpoint = Endpoints.updateLocation;

      final body = {
        "phoneNumber": phoneNumber,
        "latitude": latitude,
        "longitude": longitude
      };

      return await _apiClient.patch(
        endpoint,
        body,
      );
    } catch (e) {
      log("❌ Error updating key name: $e");
      return Failure("Something went wrong: $e");
    }
  }

  Future<ApiResult> deactivateKey({
    required String keyCode,
    required String userId,
  }) async {
    try {
      final endpoint = Endpoints.deactivateKey;

      final body = {
        "keyCode": keyCode,
        "userId": userId,
      };

      log("✏️ Updating Key Name: $body");
      log("📡 Sending PATCH to: $endpoint");

      return await _apiClient.patch(
        endpoint,
        body,
      );
    } catch (e) {
      log("❌ Error updating key name: $e");
      return Failure("Something went wrong: $e");
    }
  }
  Future<ApiResult> activateKey({
    required String keyCode,
    required String userId,
  }) async {
    try {
      final endpoint = Endpoints.activateKey;

      final body = {
        "keyCode": keyCode,
        "userId": userId,
      };

      log("✏️ Updating Key Name: $body");
      log("📡 Sending PATCH to: $endpoint");

      return await _apiClient.patch(
        endpoint,
        body,
      );
    } catch (e) {
      log("❌ Error updating key name: $e");
      return Failure("Something went wrong: $e");
    }
  }

  Future<ApiResult> transferOwnership({
    required String keyCode,
    required String userId,
    required String newUserPhoneNumber,
  }) async {
    try {
      final endpoint = Endpoints.transferOwnership;

      final body = {
        "keyCode": keyCode,
        "currentUserId": userId,
        'newUserPhoneNumber': newUserPhoneNumber
      };

      log("✏️ Updating  Name: $body");
      log("📡 Sending PATCH to: $endpoint");

      return await _apiClient.patch(
        endpoint,
        body,
      );
    } catch (e) {
      log("❌ Error updating : $e");
      return Failure("Something went wrong: $e");
    }
  }

  Future<ApiResult> updatePassword({
    required String currentPassword,
    required String userId,
    required String newPassword,
  }) async {
    try {
      final endpoint = Endpoints.updatePassword;

      final body = {
        "currentPassword": currentPassword,
        "userId": userId,
        'newPassword': newPassword
      };

      log("✏️ Updating  Name: $body");
      log("📡 Sending PATCH to: $endpoint");

      return await _apiClient.patch(
        endpoint,
        body,
      );
    } catch (e) {
      log("❌ Error updating : $e");
      return Failure("Something went wrong: $e");
    }
  }


  Future<ApiResult> shareAcc({
    required String currentPhoneNumber,
    required String newPhoneNumber,
    required String token,
  }) async {
    final data = {
      "currentPhoneNumber": currentPhoneNumber,
      "newPhoneNumber": newPhoneNumber,
    };

    return await _apiClient.post(
      Endpoints.shareAcc,
      data,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );
  }

  Future<ApiResult> deleteAcc({
    required String userId,
  }) async {
    final data = {
      "userId": userId,
    };

    return await _authClient.delete(
      Endpoints.deleteAcc,
      data: data,
    );
  }

  Future<ApiResult> keyPickUp({
    required String keyCode,
    required String terminalId,
  }) async {
    try {
      final endpoint = Endpoints.pickKey;

      final body = {
        "keyCode": keyCode,
        "terminalId": terminalId,
      };

      return await _apiClient.patch(
        endpoint,
        body,
      );
    } catch (e) {
      log("❌ Error updating : $e");
      return Failure("Something went wrong: $e");
    }
  }

  Future<ApiResult> keyDropOff({
    required String keyCode,
    required String terminalId,
  }) async {
    try {
      final endpoint = Endpoints.dropKey;

      final body = {
        "keyCode": keyCode,
        "terminalId": terminalId,
      };

      log("✏️ Updating  Name: $body");
      log("📡 Sending PATCH to: $endpoint");

      return await _apiClient.patch(
        endpoint,
        body,
      );
    } catch (e) {
      log("❌ Error updating : $e");
      return Failure("Something went wrong: $e");
    }
  }

  Future<ApiResult> forgetPassOtp({
    required String newPhoneNumber,
  }) async {
    final data = {
      "phoneNumber": newPhoneNumber,
    };

    return await _apiClient.post(
      Endpoints.forgetPassOtp,
      data,
    );
  }

  Future<ApiResult> verifyForgetPassOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    final data = {
      "phoneNumber": phoneNumber,
      "otp": otp,
    };

    return await _apiClient.post(
      Endpoints.forgetPassOtpVerify,
      data,
    );
  }

  Future<ApiResult> resetPassword({
    required String phoneNumber,
    required String otp,
    required String newPassword,
  }) async {
    final data = {
      "phoneNumber": phoneNumber,
      "otp": otp,
      "newPassword": newPassword,
    };

    return await _apiClient.post(
      Endpoints.resetPass,
      data,
    );
  }

  //user subscription
  Future<ApiResult> createSubscription({
    required String plan,
    required String keyId,
  }) async {
    final data = {"plan": plan,"keyId":keyId};

    return await _apiClient.post(
      Endpoints.createSubscription,
      data,
    );
  } //user subscription

  Future<ApiResult> createCustomer() async {
    return await _apiClient.post(Endpoints.createCustomer, '');
  } //user subscription

  Future<ApiResult> createSetupIntent({
    required String customerId,
  }) async {
    final data = {"customerId": customerId};

    return await _apiClient.post(
      Endpoints.createSetupIntent,
      data,
    );
  } //user subscription

  Future<ApiResult> attachPaymentMethod({
    required String paymentMethodId,
    required String customerId,
  }) async {
    final data = {"paymentMethodId": paymentMethodId, "customerId": customerId};

    return await _apiClient.post(
      Endpoints.attachPaymentMethod,
      data,
    );
  }
  //updatePaymentMethod
  Future<ApiResult> updatePaymentMethod({
    required String paymentMethodId,
  }) async {
    final data = {"paymentMethodId": paymentMethodId,};

    return await _apiClient.post(
      Endpoints.updatePaymentMethod,
      data,
    );
  }
  //buyFixedPickUpCode
  Future<ApiResult> buyFixedPickUpCode({
    required String keyId,
    required String customCode,
  }) async {
    final data = {"keyId": keyId,"customCode": customCode,};

    return await _apiClient.post(
      Endpoints.fixedPickUpCode,
      data,
    );
  }

  //current user subscription
  Future<ApiResult> currentSubscription() async {
    try {
      return await _apiClient.get(
        Endpoints.currentSubscription,
      );
    } catch (e) {
      log("❌ Error fetching keys: $e");
      return Failure("Something went wrong: $e");
    }
  }Future<ApiResult> subscriptionHistory() async {
    try {
      return await _apiClient.get(
        Endpoints.subscriptionHistory,
      );
    } catch (e) {
      log("❌ Error fetching keys: $e");
      return Failure("Something went wrong: $e");
    }
  }


  //enable/disable notifications
  Future<ApiResult> userNotificationsEnable({
    required String userId,
    required bool status,
  }) async {
    try {
      final endpoint = Endpoints.userNotificationEnable;

      final body = {
        "userId": userId,
        "status": status,
      };


      return await _apiClient.patch(
        endpoint,
        body,
      );
    } catch (e) {
      log("❌ Error updating : $e");
      return Failure("Something went wrong: $e");
    }
  } Future<ApiResult> userEmailNotificationsEnable({
    required String userId,
    required bool status,
  }) async {
    try {
      final endpoint = Endpoints.userEmailNotificationEnable;

      final body = {
        "userId": userId,
        "status": status,
      };


      return await _apiClient.patch(
        endpoint,
        body,
      );
    } catch (e) {
      log("❌ Error updating : $e");
      return Failure("Something went wrong: $e");
    }
  }
}
