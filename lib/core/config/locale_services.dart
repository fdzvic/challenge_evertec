import 'dart:ui';

class LocaleService {
  String get currentLanguageCode {
    final locale = PlatformDispatcher.instance.locale;

    if (locale.languageCode == 'es') {
      return 'es-CO';
    }
    return 'en-US';
  }
}
