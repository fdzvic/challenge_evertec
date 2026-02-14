import 'dart:convert';
import 'dart:developer';
import 'package:challenge_evertec/core/config/app_config.dart';
import 'package:challenge_evertec/core/config/locale_services.dart';
import 'package:challenge_evertec/core/error/exceptions/network_exceptions.dart';
import 'package:http/http.dart' as http;


class HttpClientService {
  HttpClientService(this.localeService);
  final LocaleService localeService;

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? query,
  }) async {
    final params = {
      'api_key': AppConfig.apiKey,
      'language': localeService.currentLanguageCode,
      ...?query,
    };

    final uri = Uri.parse(
      '${AppConfig.baseUrl}$endpoint',
    ).replace(queryParameters: params);

    log(uri.toString());

    try {
      final response = await http.get(uri);

      final decoded = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return decoded;
      }

      throw NetworkException(decoded['status_message'] ?? 'Server error');
    } catch (e) {
      throw NetworkException('No internet connection');
    }
  }
}
