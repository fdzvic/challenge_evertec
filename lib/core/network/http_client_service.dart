import 'dart:convert';
import 'package:challenge_evertec/core/config/locale_services.dart';
import 'package:challenge_evertec/core/error/exceptions/network_exceptions.dart';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';

class HttpClientService {
  final LocaleService localeService;

  HttpClientService(this.localeService);

  Future<Map<String, dynamic>> get(String endpoint) async {
    final language = localeService.currentLanguageCode;

    final url = Uri.parse(
      '${AppConfig.baseUrl}$endpoint'
      '?api_key=${AppConfig.apiKey}'
      '&language=$language',
    );

    try {
      final response = await http.get(url);

      final decoded = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return decoded;
      }

      throw NetworkException(decoded['status_message'] ?? 'Error');
    } catch (e) {
      throw NetworkException('No internet connection');
    }
  }
}
