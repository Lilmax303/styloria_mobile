// lib/api_client.dart
// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as p;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show debugPrint, kIsWeb;

class ApiClient {
  // Backend base URL
  static String get baseUrl {
    return 'https://styloria.up.railway.app';
  }

  static const _secureStorage = FlutterSecureStorage();
  static late SharedPreferences _prefs;
  static bool _prefsInitialized = false;

  static Future<void> _initPrefs() async {
    if (_prefsInitialized) return;
    _prefs = await SharedPreferences.getInstance();
    _prefsInitialized = true;
  }

  // ---------- TOKEN STORAGE ----------

  static Future<String?> _getAccessToken() async {
    try {
      final token = await _secureStorage.read(key: 'access_token');
      if (token != null && token.isNotEmpty) return token;

      await _initPrefs();
      final fallback = _prefs.getString('access_token_fallback');
      if (fallback != null && fallback.isNotEmpty) return fallback;

      return null;
    } catch (e) {
      print('Error reading access token: $e');
      await _initPrefs();
      return _prefs.getString('access_token_fallback');
    }
  }

  static Future<String?> _getRefreshToken() async {
    try {
      final token = await _secureStorage.read(key: 'refresh_token');
      if (token != null && token.isNotEmpty) return token;

      await _initPrefs();
      final fallback = _prefs.getString('refresh_token_fallback');
      if (fallback != null && fallback.isNotEmpty) return fallback;

      return null;
    } catch (e) {
      print('Error reading refresh token: $e');
      await _initPrefs();
      return _prefs.getString('refresh_token_fallback');
    }
  }

  static Future<void> _saveTokens(String access, String refresh) async {
    try {
      await _secureStorage.write(key: 'access_token', value: access);
      await _secureStorage.write(key: 'refresh_token', value: refresh);
    } catch (e) {
      print('Failed to save tokens to secure storage: $e');
      await _initPrefs();
      await _prefs.setString('access_token_fallback', access);
      await _prefs.setString('refresh_token_fallback', refresh);
    }
  }

  static Future<bool> hasAccessToken() async {
    final token = await _getAccessToken();
    return token != null && token.isNotEmpty;
  }

  static Future<void> logout() async {
    try {
      await _secureStorage.deleteAll();
    } catch (e) {
      print('Error clearing secure storage: $e');
    }
    try {
      await _initPrefs();
      await _prefs.clear();
    } catch (e) {
      print('Error clearing shared preferences: $e');
    }
  }

  // ---------- USER ROLE (LOCAL) ----------

  static Future<void> saveUserRole(String role) async {
    try {
      await _secureStorage.write(key: 'user_role', value: role);
    } catch (e) {
      await _initPrefs();
      await _prefs.setString('user_role', role);
    }
  }

  static Future<String?> getCachedUserRole() async {
    try {
      final role = await _secureStorage.read(key: 'user_role');
      if (role != null && role.isNotEmpty) return role;
    } catch (e) {
      print('Error reading role from secure storage: $e');
    }

    await _initPrefs();
    return _prefs.getString('user_role');
  }

  // ---------- THEME (LOCAL) ----------

  static Future<void> saveThemeMode(String mode) async {
    try {
      await _secureStorage.write(key: 'theme_mode', value: mode);
    } catch (e) {
      await _initPrefs();
      await _prefs.setString('theme_mode', mode);
    }
  }

  static Future<String?> getThemeMode() async {
    try {
      final mode = await _secureStorage.read(key: 'theme_mode');
      if (mode != null && mode.isNotEmpty) return mode;
    } catch (e) {
      print('Error reading theme from secure storage: $e');
    }

    await _initPrefs();
    return _prefs.getString('theme_mode') ?? 'light';
  }

  // ---------- PAYMENT PREFERENCES (LOCAL ONLY) ----------

  static Future<void> savePaymentPreferences(Map<String, dynamic> prefs) async {
    await _initPrefs();
    await _prefs.setString('payment_prefs', jsonEncode(prefs));
  }

  static Future<Map<String, dynamic>?> getPaymentPreferences() async {
    await _initPrefs();
    final raw = _prefs.getString('payment_prefs');
    if (raw == null || raw.isEmpty) return null;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
      return null;
    } catch (e) {
      print('getPaymentPreferences decode error: $e');
      return null;
    }
  }

  
  // ---------- PROVIDER PAYOUT SETTINGS ----------

  static Future<Map<String, dynamic>?> getProviderPayoutSettings() async {
    final response = await _authorizedRequest('GET', '/api/providers/payout-settings/');
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    }
    return null;
  }

  static Future<Map<String, dynamic>?> updateProviderPayoutSettings(Map<String, dynamic> payload) async {
    final response = await _authorizedRequest(
      'PATCH',
      '/api/providers/payout-settings/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    }
    return null;
  }


  // ---------- STRIPE CONNECT (PROVIDER) ----------

  static Future<Map<String, dynamic>?> getProviderStripeStatus() async {
    final response = await _authorizedRequest('GET', '/api/providers/stripe/status/');
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    }
    return null;
  }

  static Future<Map<String, dynamic>?> createProviderStripeAccount() async {
    final response = await _authorizedRequest('POST', '/api/providers/stripe/create_account/');
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    }
    return null;
  }

  static Future<Map<String, dynamic>?> createProviderStripeAccountLink() async {
    final response = await _authorizedRequest('POST', '/api/providers/stripe/account_link/');
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    }
    return null;
  }

  static Future<Map<String, dynamic>?> createProviderStripeLoginLink() async {
    final response = await _authorizedRequest('POST', '/api/providers/stripe/login_link/');
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    }
    return null;
  }


  // ---------- PROVIDER PAYOUT HISTORY ----------

  static Future<List<dynamic>?> getProviderPayoutHistory({String? currency}) async {
    final q = (currency != null && currency.trim().isNotEmpty)
        ? '?currency=${Uri.encodeQueryComponent(currency.trim())}'
        : '';
    final response = await _authorizedRequest('GET', '/api/providers/payouts/history/$q');
    if (response.statusCode == 200) return jsonDecode(response.body) as List<dynamic>;
    return null;
  }



  // ---------- AUTH HELPERS ----------

  static Future<bool> _refreshAccessToken() async {
    final refresh = await _getRefreshToken();
    if (refresh == null || refresh.isEmpty) {
      await logout();
      return false;
    }

    final url = Uri.parse('$baseUrl/api/token/refresh/');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refresh': refresh}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final newAccess = data['access']?.toString();
        if (newAccess == null || newAccess.isEmpty) {
          await logout();
          return false;
        }
        await _saveTokens(newAccess, refresh);
        return true;
      }

      await logout();
      return false;
    } catch (e) {
      print('_refreshAccessToken error: $e');
      return false;
    }
  }

  // HTTP timeout duration
  static const Duration _requestTimeout = Duration(seconds: 30);

  static Future<http.Response> _authorizedRequest(
    String method,
    String path, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    String? access = await _getAccessToken();
    if (access == null || access.isEmpty) {
      return http.Response(
        jsonEncode({'detail': 'no_access_token'}),
        401,
        headers: {'content-type': 'application/json'},
      );
    }

    final uri = Uri.parse('$baseUrl$path');

    final baseHeaders = <String, String>{
      'Authorization': 'Bearer $access',
      'Accept': 'application/json',
    };

    if (headers != null) baseHeaders.addAll(headers);

    if (!baseHeaders.containsKey('Content-Type') &&
        body != null &&
        method.toUpperCase() != 'GET') {
      baseHeaders['Content-Type'] = 'application/json';
    }

    Future<http.Response> send() {
      Future<http.Response> request;
      switch (method.toUpperCase()) {
        case 'GET':
          request = http.get(uri, headers: baseHeaders);
          break;
        case 'POST':
          request = http.post(uri, headers: baseHeaders, body: body);
          break;
        case 'PATCH':
          request = http.patch(uri, headers: baseHeaders, body: body);
          break;
        case 'DELETE': // NEW
          request = http.delete(uri, headers: baseHeaders);
          break;
        default:
          throw UnsupportedError('HTTP method $method not supported');
      }

      return request.timeout(
        _requestTimeout,
        onTimeout: () {
          return http.Response(
            jsonEncode({'detail': 'Request timed out. Please check your internet connection.'}),
            408,
            headers: {'content-type': 'application/json'},
          );
        },
      );
    }

    try {
      var response = await send();

      if (response.statusCode == 401) {
        final refreshed = await _refreshAccessToken();
        if (!refreshed) return response;

        access = await _getAccessToken();
        if (access == null || access.isNotEmpty == false) return response;

        baseHeaders['Authorization'] = 'Bearer $access';
        response = await send();
      }

      return response;
    } catch (e) {
      print('_authorizedRequest error: $e');
      return http.Response(
        jsonEncode({'detail': 'network_error', 'error': e.toString()}),
        500,
        headers: {'content-type': 'application/json'},
      );
    }
  }

  // ---------- AUTH (JWT) ----------

  static Future<String?> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/api/token/');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final access = data['access']?.toString();
        final refresh = data['refresh']?.toString();

        if (access == null || refresh == null) {
          return 'Login succeeded but server did not return tokens.';
        }

        await _saveTokens(access, refresh);
        return null;
      }

      try {
        final data = jsonDecode(response.body);
        if (data is Map && data['detail'] is String) {
          return data['detail'] as String;
        }
      } catch (_) {}

      return 'Login failed (code ${response.statusCode}).';
    } catch (e) {
      return 'Unexpected error: $e';
    }
  }

  // ---------- MFA ----------

  static Future<int?> startMfaLogin(String username, String password) async {
    final url = Uri.parse('$baseUrl/api/mfa/start/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data['mfa_user_id'] as int?;
    }
    return null;
  }

  static Future<bool> verifyMfaCode(int userId, String code) async {
    final url = Uri.parse('$baseUrl/api/mfa/verify/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'user_id': userId, 'code': code}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final access = data['access']?.toString();
      final refresh = data['refresh']?.toString();
      if (access != null && refresh != null) {
        await _saveTokens(access, refresh);
        return true;
      }
    }
    return false;
  }

  // ---------- REGISTRATION ----------

  static Future<String?> registerUser({
    required String username,
    required String email,
    required String phoneNumber,
    required String role,
    required String firstName,
    required String lastName,
    required String countryName,
    required String cityName,
    required bool acceptedTerms,
    required String password,
    required String passwordConfirm,
    required String dateOfBirth,
    String? detectedCountry,
    bool? countryMismatch,
    String? referralCode,
  }) async {
    final url = Uri.parse('$baseUrl/api/users/');

    try {
      final body = {
        'username': username,
        'email': email,
        'phone_number': phoneNumber,
        'role': role,
        'first_name': firstName,
        'last_name': lastName,
        'country_name': countryName,
        'city_name': cityName,
        'accepted_terms': acceptedTerms,
        'password': password,
        'password_confirm': passwordConfirm,
        'date_of_birth': dateOfBirth,
        if (detectedCountry != null && detectedCountry.isNotEmpty) 
          'detected_country': detectedCountry,
        if (countryMismatch != null) 
          'country_mismatch': countryMismatch,
        if (referralCode != null && referralCode.isNotEmpty)
          'referred_by_code': referralCode,
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),

      ).timeout(
        _requestTimeout,
        onTimeout: () {
          return http.Response(
            jsonEncode({'detail': 'Request timed out'}),
            408,
          );
        },
      );

      if (response.statusCode == 201) return null;

      try {
        final data = jsonDecode(response.body);
        if (data is Map && data['detail'] is String) {
          return data['detail'] as String;
        }

        if (data is Map) {
          final messages = <String>[];
          data.forEach((k, v) {
            if (v is List) messages.add('$k: ${v.join(', ')}');
            if (v is String) messages.add('$k: $v');
          });
          if (messages.isNotEmpty) return messages.join('\n');
        }
      } catch (_) {}

      return 'Registration failed (code ${response.statusCode}).';
    } catch (e) {
      return 'Unexpected error: $e';
    }
  }

  // ---------- EMAIL VERIFICATION (PUBLIC) ----------

  // Public POST helper (no JWT)
  static Future<http.Response> _publicPost(
    String path, {
    Object? body,
  }) async {
    final uri = Uri.parse('$baseUrl$path');
    try {
      return await http.post(
        uri,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: body,
      );
    } catch (e) {
      return http.Response(
        jsonEncode({'detail': 'network_error', 'error': e.toString()}),
        500,
        headers: {'content-type': 'application/json'},
      );
    }
  }

  static Future<bool> sendEmailVerification(String identifier) async {
    final res = await _publicPost(
      '/api/auth/email/send-verification/',
      body: jsonEncode({'identifier': identifier}),
    );
    return res.statusCode >= 200 && res.statusCode < 300;
  }

  static Future<bool> confirmEmailVerification({
    required String identifier,
    required String code,
  }) async {
    final res = await _publicPost(
      '/api/auth/email/confirm-verification/',
      body: jsonEncode({'identifier': identifier, 'code': code}),
    );
    return res.statusCode >= 200 && res.statusCode < 300;
  }

  // ---------- CURRENT USER ----------

  static Future<Map<String, dynamic>?> getCurrentUser() async {
    final response = await _authorizedRequest('GET', '/api/users/me/');
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    return null;
  }

  static Future<Map<String, dynamic>?> updateCurrentUser(
    Map<String, dynamic> data,
  ) async {
    final response = await _authorizedRequest(
      'PATCH',
      '/api/users/me/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    return null;
  }

  static Future<bool> deleteMyAccount({
    required List<String> reasons,
    String? reasonText,
    String? suggestions,
  }) async {
    final response = await _authorizedRequest(
      'POST',
      '/api/users/me/delete_account/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'reasons': reasons,
        'reason_text': reasonText ?? '',
        'suggestions': suggestions ?? '',
      }),
    );

    // If successful, also log out locally
    final ok = response.statusCode >= 200 && response.statusCode < 300;
    if (ok) {
      await logout();
    }
    return ok;
  }


  // ---------- PROVIDER PROFILE ----------

  static Future<Map<String, dynamic>?> getMyProviderProfile() async {
    final response = await _authorizedRequest('GET', '/api/service_providers/me/');
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    return null;
  }

  /// NEW: Returns JSON even when the backend responds with non-200 (e.g. KYC gated).
  static Future<Map<String, dynamic>?> getMyProviderProfileAnyStatus() async {
    final response = await _authorizedRequest('GET', '/api/service_providers/me/');

    try {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    } catch (_) {}

    return null;
  }

  static Future<Map<String, dynamic>?> saveMyProviderProfile({
    required String bio,
    required double latitude,
    required double longitude,
    required bool available,
    required Map<String, dynamic> servicePrices,
    required List<String> unavailableServices,
  }) async {
    final response = await _authorizedRequest(
      'POST',
      '/api/service_providers/me/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'bio': bio,
        'location_latitude': latitude,
        'location_longitude': longitude,
        'available': available,
        'service_prices': servicePrices,
        'unavailable_services': unavailableServices,
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    return null;
  }


  // ---------- PROVIDER KYC (NEW) ----------

  static Future<Map<String, dynamic>> submitProviderVerificationBytes({
    required Uint8List idDocumentFrontBytes,
    required Uint8List verificationSelfieBytes,
    Uint8List? idDocumentBackBytes,
    String idDocumentFrontFilename = 'id_front.jpg',
    String verificationSelfieFilename = 'selfie.jpg',
    String idDocumentBackFilename = 'id_back.jpg',
  }) async {
    Future<http.Response> sendOnce(String token) async {
      final uri = Uri.parse('$baseUrl/api/provider-verification/submit/');
      final req = http.MultipartRequest('POST', uri);
      req.headers['Authorization'] = 'Bearer $token';
      req.headers['Accept'] = 'application/json';

      req.files.add(
        http.MultipartFile.fromBytes(
          'id_document_front',
          idDocumentFrontBytes,
          filename: idDocumentFrontFilename,
        ),
      );

      req.files.add(
        http.MultipartFile.fromBytes(
          'verification_selfie',
          verificationSelfieBytes,
          filename: verificationSelfieFilename,
        ),
      );

      if (idDocumentBackBytes != null) {
        req.files.add(
          http.MultipartFile.fromBytes(
            'id_document_back',
            idDocumentBackBytes,
            filename: idDocumentBackFilename,
          ),
        );
      }

      final streamed = await req.send();
      return http.Response.fromStream(streamed);
    }

    var access = await _getAccessToken();
    if (access == null || access.isEmpty) {
      return {'ok': false, 'status_code': 401, 'data': {'detail': 'no_access_token'}};
    }

    var resp = await sendOnce(access);

    if (resp.statusCode == 401) {
      final ok = await _refreshAccessToken();
      if (!ok) {
        return {'ok': false, 'status_code': 401, 'data': {'detail': 'token_refresh_failed'}};
      }
      access = await _getAccessToken();
      if (access == null || access.isEmpty) {
        return {'ok': false, 'status_code': 401, 'data': {'detail': 'no_access_token'}};
      }
      resp = await sendOnce(access);
    }

    Map<String, dynamic>? decoded;
    try {
      final d = jsonDecode(resp.body);
      if (d is Map<String, dynamic>) decoded = d;
      if (d is Map) decoded = Map<String, dynamic>.from(d);
    } catch (_) {
      decoded = {'raw': resp.body};
    }

    final ok = resp.statusCode >= 200 && resp.statusCode < 300;
    return {'ok': ok, 'status_code': resp.statusCode, 'data': decoded};
  }

  static Future<Map<String, dynamic>> submitProviderVerificationFiles({
    required File idDocumentFront,
    required File verificationSelfie,
    File? idDocumentBack,
  }) async {
    Future<http.Response> sendOnce(String token) async {
      final uri = Uri.parse('$baseUrl/api/provider-verification/submit/');
      final req = http.MultipartRequest('POST', uri);
      req.headers['Authorization'] = 'Bearer $token';
      req.headers['Accept'] = 'application/json';

      req.files.add(await http.MultipartFile.fromPath('id_document_front', idDocumentFront.path));
      req.files.add(await http.MultipartFile.fromPath('verification_selfie', verificationSelfie.path));

      if (idDocumentBack != null) {
        req.files.add(await http.MultipartFile.fromPath('id_document_back', idDocumentBack.path));
      }

      final streamed = await req.send();
      return http.Response.fromStream(streamed);
    }

    var access = await _getAccessToken();
    if (access == null || access.isEmpty) {
      return {'ok': false, 'status_code': 401, 'data': {'detail': 'no_access_token'}};
    }

    var resp = await sendOnce(access);

    if (resp.statusCode == 401) {
      final ok = await _refreshAccessToken();
      if (!ok) {
        return {'ok': false, 'status_code': 401, 'data': {'detail': 'token_refresh_failed'}};
      }
      access = await _getAccessToken();
      if (access == null || access.isEmpty) {
        return {'ok': false, 'status_code': 401, 'data': {'detail': 'no_access_token'}};
      }
      resp = await sendOnce(access);
    }

    Map<String, dynamic>? decoded;
    try {
      final d = jsonDecode(resp.body);
      if (d is Map<String, dynamic>) decoded = d;
      if (d is Map) decoded = Map<String, dynamic>.from(d);
    } catch (_) {
      decoded = {'raw': resp.body};
    }

    final ok = resp.statusCode >= 200 && resp.statusCode < 300;
    return {'ok': ok, 'status_code': resp.statusCode, 'data': decoded};
  }

  // ---------- SERVICE REQUESTS ----------

  static Future<Map<String, dynamic>?> createServiceRequest({
    required String appointmentTime,
    required double latitude,
    required double longitude,
    required String serviceType,
    String? notes,
    String? locationAddress,
  }) async {

    final body = <String, dynamic>{
      'appointment_time': appointmentTime,
      'location_latitude': latitude,
      'location_longitude': longitude,
      'service_type': serviceType,
      'notes': notes,
      if (locationAddress != null && locationAddress.isNotEmpty)
        'location_address': locationAddress,
    };
    if (notes != null && notes.trim().isNotEmpty) body['notes'] = notes.trim();

    final response = await _authorizedRequest(
      'POST',
      '/api/service_requests/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    if (response.statusCode == 201) return jsonDecode(response.body) as Map<String, dynamic>;
    return null;
  }

  static Future<List<dynamic>?> getUserBookings() async {
    final response = await _authorizedRequest('GET', '/api/service_requests/my_requests/');
    if (response.statusCode == 200) return jsonDecode(response.body) as List<dynamic>;
    return null;
  }

  static Future<List<dynamic>?> getProviderBookings() async {
    final response = await _authorizedRequest('GET', '/api/service_requests/assigned_to_me/');
    if (response.statusCode == 200) return jsonDecode(response.body) as List<dynamic>;
    return null;
  }

  static Future<Map<String, dynamic>?> getOpenJobs() async {
    final response = await _authorizedRequest('GET', '/api/service_requests/open_jobs/');
  
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
     
      // NEW: Backend returns structured response with tier info
      // {
      //   "jobs": [...],
      //   "provider_tier": "standard",
      //   "provider_trust_score": 64,
      //   "eligible_tiers": ["budget", "standard"]
      // }
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      if (decoded is Map) {
        return Map<String, dynamic>.from(decoded);
      }
      
      // Fallback: If backend still returns List (old format),
      // wrap it in the expected structure
      if (decoded is List) {
        return {
          'jobs': decoded,
          'provider_tier': null,
          'provider_trust_score': null,
          'eligible_tiers': null,
        };
      }
      
      return null;
    }
  
    // Handle 403 - check if provider is unavailable
    if (response.statusCode == 403) {
      final data = jsonDecode(response.body);
      if (data is Map && data['error_code'] == 'provider_unavailable') {
        throw Exception('provider_unavailable: ${data['message']}');
      }
      // Also handle tier mismatch errors
      if (data is Map && data['error_code'] == 'tier_mismatch') {
        throw Exception('tier_mismatch: ${data['detail']}');
      }
    }
  
    return null;
  }

  static Future<Map<String, dynamic>> acceptJob(int requestId) async {
    final response = await _authorizedRequest('POST', '/api/service_requests/$requestId/accept/');

    Map<String, dynamic> decoded = {};
    try {
      final d = jsonDecode(response.body);
      if (d is Map<String, dynamic>) decoded = d;
      if (d is Map) decoded = Map<String, dynamic>.from(d);
    } catch (_) {}
    
    if (response.statusCode == 200) {
      return {
        'success': true,
        'status_code': 200,
        ...decoded,
      };
    }
    
    // Handle tier mismatch error specifically
    if (response.statusCode == 403 && decoded['error_code'] == 'tier_mismatch') {
      return {
        'success': false,
        'status_code': 403,
        'error_code': 'tier_mismatch',
        'detail': decoded['detail'] ?? 'You are not eligible for this tier of job.',
        'your_tier': decoded['your_tier'],
        'required_tier': decoded['required_tier'],
        'how_to_upgrade': decoded['how_to_upgrade'],
      };
    }
    
    return {
      'success': false,
      'status_code': response.statusCode,
      'detail': decoded['detail'] ?? 'Failed to accept job.',
    };
  }

  static Future<Map<String, dynamic>?> cancelServiceRequest(int requestId) async {
    final response = await _authorizedRequest('POST', '/api/service_requests/$requestId/cancel/');
    if (response.statusCode == 200) return jsonDecode(response.body) as Map<String, dynamic>;
    return null;
  }

  static Future<Map<String, dynamic>?> confirmCompletion(int requestId) async {
    final response = await _authorizedRequest('POST', '/api/service_requests/$requestId/confirm_completion/');
    if (response.statusCode == 200) return jsonDecode(response.body) as Map<String, dynamic>;
    return null;
  }

  static Future<Map<String, dynamic>?> getContactInfo(int requestId) async {
    final response = await _authorizedRequest('GET', '/api/service_requests/$requestId/contact_info/');
    if (response.statusCode == 200) return jsonDecode(response.body) as Map<String, dynamic>;
    return null;
  }

  static Future<Map<String, dynamic>?> setOfferedPrice({
    required int requestId,
    required double offeredPrice,
    required String selectedTier,
  }) async {
    final response = await _authorizedRequest(
      'POST',
      '/api/service_requests/$requestId/set_offered_price/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'offered_price': offeredPrice,
        'selected_tier': selectedTier,
      }),
    );
    if (response.statusCode == 200) return jsonDecode(response.body) as Map<String, dynamic>;
    return null;
  }

  static Future<Map<String, dynamic>?> getPriceOptions(int serviceRequestId) async {
    final response = await _authorizedRequest('GET', '/api/service_requests/$serviceRequestId/price_options/');
    if (response.statusCode == 200) return jsonDecode(response.body) as Map<String, dynamic>;
    return null;
  }

  // GET /api/service_requests/<id>/
  static Future<Map<String, dynamic>?> getServiceRequest(int requestId) async {
    final response = await _authorizedRequest('GET', '/api/service_requests/$requestId/');
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    }
    return null;
  }

  // Get enhanced job details after acceptance (with full customer info and navigation)
  static Future<Map<String, dynamic>?> getJobDetails(int jobId) async {
    try {
      final response = await _authorizedRequest('GET', '/api/service_requests/$jobId/job_details/');
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded is Map<String, dynamic>) return decoded;
        if (decoded is Map) return Map<String, dynamic>.from(decoded);
      }
      return null;
    } catch (e) {
      print('Error getting enhanced job details: $e');
      return null;
    }
  }


  // ---------- PAYMENTS ----------

  static Future<String?> createPaymentIntent(
    int serviceRequestId, {
    double? offeredPrice,
  }) async {
    final body = <String, dynamic>{'service_request_id': serviceRequestId};
    if (offeredPrice != null) body['offered_price'] = offeredPrice;

    final response = await _authorizedRequest(
      'POST',
      '/api/create_payment/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) {
        final cs = decoded['client_secret'];
        if (cs == null) return null;
        return cs.toString();
      }
      if (decoded is Map) {
        final data = Map<String, dynamic>.from(decoded);
        final cs = data['client_secret'];
        if (cs == null) return null;
        return cs.toString();
      }
      return null;
    }
    return null;
  }

  /// Call after Stripe PaymentSheet success to reconcile booking status immediately.
  /// Returns updated booking JSON on success.
  static Future<Map<String, dynamic>?> confirmStripePayment({
    int? serviceRequestId,
    String? paymentIntentId,
  }) async {
    final body = <String, dynamic>{};
    if (serviceRequestId != null) body["service_request_id"] = serviceRequestId;
    if (paymentIntentId != null && paymentIntentId.trim().isNotEmpty) {
      body["payment_intent_id"] = paymentIntentId.trim();
    }

    final response = await _authorizedRequest(
      'POST',
      '/api/stripe/confirm_payment/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    }
    return null;
  }

  /// Detailed version so UI can detect backend rule blocks (e.g. flutterwave_required).
  /// Returns:
  /// {
  ///   "ok": true,
  ///   "client_secret": "...",
  ///   "status_code": 200
  ///   "referral_discount_applied": true,
  ///   "referral_discount_amount": 3.50,
  ///   "original_price": 50.0
  /// }
  /// OR
  /// {
  ///   "ok": false,
  ///   "status_code": 403,
  ///   "error_code": "flutterwave_required",
  ///   "detail": "...",
  /// }
  static Future<Map<String, dynamic>> createPaymentIntentDetailed(
    int serviceRequestId, {
    double? offeredPrice,
    String? selectedTier,
    bool useReferralCredit = true,
  }) async {
    final body = <String, dynamic>{
      'service_request_id': serviceRequestId,
      'use_referral_credit': useReferralCredit,
    };
    if (offeredPrice != null) body['offered_price'] = offeredPrice;
    if (selectedTier != null) body['selected_tier'] = selectedTier;

    final response = await _authorizedRequest(
      'POST',
      '/api/create_payment/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    Map<String, dynamic> decoded = {};
    try {
      final d = jsonDecode(response.body);
      if (d is Map<String, dynamic>) decoded = d;
      if (d is Map) decoded = Map<String, dynamic>.from(d);
    } catch (_) {}

    if (response.statusCode == 200) {
      return {
        "ok": true,
        "status_code": 200,
        "client_secret": decoded["client_secret"]?.toString(),
        "payment_intent_id": decoded["payment_intent_id"]?.toString(),
        "currency": decoded["currency"]?.toString(),
        // Referral info from response
        "referral_discount_applied": decoded["referral_discount_applied"] ?? false,
        "referral_discount_amount": decoded["referral_discount_amount"],
        "original_price": decoded["original_price"],
      };
    }

    return {
      "ok": false,
      "status_code": response.statusCode,
      "error_code": decoded["error_code"]?.toString() ?? decoded["error"]?.toString(),
      "detail": decoded["detail"]?.toString() ?? decoded["error"]?.toString() ?? "payment_failed",
      "raw": decoded,
    };
  }


  // ---------- FLUTTERWAVE (AFRICA PAYMENTS) ----------
  // You must implement these endpoints on your backend.

  /// Expected response example:
  /// {
  ///   "public_key": "...",
  ///   "encryption_key": "...",
  ///   "tx_ref": "styloria_<id>_<timestamp>",
  ///   "currency": "GHS",
  ///   "amount": 50.0,
  ///   "customer_email": "x@y.com",
  ///   "customer_phone": "+233....",
  ///   "customer_name": "First Last"
  ///   "referral_discount_applied": true,
  ///   "referral_discount_amount": 3.50,
  ///   "original_price": 50.0
  /// }
  static Future<Map<String, dynamic>?> createFlutterwaveCheckout({
    required int serviceRequestId,
    required double amount,
    String? selectedTier,
    bool useReferralCredit = true,
  }) async {
    final response = await _authorizedRequest(
      'POST',
      '/api/flutterwave/create_checkout/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'service_request_id': serviceRequestId,
        'amount': amount,
        if (selectedTier != null) 'selected_tier': selectedTier,
        'use_referral_credit': useReferralCredit,
      }),
    );
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    }
    return null;
  }

  /// Expected response: { "verified": true }
  static Future<bool> verifyFlutterwavePayment({
    required String txRef,
    required int transactionId,
  }) async {
    final res = await verifyFlutterwavePaymentDetailed(txRef: txRef, transactionId: transactionId);
    return res["verified"] == true;
  }


  /// Returns { "verified": true, "booking": {...} } or { "verified": false, "detail": ... }
  static Future<Map<String, dynamic>> verifyFlutterwavePaymentDetailed({
    required String txRef,
    required int transactionId,
  }) async {
    final response = await _authorizedRequest(
      'POST',
      '/api/flutterwave/verify_payment/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'tx_ref': txRef, 'transaction_id': transactionId}),
    );
    Map<String, dynamic> decoded = {};
    try {
      final d = jsonDecode(response.body);
      if (d is Map<String, dynamic>) decoded = d;
      if (d is Map) decoded = Map<String, dynamic>.from(d);
    } catch (_) {}

    if (response.statusCode == 200) {
      return {
        "verified": decoded["verified"] == true,
        "booking": decoded["booking"],
      };
    }
    return {
      "verified": false,
      "status_code": response.statusCode,
      "detail": decoded["detail"]?.toString() ?? "verification_failed",
      "raw": decoded,
    };
  }

  /// Verify Flutterwave payment by tx_ref only (when SDK doesn't return transaction_id)
  /// POST /api/flutterwave/verify_by_txref/
  static Future<Map<String, dynamic>> verifyFlutterwaveByTxRef({
    required String txRef,
  }) async {
    final response = await _authorizedRequest(
      'POST',
      '/api/flutterwave/verify_by_txref/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'tx_ref': txRef}),
    );
    
    Map<String, dynamic> decoded = {};
    try {
      final d = jsonDecode(response.body);
      if (d is Map<String, dynamic>) decoded = d;
      if (d is Map) decoded = Map<String, dynamic>.from(d);
    } catch (_) {}

    if (response.statusCode == 200) {
      return {
        "verified": decoded["verified"] == true,
        "booking": decoded["booking"],
      };
    }
    return {
      "verified": false,
      "status_code": response.statusCode,
      "detail": decoded["detail"]?.toString() ?? "verification_failed",
    };
  }

  /// Reset a failed/cancelled Flutterwave payment to allow retry
  static Future<bool> resetFlutterwavePayment(int serviceRequestId) async {
    final response = await _authorizedRequest(
      'POST',
      '/api/flutterwave/reset_payment/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'service_request_id': serviceRequestId}),
    );
    return response.statusCode == 200;
  }


  // =============================================================================
  // PAYSTACK PAYMENTS (Ghana, Nigeria, South Africa, Kenya, Côte d'Ivoire)
  // =============================================================================

  /// Paystack-supported countries
  static const List<String> _paystackCountries = [
    'ghana',
    'nigeria',
    'south africa',
    'kenya',
    'côte d\'ivoire',
    'cote d\'ivoire',
    'ivory coast',
  ];

  /// Check if user's country uses Paystack
  static bool isPaystackCountry(String? countryName) {
    if (countryName == null || countryName.isEmpty) return false;
    final normalized = countryName.toLowerCase().trim();
    return _paystackCountries.any((c) => 
      normalized.contains(c) || c.contains(normalized)
    );
  }

  /// Get the appropriate payment gateway for a country
  /// Returns: 'paystack', 'flutterwave', or 'stripe'
  static String getPaymentGateway(String? countryName) {
    if (countryName == null || countryName.isEmpty) return 'stripe';
    
    // Check Paystack countries first
    if (isPaystackCountry(countryName)) {
      return 'paystack';
    }
    
    // Check other African countries for Flutterwave
    const africanCountries = [
      'algeria', 'angola', 'benin', 'botswana', 'burkina faso', 'burundi',
      'cameroon', 'cape verde', 'central african republic', 'chad', 'comoros',
      'congo', 'djibouti', 'egypt', 'equatorial guinea', 'eritrea', 'eswatini',
      'ethiopia', 'gabon', 'gambia', 'guinea', 'guinea-bissau', 'lesotho',
      'liberia', 'libya', 'madagascar', 'malawi', 'mali', 'mauritania',
      'mauritius', 'morocco', 'mozambique', 'namibia', 'niger', 'rwanda',
      'sao tome', 'senegal', 'seychelles', 'sierra leone', 'somalia', 'sudan',
      'south sudan', 'tanzania', 'togo', 'tunisia', 'uganda', 'zambia', 'zimbabwe',
    ];
    
    final normalized = countryName.toLowerCase().trim();
    if (africanCountries.any((c) => normalized.contains(c) || c.contains(normalized))) {
      return 'flutterwave';
    }
    
    return 'stripe';
  }

  /// Initialize Paystack checkout
  /// Returns: { authorization_url, access_code, reference, currency, amount, public_key }
  static Future<Map<String, dynamic>?> createPaystackCheckout({
    required int serviceRequestId,
    required double amount,
    String? selectedTier,
    bool useReferralCredit = true,
  }) async {
    final response = await _authorizedRequest(
      'POST',
      '/api/paystack/create_checkout/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'service_request_id': serviceRequestId,
        'amount': amount,
        if (selectedTier != null) 'selected_tier': selectedTier,
        'use_referral_credit': useReferralCredit,
      }),
    );
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    }
    // Log error for debugging
    try {
      print('createPaystackCheckout failed: ${response.statusCode} ${response.body}');
    } catch (_) {}
    return null;
  }

  /// Verify Paystack payment by reference
  /// Returns: { verified: true, booking: {...} } or { verified: false, detail: ... }
  static Future<Map<String, dynamic>> verifyPaystackPayment({
    required String reference,
  }) async {
    final response = await _authorizedRequest(
      'POST',
      '/api/paystack/verify_payment/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'reference': reference}),
    );
    Map<String, dynamic> decoded = {};
    try {
      final d = jsonDecode(response.body);
      if (d is Map<String, dynamic>) decoded = d;
      if (d is Map) decoded = Map<String, dynamic>.from(d);
    } catch (_) {}

    if (response.statusCode == 200) {
      return {
        "verified": decoded["verified"] == true,
        "booking": decoded["booking"],
      };
    }
    return {
      "verified": false,
      "status_code": response.statusCode,
      "detail": decoded["detail"]?.toString() ?? "verification_failed",
      "raw": decoded,
    };
  }

  /// Reset a failed/cancelled Paystack payment to allow retry
  static Future<bool> resetPaystackPayment(int serviceRequestId) async {
    final response = await _authorizedRequest(
      'POST',
      '/api/paystack/reset_payment/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'service_request_id': serviceRequestId}),
    );
    return response.statusCode == 200;
  }

  /// Get Paystack banks for a country
  /// GET /api/paystack/banks/?country=ghana&currency=GHS
  static Future<List<dynamic>?> getPaystackBanks({
    String? country,
    String? currency,
  }) async {
    final params = <String>[];
    if (country != null && country.isNotEmpty) {
      params.add('country=${Uri.encodeQueryComponent(country)}');
    }
    if (currency != null && currency.isNotEmpty) {
      params.add('currency=${Uri.encodeQueryComponent(currency)}');
    }
    final query = params.isNotEmpty ? '?${params.join('&')}' : '';
    
    final response = await _authorizedRequest('GET', '/api/paystack/banks/$query');
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map && decoded['banks'] != null) {
        return decoded['banks'] as List<dynamic>;
      }
    }
    return null;
  }

  /// Resolve/verify Paystack bank account to get account name
  /// POST /api/paystack/resolve_account/
  static Future<Map<String, dynamic>?> resolvePaystackAccount({
    required String accountNumber,
    required String bankCode,
  }) async {
    final response = await _authorizedRequest(
      'POST',
      '/api/paystack/resolve_account/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'account_number': accountNumber,
        'bank_code': bankCode,
      }),
    );
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    }
    return null;
  }

  // =============================================================================
  // PAYSTACK TIPS
  // =============================================================================

  /// Create Paystack checkout for tip (Paystack countries only)
  /// POST /api/service_requests/<id>/tip/paystack_checkout/
  static Future<Map<String, dynamic>?> createTipPaystackCheckout({
    required int serviceRequestId,
    required double tipAmount,
  }) async {
    final response = await _authorizedRequest(
      'POST',
      '/api/service_requests/$serviceRequestId/tip/paystack_checkout/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'tip_amount': tipAmount}),
    );
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    }
    try {
      print('createTipPaystackCheckout failed: ${response.statusCode} ${response.body}');
    } catch (_) {}
    return null;
  }

  /// Verify Paystack tip payment
  /// POST /api/service_requests/<id>/tip/paystack_verify/
  static Future<Map<String, dynamic>> verifyTipPaystackPayment({
    required int serviceRequestId,
    required String reference,
  }) async {
    final response = await _authorizedRequest(
      'POST',
      '/api/service_requests/$serviceRequestId/tip/paystack_verify/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'reference': reference}),
    );
    Map<String, dynamic> decoded = {};
    try {
      final d = jsonDecode(response.body);
      if (d is Map<String, dynamic>) decoded = d;
      if (d is Map) decoded = Map<String, dynamic>.from(d);
    } catch (_) {}

    if (response.statusCode == 200) {
      return {
        "verified": decoded["verified"] == true,
        "booking": decoded["booking"],
      };
    }
    return {
      "verified": false,
      "status_code": response.statusCode,
      "detail": decoded["detail"]?.toString() ?? "tip_verification_failed",
      "raw": decoded,
    };
  }


  // ---------- REFERRAL SYSTEM ----------

  /// Get current user's referral stats and code
  static Future<Map<String, dynamic>?> getReferralStats() async {
    final response = await _authorizedRequest('GET', '/api/referral/stats/');
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    return null;
  }

  /// Validate a referral code before registration
  static Future<Map<String, dynamic>> validateReferralCode(String code) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/referral/validate/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'code': code}),
    );
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {
        'valid': data['valid'] == true,
        'referrer_first_name': data['referrer_first_name'],
      };
    }
    return {'valid': false};
  }

  /// Get referral discount preview for a booking
  static Future<Map<String, dynamic>?> getReferralDiscountPreview(int serviceRequestId) async {
    final response = await _authorizedRequest(
      'GET', 
      '/api/referral/discount_preview/$serviceRequestId/'
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    return null;
  }


  /// Check if referral discount was already applied to a booking
  /// Used to prevent showing "use credit" option on payment retry
  static Future<bool> isReferralDiscountApplied(int serviceRequestId) async {
    final booking = await getServiceRequest(serviceRequestId);
    if (booking == null) return false;
    return booking['referral_discount_applied'] == true;
  }


  // ---------- TIPS ----------
  // POST /api/service_requests/<id>/tip/create_payment_intent/

  static Future<String?> createTipPaymentIntent({
    required int serviceRequestId,
    required double tipAmount,
  }) async {
    final response = await _authorizedRequest(
      'POST',
      '/api/service_requests/$serviceRequestId/tip/create_payment_intent/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'tip_amount': tipAmount}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data['client_secret']?.toString();
    }

    // If your backend uses a different route, update the path above.
    return null;
  }

  // POST /api/service_requests/<id>/tip/set/
  // Returns updated booking JSON
  static Future<Map<String, dynamic>?> setTip({
    required int requestId,
    required double tipAmount,
  }) async {
    final response = await _authorizedRequest(
      'POST',
      '/api/service_requests/$requestId/tip/set/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'tip_amount': tipAmount}),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    }
    return null;
  }


  // ---------- FLUTTERWAVE TIPS (AFRICAN USERS) ----------

  /// Create Flutterwave checkout for tip (African users only)
  /// POST /api/service_requests/<id>/tip/flutterwave_checkout/
  /// Returns checkout data with public_key, tx_ref, currency, amount, etc.
  static Future<Map<String, dynamic>?> createTipFlutterwaveCheckout({
    required int serviceRequestId,
    required double tipAmount,
  }) async {
    final response = await _authorizedRequest(
      'POST',
      '/api/service_requests/$serviceRequestId/tip/flutterwave_checkout/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'tip_amount': tipAmount}),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    }

    // Log error for debugging
    try {
      print('createTipFlutterwaveCheckout failed: ${response.statusCode} ${response.body}');
    } catch (_) {}

    return null;
  }

  /// Verify Flutterwave tip payment
  /// POST /api/service_requests/<id>/tip/flutterwave_verify/
  /// Returns { "verified": true, "booking": {...} } or { "verified": false, "detail": ... }
  static Future<Map<String, dynamic>> verifyTipFlutterwavePayment({
    required int serviceRequestId,
    required String txRef,
    required int transactionId,
  }) async {
    final response = await _authorizedRequest(
      'POST',
      '/api/service_requests/$serviceRequestId/tip/flutterwave_verify/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'tx_ref': txRef,
        'transaction_id': transactionId,
      }),
    );

    Map<String, dynamic> decoded = {};
    try {
      final d = jsonDecode(response.body);
      if (d is Map<String, dynamic>) decoded = d;
      if (d is Map) decoded = Map<String, dynamic>.from(d);
    } catch (_) {}

    if (response.statusCode == 200) {
      return {
        "verified": decoded["verified"] == true,
        "booking": decoded["booking"],
      };
    }

    return {
      "verified": false,
      "status_code": response.statusCode,
      "detail": decoded["detail"]?.toString() ?? "tip_verification_failed",
      "raw": decoded,
    };
  }

  /// Verify tip payment by tx_ref only (for MoMo where redirect fails)
  static Future<Map<String, dynamic>> verifyTipFlutterwaveByRef({
    required int serviceRequestId,
    required String txRef,
  }) async {
    final token = await _getAccessToken();
    if (token == null) {
      return {'verified': false, 'detail': 'Not authenticated'};
    }

    try {
      final resp = await http.post(
        Uri.parse('$baseUrl/api/service_requests/$serviceRequestId/tip/flutterwave_verify_by_ref/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'tx_ref': txRef}),
      );

      if (resp.statusCode >= 200 && resp.statusCode < 300) {
        return jsonDecode(resp.body) as Map<String, dynamic>;
      } else {
        try {
          return jsonDecode(resp.body) as Map<String, dynamic>;
        } catch (_) {
          return {'verified': false, 'detail': 'Request failed with status ${resp.statusCode}'};
        }
      }
    } catch (e) {
      return {'verified': false, 'detail': e.toString()};
    }
  }

  // ---------- REVIEWS ----------

  static Future<bool> submitReview({
    required int providerId,
    required int rating,
    String? comment,
    int? serviceRequestId,
  }) async {
    final response = await _authorizedRequest(
      'POST',
      '/api/reviews/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'service_provider_id': providerId,
        'rating': rating,
        'comment': comment ?? '',
        if (serviceRequestId != null) 'service_request_id': serviceRequestId,
      }),
    );
    return response.statusCode == 201;
  }

  static Future<List<dynamic>?> getMyReviews() async {
    final response = await _authorizedRequest('GET', '/api/reviews/my_reviews/');
    if (response.statusCode == 200) return jsonDecode(response.body) as List<dynamic>;
    return null;
  }


  /// Get reviews received by the current provider (for Manage Profile screen)
  static Future<Map<String, dynamic>?> getReceivedReviews() async {
    final response = await _authorizedRequest('GET', '/api/reviews/received/');
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    }
    return null;
  }

  /// Get reviews for a specific provider
  static Future<Map<String, dynamic>?> getProviderReviews(int providerId) async {
    final response = await _authorizedRequest('GET', '/api/reviews/for_provider/$providerId/');
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    }
    return null;
  }

  /// Get provider reviews for a booking (for requester to see)
  static Future<Map<String, dynamic>?> getProviderReviewsForBooking(int bookingId) async {
    final response = await _authorizedRequest('GET', '/api/service_requests/$bookingId/provider_reviews/');
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    }
    return null;
  }

  // ---------- ETA ----------

  /// Get route-based ETA for a booking
  static Future<Map<String, dynamic>?> getBookingEta(int bookingId) async {
    final response = await _authorizedRequest('GET', '/api/service_requests/$bookingId/eta/');
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    }
    return null;
  }


  // ------------- RESET APPOINTMENTS -----------

  /// Reset appointment time for unpaid booking (must be today, future time only)
  /// POST /api/service_requests/<id>/reset_appointment_time/
  static Future<Map<String, dynamic>> resetAppointmentTime({
    required int serviceRequestId,
    required String appointmentTime,
  }) async {
    final response = await _authorizedRequest(
      'POST',
      '/api/service_requests/$serviceRequestId/reset_appointment_time/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'appointment_time': appointmentTime}),
    );
    
    Map<String, dynamic> decoded = {};
    try {
      final d = jsonDecode(response.body);
      if (d is Map<String, dynamic>) decoded = d;
      if (d is Map) decoded = Map<String, dynamic>.from(d);
    } catch (_) {}
    
    if (response.statusCode == 200) {
      return {
        'success': true,
        'booking': decoded['booking'],
        'detail': decoded['detail'],
      };
    }
    
    return {
      'success': false,
      'status_code': response.statusCode,
      'detail': decoded['detail'] ?? 'Failed to reset appointment time',
      'error_code': decoded['error_code'],
    };
  }



  // ---------- NOTIFICATIONS ----------

  static Future<List<dynamic>?> getNotifications() async {
    final response = await _authorizedRequest('GET', '/api/notifications/');
    if (response.statusCode == 200) return jsonDecode(response.body) as List<dynamic>;
    return null;
  }

  static Future<int> getUnreadNotificationCount() async {
    final response = await _authorizedRequest('GET', '/api/notifications/unread/count/');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['unread_count'] as int?) ?? 0;
    }
    return 0;
  }

  static Future<bool> markNotificationRead(int id) async {
    final response = await _authorizedRequest('POST', '/api/notifications/read/$id/');
    return response.statusCode == 200;
  }

  /// Delete a notification
  static Future<bool> deleteNotification(int id) async {
    final response = await _authorizedRequest('DELETE', '/api/notifications/$id/delete/');
    return response.statusCode == 200;
  }

  /// Mark all notifications as read
  static Future<bool> markAllNotificationsRead() async {
    final response = await _authorizedRequest('POST', '/api/notifications/mark_all_read/');
    return response.statusCode == 200;
  }

  /// Clear all notifications
  static Future<bool> clearAllNotifications() async {
    final response = await _authorizedRequest('DELETE', '/api/notifications/clear_all/');
    return response.statusCode == 200;
  }

  /// Delete multiple notifications by IDs
  static Future<Map<String, dynamic>> deleteSelectedNotifications(List<int> ids) async {
    final response = await _authorizedRequest(
      'POST',
      '/api/notifications/delete_selected/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'ids': ids}),  // ✅ CORRECT - encode to JSON string
    );
  
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    return {'success': false, 'deleted_count': 0};
  }

  // ---------- CHAT ----------

  static Future<Map<String, dynamic>?> getOrCreateChatThreadForRequest(int requestId) async {
    final response = await _authorizedRequest('GET', '/api/chats/for_request/$requestId/');
    if (response.statusCode == 200) return jsonDecode(response.body) as Map<String, dynamic>;
    return null;
  }

  static Future<List<dynamic>?> getChatMessages(int threadId) async {
    final response = await _authorizedRequest('GET', '/api/chats/$threadId/messages/');
    if (response.statusCode == 200) return jsonDecode(response.body) as List<dynamic>;
    return null;
  }

  static Future<Map<String, dynamic>?> sendChatMessage(int threadId, String content) async {
    final response = await _authorizedRequest(
      'POST',
      '/api/chats/$threadId/messages/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'content': content}),
    );
    if (response.statusCode == 201) return jsonDecode(response.body) as Map<String, dynamic>;
    return null;
  }

  // ---------- SUPPORT CHAT ----------

  static Future<Map<String, dynamic>?> getOrCreateSupportThread() async {
    final response = await _authorizedRequest('GET', '/api/support_chats/my_thread/');
    if (response.statusCode == 200) return jsonDecode(response.body) as Map<String, dynamic>;
    return null;
  }

  static Future<List<dynamic>?> getSupportMessages(int threadId) async {
    final response = await _authorizedRequest('GET', '/api/support_chats/$threadId/messages/');
    if (response.statusCode == 200) return jsonDecode(response.body) as List<dynamic>;
    return null;
  }

  static Future<Map<String, dynamic>?> sendSupportMessage(int threadId, String content) async {
    final response = await _authorizedRequest(
      'POST',
      '/api/support_chats/$threadId/messages/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'content': content}),
    );
    if (response.statusCode == 201) return jsonDecode(response.body) as Map<String, dynamic>;
    return null;
  }

  // ---------- PROVIDER EARNINGS ----------

  static Future<Map<String, dynamic>?> getProviderEarningsSummary() async {
    final response = await _authorizedRequest('GET', '/api/providers/earnings/summary/');
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    }
    return null;
  }

  static Future<Uint8List?> downloadProviderEarningsReportPdf({required String period}) async {
    final encodedPeriod = Uri.encodeQueryComponent(period);
    final response = await _authorizedRequest('GET', '/api/providers/earnings/report/?period=$encodedPeriod');
    if (response.statusCode == 200) return response.bodyBytes;
    return null;
  }

  static String providerEarningsReportFilename(String period) {
    final safe = period.replaceAll(RegExp(r'[^a-zA-Z0-9_\-]'), '_');
    return 'styloria_earnings_$safe.pdf';
  }

  
  // ---------- PROVIDER WALLET ----------

  static Future<List<dynamic>?> getProviderWalletSummary() async {
    final response = await _authorizedRequest('GET', '/api/providers/wallet/summary/');
    if (response.statusCode == 200) return jsonDecode(response.body) as List<dynamic>;
    return null;
  }

  static Future<List<dynamic>?> getProviderWalletTransactions({String? currency}) async {
    final q = (currency != null && currency.trim().isNotEmpty)
        ? '?currency=${Uri.encodeQueryComponent(currency.trim())}'
        : '';
    final response = await _authorizedRequest('GET', '/api/providers/wallet/transactions/$q');
    if (response.statusCode == 200) return jsonDecode(response.body) as List<dynamic>;
    return null;
  }

  /// Get instant cashout info including button state, remaining uses, notices
  /// GET /api/provider/instant-cashout-info/
  static Future<Map<String, dynamic>?> getInstantCashoutInfo() async {
    final response = await _authorizedRequest('GET', '/api/provider/instant-cashout-info/');
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    }
    return null;
  }

  /// Instant cash out with amount selection
  /// Returns detailed response including remaining uses and success/error info
  static Future<Map<String, dynamic>> providerCashOut({
    required String currency,
    required double amount,
  }) async {
    final body = <String, dynamic>{
      'currency': currency,
      'amount': amount,
    };

    final response = await _authorizedRequest(
      'POST',
      '/api/providers/wallet/cash_out/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    Map<String, dynamic> decoded = {};

    try {
      final d = jsonDecode(response.body);
      if (d is Map<String, dynamic>) decoded = d;
      if (d is Map) decoded = Map<String, dynamic>.from(d);
    } catch (_) {}
    
    if (response.statusCode == 200) {
      return {
        "success": true,
        "status_code": response.statusCode,
        "payout": decoded["payout"],
        "wallet": decoded["wallet"],
        "instant_payouts_remaining": decoded["instant_payouts_remaining"],
        "message": decoded["message"],
      };
    }

    return {
      "success": false,
      "status_code": response.statusCode,
      "detail": decoded["detail"]?.toString() ?? "cash_out_failed",
      "instant_payouts_remaining": decoded["instant_payouts_remaining"],
      "next_scheduled_payout": decoded["next_scheduled_payout"],
    };
  }

  // ---------- LOCATION ----------
  /// Update the current user's general location (not booking-specific).
  /// For providers: also updates ServiceProvider.location_latitude/longitude.
  /// Endpoint: POST /api/users/me/location/
  static Future<Map<String, dynamic>?> updateMyLocation({
    required double latitude,
    required double longitude,
  }) async {
    final response = await _authorizedRequest(
      'POST',
      '/api/users/me/location/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'latitude': latitude,
        'longitude': longitude,
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    return null;
  }

  static Future<bool> updateLocation({
    required int bookingId,
    required double latitude,
    required double longitude,
    required bool isProvider,
  }) async {
    final response = await _authorizedRequest(
      'POST',
      '/api/location/update/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'booking_id': bookingId,
        'latitude': latitude,
        'longitude': longitude,
        'is_provider': isProvider,
      }),
    );
    return response.statusCode == 200;
  }

  static Future<Map<String, dynamic>?> getOtherPartyLocation(int bookingId) async {
    final response = await _authorizedRequest('GET', '/api/location/other_party/$bookingId/');
    if (response.statusCode == 200) return jsonDecode(response.body) as Map<String, dynamic>;
    return null;
  }

  // ---------- PROFILE PICTURE UPLOAD (MULTIPART) ----------

  static Future<Map<String, dynamic>?> uploadProfilePicture(File imageFile) async {
    Future<http.Response> sendOnce(String token) async {
      final uri = Uri.parse('$baseUrl/api/users/me/');
      final req = http.MultipartRequest('PATCH', uri);
      req.headers['Authorization'] = 'Bearer $token';
      req.headers['Accept'] = 'application/json';
      req.files.add(await http.MultipartFile.fromPath('profile_picture', imageFile.path));
      final streamed = await req.send();
      return http.Response.fromStream(streamed);
    }

    var access = await _getAccessToken();
    if (access == null || access.isEmpty) return null;

    var resp = await sendOnce(access);
    if (resp.statusCode == 401) {
      final ok = await _refreshAccessToken();
      if (!ok) return null;
      access = await _getAccessToken();
      if (access == null || access.isEmpty) return null;
      resp = await sendOnce(access);
    }

    if (resp.statusCode == 200) return jsonDecode(resp.body) as Map<String, dynamic>;
    return null;
  }

  static Future<Map<String, dynamic>?> uploadProfilePictureBytes({
    required Uint8List bytes,
    String filename = 'profile.jpg',
  }) async {
    Future<http.Response> sendOnce(String token) async {
      final uri = Uri.parse('$baseUrl/api/users/me/');
      final req = http.MultipartRequest('PATCH', uri);
      req.headers['Authorization'] = 'Bearer $token';
      req.headers['Accept'] = 'application/json';
      req.files.add(http.MultipartFile.fromBytes('profile_picture', bytes, filename: filename));
      final streamed = await req.send();
      return http.Response.fromStream(streamed);
    }

    var access = await _getAccessToken();
    if (access == null || access.isEmpty) return null;

    var resp = await sendOnce(access);
    if (resp.statusCode == 401) {
      final ok = await _refreshAccessToken();
      if (!ok) return null;
      access = await _getAccessToken();
      if (access == null || access.isEmpty) return null;
      resp = await sendOnce(access);
    }

    if (resp.statusCode == 200) return jsonDecode(resp.body) as Map<String, dynamic>;
    return null;
  }

  // ---------- DELETE PROFILE PICTURE ----------

  static Future<bool> deleteProfilePicture() async {
    final response = await _authorizedRequest('DELETE', '/api/users/me/profile_picture/');
    return response.statusCode >= 200 && response.statusCode < 300;
  }

  // ---------- NEARBY OPEN JOBS (15 MILES) ----------

  static Future<List<dynamic>?> getNearbyOpenJobs({
    required double userLat,
    required double userLng,
    double maxMiles = 15.0,
  }) async {
    final response = await _authorizedRequest(
      'GET',
      '/api/service_requests/open_jobs_nearby/?lat=$userLat&lng=$userLng&max_miles=$maxMiles',
    );
    if (response.statusCode == 200) return jsonDecode(response.body) as List<dynamic>;
    return null;
  }


  // ---------- LANGUAGE ----------

  static Future<void> saveLanguageCode(String code) async {
    try {
      await _secureStorage.write(key: 'language_code', value: code);
    } catch (_) {
      await _initPrefs();
      await _prefs.setString('language_code', code);
    }
  }

  static Future<String?> getLanguageCode() async {
    try {
      final v = await _secureStorage.read(key: 'language_code');
      if (v != null) return v;
    } catch (_) {}
    await _initPrefs();
    return _prefs.getString('language_code');
  }

  // ---------- PROVIDER PORTFOLIO (YOUR REAL ENDPOINTS) ----------

  static Future<List<dynamic>?> getMyPortfolioPosts() async {
    final response = await _authorizedRequest('GET', '/api/service_providers/me/portfolio/');

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is List) return decoded;
      return [];
    }

    // surface useful error in console
    try {
      final decoded = jsonDecode(response.body);
      print('getMyPortfolioPosts failed: ${response.statusCode} $decoded');
    } catch (_) {
      print('getMyPortfolioPosts failed: ${response.statusCode} ${response.body}');
    }

    return null;
  }

  static Future<int?> createPortfolioPost({String? caption, bool isPublic = false}) async {
    final response = await _authorizedRequest(
      'POST',
      '/api/service_providers/me/portfolio/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'caption': caption ?? '',
        'is_public': isPublic,
      }),
    );

    if (response.statusCode == 201) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map && decoded['post_id'] != null) {
        return int.tryParse(decoded['post_id'].toString());
      }
    }
    return null;
  }

  static Future<bool> uploadPortfolioMedia({
    required int postId,
    required XFile file,
  }) async {

    // Shorten the iOS image-picker filename to prevent backend varchar overflow
    final ext = p.extension(file.name).toLowerCase();  // e.g. '.jpg'
    final shortName = '${const Uuid().v4().split('-').first}$ext';

    Future<http.Response> sendOnce(String token) async {
      final uri = Uri.parse('$baseUrl/api/service_providers/me/portfolio/$postId/media/');
      final req = http.MultipartRequest('POST', uri);
      req.headers['Authorization'] = 'Bearer $token';
      req.headers['Accept'] = 'application/json';

      if (kIsWeb) {
        final bytes = await file.readAsBytes();
        req.files.add(http.MultipartFile.fromBytes('file', bytes, filename: shortName));
      } else {
        req.files.add(await http.MultipartFile.fromPath('file', file.path, filename: shortName));
      }

      final streamed = await req.send();
      return http.Response.fromStream(streamed);
    }

    var access = await _getAccessToken();
    if (access == null || access.isEmpty) return false;

    var resp = await sendOnce(access);

    if (resp.statusCode == 401) {
      final ok = await _refreshAccessToken();
      if (!ok) return false;
      access = await _getAccessToken();
      if (access == null || access.isEmpty) return false;
      resp = await sendOnce(access);
    }

    return resp.statusCode >= 200 && resp.statusCode < 300;
  }

  

  static Future<bool> deletePortfolioPost(int postId) async {
    final response = await _authorizedRequest('DELETE', '/api/service_providers/me/portfolio/$postId/');
    return response.statusCode >= 200 && response.statusCode < 300;
  }

  // =============================================================================
  // PASSWORD RESET METHODS
  // =============================================================================

  /// Request a password reset code to be sent to the user's email
  /// POST /api/auth/password/reset/request/
  static Future<Map<String, dynamic>> requestPasswordReset(String email) async {
    final url = Uri.parse('$baseUrl/api/auth/password/reset/request/');
  
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email.trim().toLowerCase()}),
      );
    
      final data = jsonDecode(response.body) as Map<String, dynamic>;
    
      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': data['message'] ?? 'Reset code sent if email exists.',
          'expires_in_minutes': data['expires_in_minutes'] ?? 15,
        };
      } else if (response.statusCode == 429) {
        return {
          'success': false,
          'message': data['detail'] ?? 'Too many requests. Please try again later.',
        };
      } else {
        return {
          'success': false,
          'message': data['detail'] ?? 'Failed to request password reset.',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error. Please check your connection.',
      };
    }
  }

  /// Confirm password reset with the code and new password
  /// POST /api/auth/password/reset/confirm/
  static Future<Map<String, dynamic>> confirmPasswordReset({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    final url = Uri.parse('$baseUrl/api/auth/password/reset/confirm/');
  
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email.trim().toLowerCase(),
          'code': code.trim(),
          'new_password': newPassword,
        }),
      );
    
      final data = jsonDecode(response.body) as Map<String, dynamic>;
    
      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': data['message'] ?? 'Password reset successfully.',
        };
      } else {
        return {
          'success': false,
          'message': data['detail'] ?? 'Failed to reset password.',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error. Please check your connection.',
      };
    }
  }

  /// Resend a new password reset code (invalidates old one)
  /// POST /api/auth/password/reset/resend/
  static Future<Map<String, dynamic>> resendPasswordResetCode(String email) async {
    final url = Uri.parse('$baseUrl/api/auth/password/reset/resend/');
  
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email.trim().toLowerCase()}),
      );
    
      final data = jsonDecode(response.body) as Map<String, dynamic>;
    
      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': data['message'] ?? 'New reset code sent if email exists.',
          'expires_in_minutes': data['expires_in_minutes'] ?? 15,
        };
      } else if (response.statusCode == 429) {
        return {
          'success': false,
          'message': data['detail'] ?? 'Too many requests. Please try again later.',
        };
      } else {
        return {
          'success': false,
          'message': data['detail'] ?? 'Failed to resend code.',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error. Please check your connection.',
      };
    }
  }

  /// Request username reminder via email
  /// POST /api/auth/username/remind/
  static Future<Map<String, dynamic>> requestUsernameReminder(String email) async {
    final url = Uri.parse('$baseUrl/api/auth/username/remind/');
  
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email.trim().toLowerCase()}),
      );
    
      final data = jsonDecode(response.body) as Map<String, dynamic>;
    
      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': data['detail'] ?? 'Username sent if email exists.',
        };
      } else {
        return {
          'success': false,
          'message': data['detail'] ?? 'Failed to send username reminder.',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error. Please check your connection.',
      };
    }
  }

  // ---------- PROVIDER CERTIFICATIONS ----------

  /// Get all certifications for the current provider
  static Future<Map<String, dynamic>?> getMyCertifications() async {
    final response = await _authorizedRequest('GET', '/api/service_providers/my_certifications/');
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    }
    return null;
  }

  /// Add a new certification
  /// Returns: { "certification": {...}, "trust_score": 65, "current_tier": "standard" }
  static Future<Map<String, dynamic>?> addCertification({
    required String name,
    String? issuingOrganization,
    Uint8List? documentBytes,
    String? documentName,
    String? issueDate,
    String? expiryDate,
    List<String>? certifiedServiceTypes,
  }) async {
    Future<http.Response> sendOnce(String token) async {
      final uri = Uri.parse('$baseUrl/api/service_providers/add_certification/');
      final req = http.MultipartRequest('POST', uri);
      req.headers['Authorization'] = 'Bearer $token';
      req.headers['Accept'] = 'application/json';

      req.fields['name'] = name;
      if (issuingOrganization != null && issuingOrganization.isNotEmpty) {
        req.fields['issuing_organization'] = issuingOrganization;
      }
      if (issueDate != null && issueDate.isNotEmpty) {
        req.fields['issue_date'] = issueDate;
      }

      if (expiryDate != null && expiryDate.isNotEmpty) {
        req.fields['expiry_date'] = expiryDate;
      }

      // Send linked service types as JSON string
      if (certifiedServiceTypes != null && certifiedServiceTypes.isNotEmpty) {
        req.fields['certified_service_types'] = jsonEncode(certifiedServiceTypes);
      }

      if (documentBytes != null && documentName != null) {
        // Determine content type from file extension
        String contentType = 'application/octet-stream';
        final ext = documentName.toLowerCase().split('.').last;
        switch (ext) {
          case 'pdf':
            contentType = 'application/pdf';
            break;
          case 'jpg':
          case 'jpeg':
            contentType = 'image/jpeg';
            break;
          case 'png':
            contentType = 'image/png';
            break;
          case 'doc':
            contentType = 'application/msword';
            break;
          case 'docx':
            contentType = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
            break;
        }
        
        req.files.add(http.MultipartFile.fromBytes(
          'document',
          documentBytes,
          filename: documentName,
          contentType: MediaType.parse(contentType),
        ));
      }

      final streamed = await req.send();
      return http.Response.fromStream(streamed);
    }

    var access = await _getAccessToken();
    if (access == null || access.isEmpty) return null;

    var resp = await sendOnce(access);

    if (resp.statusCode == 401) {
      final ok = await _refreshAccessToken();
      if (!ok) return null;
      access = await _getAccessToken();
      if (access == null || access.isEmpty) return null;
      resp = await sendOnce(access);
    }

    if (resp.statusCode == 201 || resp.statusCode == 200) {
      final decoded = jsonDecode(resp.body);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    }

    // Log error for debugging
    debugPrint('addCertification failed: ${resp.statusCode} ${resp.body}');

    return null;
  }

  /// Delete a certification
  static Future<Map<String, dynamic>?> deleteCertification(int certificationId) async {
    final response = await _authorizedRequest(
      'DELETE',
      '/api/service_providers/delete_certification/$certificationId/',
    );
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    }
    return null;
  }

  // ---------- REQUESTER REVIEWS (Provider rates User) ----------

  /// Submit a review for a requester after completing service
  static Future<Map<String, dynamic>?> submitRequesterReview({
    required int serviceRequestId,
    required int rating,
    String? comment,
  }) async {
    final response = await _authorizedRequest(
      'POST',
      '/api/requester_reviews/',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'service_request_id': serviceRequestId,
        'rating': rating,
        'comment': comment ?? '',
      }),
    );
    
    if (response.statusCode == 201) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    }
    return null;
  }

  /// Check if provider has already reviewed requester for a booking
  static Future<Map<String, dynamic>?> checkRequesterReview(int bookingId) async {
    final response = await _authorizedRequest(
      'GET',
      '/api/requester_reviews/for_booking/?booking_id=$bookingId',
    );
    
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    }
    return null;
  }

  // ---------- USER REPUTATION (Reviews from Providers) ----------

  /// Get the current user's reputation - reviews written by providers about them
  /// Returns: { "average_rating": 4.5, "total_reviews": 12, "reviews": [...] }
  static Future<Map<String, dynamic>?> getMyReputation() async {
    final response = await _authorizedRequest('GET', '/api/requester_reviews/my-reputation/');
  
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    }
    return null;
  }

  /// Get a specific user's reputation (for providers viewing requesters)
  static Future<Map<String, dynamic>?> getUserReputation(int userId) async {
    final response = await _authorizedRequest('GET', '/api/requester_reviews/user-reputation/$userId/');
    
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    }
    return null;
  }
}