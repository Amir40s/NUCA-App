import 'dart:async';
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
  static late final SharedPreferences _prefs;
  static const String _accessTokenKey = 'accessToken';
  static String? _accessToken;
  static Map<String, dynamic>? _decodedToken;
  static final _profileStreamController =
      StreamController<Map<String, dynamic>?>.broadcast();
  static Map<String, dynamic>? _lastEmittedProfile;
  static Stream<Map<String, dynamic>?> get profileStream async* {
    if (_lastEmittedProfile != null) yield _lastEmittedProfile;
    yield* _profileStreamController.stream;
  }

  static void _notifyProfileChanged() {
    _lastEmittedProfile = getPayload();
    _profileStreamController.add(_lastEmittedProfile);
  }

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _accessToken = _prefs.getString(_accessTokenKey);
    if (_accessToken != null && _accessToken!.isNotEmpty) {
      _decodedToken = JwtDecoder.decode(_accessToken!);
      _logPayload();
    }
  }

  static Future<void> saveAccessToken(String token) async {
    await _prefs.setString(_accessTokenKey, token);
    _accessToken = token;
    _decodedToken = JwtDecoder.decode(token);
    _logPayload();
    _notifyProfileChanged();
  }

  static Future<void> clear() async {
    await _prefs.remove(_accessTokenKey);
    _accessToken = null;
    _decodedToken = null;
    _notifyProfileChanged();
  }

  static String? getToken() => _accessToken;
  static Map<String, dynamic>? getPayload() => _decodedToken;
  static String? get id => _decodedToken?['id']?.toString();
  static String? get name => _decodedToken?['name']?.toString();
  static String? get email => _decodedToken?['email']?.toString();
  static String? get role => _decodedToken?['role']?.toString();
  static String? get subscription => _decodedToken?['subscription']?.toString();
  static String? get deviceId => _decodedToken?['deviceId']?.toString();
  static String? get profileImage =>
      (_decodedToken != null && _decodedToken!.containsKey('profileImage'))
      ? _decodedToken!['profileImage']?.toString()
      : null;
  static int get perMonthScans =>
      _decodedToken?.containsKey('perMonthScans') == true
      ? (_decodedToken?['perMonthScans'] as int? ?? 0)
      : 0;
  static int get totalScans => _decodedToken?.containsKey('totalScans') == true
      ? (_decodedToken?['totalScans'] as int? ?? 0)
      : 0;

  static DateTime? get issuedAt => _decodedToken?['iat'] != null
      ? DateTime.fromMillisecondsSinceEpoch(_decodedToken!['iat'] * 1000)
      : null;
  static DateTime? get expiry => _decodedToken?['exp'] != null
      ? DateTime.fromMillisecondsSinceEpoch(_decodedToken!['exp'] * 1000)
      : null;
  static bool get isTokenExpired =>
      expiry != null ? DateTime.now().isAfter(expiry!) : true;

  static void _logPayload() {
    final payload = getPayload();

    if (payload != null) {
      log("JWT Payload as Object:");
      payload.forEach((key, value) {
        log("$key : $value");
      });

      log("User ID: ${payload['id']}");
      log("Name: ${payload['name']}");
      log("Email: ${payload['email']}");
      log("Role: ${payload['role']}");
      log("Subscription: ${payload['subscription']}");
      log("Device ID: ${payload['deviceId']}");
      log("Profile Image: ${payload['profileImage'] ?? ''}");
      log("Per Month Scans: ${payload['perMonthScans'] ?? ''}");
      log("Total Scans: ${payload['totalScans'] ?? ''}");
      if (payload.containsKey('exp')) {
        final expiry = DateTime.fromMillisecondsSinceEpoch(
          payload['exp'] * 1000,
        );
        log("Token expires at: $expiry");
      }
    } else {
      log("No token found or not initialized yet!");
    }
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
