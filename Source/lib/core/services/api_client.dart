import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

/// Exception khusus supaya UI bisa menampilkan pesan error dari backend PHP.
class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}

class ApiClient {
  static Future<Map<String, dynamic>> get(
    String path, {
    Map<String, String>? query,
  }) async {
    final res = await http.get(ApiConfig.uri(path, query));
    return _handleResponse(res);
  }

  static Future<Map<String, dynamic>> post(
    String path,
    Map<String, dynamic> body,
  ) async {
    final res = await http.post(
      ApiConfig.uri(path),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return _handleResponse(res);
  }

  static Map<String, dynamic> _handleResponse(http.Response res) {
    Map<String, dynamic> json;
    try {
      json = jsonDecode(res.body) as Map<String, dynamic>;
    } catch (_) {
      throw ApiException('Respons server tidak valid (${res.statusCode})');
    }

    if (json['success'] != true) {
      throw ApiException(json['message'] ?? 'Terjadi kesalahan pada server');
    }
    return json;
  }
}
