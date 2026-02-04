class AppConstants {
  static String appName = 'Easykey';
  // static String apiBaseUrl = 'https://easy-key-backend-1-0.vercel.app';
  static String apiBaseUrl = 'http://56.228.25.224:5000';
  static int appWideImagePickerQuality = 60;

}

class Endpoints{
  static String login = '${AppConstants.apiBaseUrl}/auth/signin';
  static String signUp = '${AppConstants.apiBaseUrl}/auth/signup';
  static String verifyOtp = '${AppConstants.apiBaseUrl}/auth/verify-otp-phone';
  static String sendOtp = '${AppConstants.apiBaseUrl}/auth/send-otp-phone';
  static String sendOtpToChip = '${AppConstants.apiBaseUrl}/keys/send-otp';
  static String verifyOtpToChip = '${AppConstants.apiBaseUrl}/keys//verify-otp';
  static String resendOtp = '${AppConstants.apiBaseUrl}/auth/resend-otp';
  static String updateProfile = '${AppConstants.apiBaseUrl}/users/profile/avatar';
  static String updateProfileInfo = '${AppConstants.apiBaseUrl}/users/profile';

  //social logins
  static String googleLogin = '${AppConstants.apiBaseUrl}/auth/oauth/google';
  static String facebookLogin = '${AppConstants.apiBaseUrl}/auth/oauth/facebook';
  static String appleLogin = '${AppConstants.apiBaseUrl}/auth/oauth/apple';
  static String checkUser = '${AppConstants.apiBaseUrl}/users/by-email';
  static String userNotificationEnable = '${AppConstants.apiBaseUrl}/users/notification/enabled';
  static String userEmailNotificationEnable = '${AppConstants.apiBaseUrl}/users/notification/email/enabled';


  //Terminal Endpoints
  static String allTerminals = '${AppConstants.apiBaseUrl}/terminals/terminals';

  //order keys
  static String orderKeys = '${AppConstants.apiBaseUrl}/keys/order';

  //update terminals time
  static String updateTime = '${AppConstants.apiBaseUrl}/terminals/terminals/opening-hours';
  //suggest new place
  static String suggestPlace = '${AppConstants.apiBaseUrl}/pickup-point-suggestions/suggest';
  static String updateKeyName = '${AppConstants.apiBaseUrl}/keys/update-name';
  static String deactivateKey = '${AppConstants.apiBaseUrl}/keys/deactivate';
  static String activateKey = '${AppConstants.apiBaseUrl}/keys/activate';
  static String transferOwnership = '${AppConstants.apiBaseUrl}/keys/transfer-ownership';
  static String updatePassword = '${AppConstants.apiBaseUrl}/users/change-password';
  static String shareAcc = '${AppConstants.apiBaseUrl}/users/transfer-account';
  static String deleteAcc = '${AppConstants.apiBaseUrl}/users/delete';
  static String updateLocation = '${AppConstants.apiBaseUrl}/users/location';
  static String forgetPassOtp = '${AppConstants.apiBaseUrl}/auth/forgot-password';
  static String forgetPassOtpVerify = '${AppConstants.apiBaseUrl}/auth/verify-password-reset-otp';
  static String resetPass = '${AppConstants.apiBaseUrl}/auth/reset-password';


  //terminal side
  static String scanKey = '${AppConstants.apiBaseUrl}/keys/scan';
  static String sendOtpToDB = '${AppConstants.apiBaseUrl}/keys/assign';
  static String dropKey = '${AppConstants.apiBaseUrl}/keys/drop-off';
  static String pickKey = '${AppConstants.apiBaseUrl}/keys/pick-up';

  //payments
  static String verifySession = '${AppConstants.apiBaseUrl}/payment/orders/verify-session';

  //get credit balance
  static String getCreditBalance = '${AppConstants.apiBaseUrl}/payment/credits/balance';
  static String requestPayout = '${AppConstants.apiBaseUrl}/payment/payouts/request';




  // user payments
  static String createSubscription = '${AppConstants.apiBaseUrl}/payment/subscriptions/create';
  static String currentSubscription = '${AppConstants.apiBaseUrl}/payment/subscriptions/current';
  static String subscriptionHistory = '${AppConstants.apiBaseUrl}/payment/subscriptions/my';
  static String createCustomer = '${AppConstants.apiBaseUrl}/payment/create-customer';
  static String createSetupIntent = '${AppConstants.apiBaseUrl}/payment/create-setup-intent';
  static String attachPaymentMethod = '${AppConstants.apiBaseUrl}/payment/attach-payment-method';
  static String updatePaymentMethod = '${AppConstants.apiBaseUrl}/payment/update-payment-method';
  static String fixedPickUpCode = '${AppConstants.apiBaseUrl}/payment/subscribe-fixed-code';

}