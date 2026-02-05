class AppConstants {
  static String appName = 'Easykey';
  // static String apiBaseUrl = 'https://easy-key-backend-1-0.vercel.app';
  static String apiBaseUrl = 'https://nuka-backend.vercel.app/api/';
  static int appWideImagePickerQuality = 60;
}

class Endpoints {
  static String selectPreferences = '${AppConstants.apiBaseUrl}auth/settings';
  static String getScans = '${AppConstants.apiBaseUrl}history';
  static String getScanDetails = '${AppConstants.apiBaseUrl}product/lookup';
  static String createScan = '${AppConstants.apiBaseUrl}scan';
  static String updateProfile = '${AppConstants.apiBaseUrl}auth/profile';
  static String login = '${AppConstants.apiBaseUrl}auth/login';
  static String googleLogin = '${AppConstants.apiBaseUrl}auth/google';
  static String sigUp = '${AppConstants.apiBaseUrl}auth/register';
}
