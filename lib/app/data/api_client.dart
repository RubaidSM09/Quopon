// api_client.dart
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ApiClient {
  static const _base = 'https://intensely-optimal-unicorn.ngrok-free.app';
  static const _json = {'Content-Type': 'application/json'};

  static const _storage = FlutterSecureStorage();

  // Retrieve access token from secure storage
  static Future<String?> getAccessToken() async {
    return await _storage.read(key: 'access_token');
  }

  // Retrieve refresh token from secure storage
  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'refresh_token');
  }

  static Future<String?> getUserId() async {
    return await _storage.read(key: 'user_id');
  }

  static Future<Map<String, String>> authHeaders() async {
    String? token = await getAccessToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token ?? ''}',
    };
  }

  static Future<Map<String, String>> authHeadersFormData() async {
    String? token = await getAccessToken();
    return {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ${token ?? ''}',
    };
  }

  static Future<Map<String, String>> get basicHeaders async => {
    'Content-Type': 'application/json',
  };

  static Map<String, String> _mergeHeaders(
      Map<String, String>? headers, {
        String? authToken,
        String authScheme = 'Bearer ', // or 'Token' for DRF TokenAuth
      }) {
    final h = <String, String>{..._json, if (headers != null) ...headers};
    if ((authToken ?? '').isNotEmpty) {
      h['Authorization'] = '$authScheme $authToken';
    }
    return h;
  }

  static Future<http.Response> get(
      String path, {
        Map<String, String>? headers,
        String? authToken,
        String authScheme = 'Bearer',
      }) async {
    final uri = Uri.parse('$_base$path');
    return http.get(uri, headers: await authHeaders())
        .timeout(const Duration(seconds: 20));
  }

  static Future<http.Response> post(
      String path, Map<String, dynamic> body, {
        Map<String, String>? headers,
        String? authToken,
        String authScheme = 'Bearer',
      }) async {
    final uri = Uri.parse('$_base$path');
    return http.post(uri,
        headers: await authHeaders(),
        body: jsonEncode(body))
        .timeout(const Duration(seconds: 20));
  }

  static Future<http.Response> put(
      String path, Map<String, dynamic> body, {
        Map<String, String>? headers,
        String? authToken,
        String authScheme = 'Bearer',
      }) async {
    final uri = Uri.parse('$_base$path');
    return http.put(uri,
        headers: await authHeaders(),
        body: jsonEncode(body))
        .timeout(const Duration(seconds: 20));
  }

  /// ---------- NEW: Multipart upload (returns JSON body) ----------
  static Future<http.StreamedResponse> uploadMultipart({
    required String path,
    required String fieldName,
    required List<int> bytes,
    required String filename,
    String mimeType = 'image/jpeg',
    Map<String, String>? fields,
  }) async {
    final uri = Uri.parse('$_base$path');
    final token = await getAccessToken();

    final req = http.MultipartRequest('POST', uri);
    if (token != null && token.isNotEmpty) {
      req.headers['Authorization'] = 'Bearer $token';
    }
    req.headers['ngrok-skip-browser-warning'] = 'true';

    if (fields != null) {
      req.fields.addAll(fields);
    }

    req.files.add(http.MultipartFile.fromBytes(
      'image', // <-- force "image" here
      bytes,
      filename: filename,
      contentType: MediaType.parse(mimeType),
    ));

    return req.send();
  }
}
