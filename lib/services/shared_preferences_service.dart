import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JwtDecoder {
  static Map<String, dynamic> decode(String token) {
    final parts = token.split('.');
    if (parts.length != 3) throw Exception('Invalid JWT');

    final payload = parts[1];
    final normalized = base64Url.normalize(payload);
    final decoded = utf8.decode(base64Url.decode(normalized));
    final claims = json.decode(decoded) as Map<String, dynamic>;

    if (kDebugMode) {
      log('JWT Decoded Payload ↓↓↓', name: 'JWT');
      claims.forEach((key, value) => log('$key : $value', name: 'JWT'));
      if (claims.containsKey('exp')) {
        final expiry = DateTime.fromMillisecondsSinceEpoch(
          claims['exp'] * 1000,
        );
        log('Token expires at: $expiry', name: 'JWT');
      }
    }

    return claims;
  }
}

class SharedPreferencesService {
  static const String _accessTokenKey = 'accessToken';

  static Future<void> saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, token);
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  static Future<Map<String, dynamic>?> getDecodedToken() async {
    final token = await getAccessToken();
    if (token == null || token.isEmpty) return null;
    return JwtDecoder.decode(token);
  }

  static Future<String?> getId() async {
    final decoded = await getDecodedToken();
    return decoded?['id']?.toString();
  }

  static Future<String?> getName() async {
    final decoded = await getDecodedToken();
    return decoded?['name']?.toString();
  }

  static Future<String?> getEmail() async {
    final decoded = await getDecodedToken();
    return decoded?['email']?.toString();
  }

  static Future<String?> getRole() async {
    final decoded = await getDecodedToken();
    return decoded?['role']?.toString();
  }

  static Future<String?> getSubscription() async {
    final decoded = await getDecodedToken();
    return decoded?['subscription']?.toString();
  }

  static Future<String?> getDeviceId() async {
    final decoded = await getDecodedToken();
    return decoded?['deviceId']?.toString();
  }

  static Future<DateTime?> getIssuedAt() async {
    final decoded = await getDecodedToken();
    if (decoded == null || !decoded.containsKey('iat')) return null;
    return DateTime.fromMillisecondsSinceEpoch(decoded['iat'] * 1000);
  }

  static Future<DateTime?> getExpiry() async {
    final decoded = await getDecodedToken();
    if (decoded == null || !decoded.containsKey('exp')) return null;
    return DateTime.fromMillisecondsSinceEpoch(decoded['exp'] * 1000);
  }

  static Future<bool> isTokenExpired() async {
    final expiry = await getExpiry();
    if (expiry == null) return true;
    return DateTime.now().isAfter(expiry);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
  }
}

class OnboardingPreferences {
  static const String _onboardingSeenKey = 'onboarding_seen';

  static Future<void> setOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingSeenKey, true);
  }

  static Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingSeenKey) ?? false;
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_onboardingSeenKey);
  }
}
