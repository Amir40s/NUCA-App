class AppConstants {
  static String appName = 'Easykey';
  // static String apiBaseUrl = 'https://easy-key-backend-1-0.vercel.app';
  static String apiBaseUrl =
      'https://nuka-backend.vercel.app/api/auth/settings';
  static int appWideImagePickerQuality = 60;
}

class Endpoints {
  static String login = '${AppConstants.apiBaseUrl}auth/settings';
}
