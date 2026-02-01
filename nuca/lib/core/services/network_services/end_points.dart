import '../export.dart';

class EndPoints {
  static String get baseUrl => getUrl();

  static String apiKeyReal = "AIzaSyDZ_FuvLYeS_LkaEAwSO7_18StJeNXxKEE";

  String generateImage() {
    return "$baseUrl/v1beta/models/gemini-2.5-flash-image:generateContent?key=$apiKeyReal";
  }

}
