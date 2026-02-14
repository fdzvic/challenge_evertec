import 'package:challenge_evertec/core/storage/local_storage_service.dart';
class ThemeLocalDataSource {

  ThemeLocalDataSource(this.storage);
  final LocalStorageService storage;

  static const _key = 'app_theme';

  Future<void> saveTheme(String mode) async {
    await storage.setString(_key, mode);
  }

  String? getTheme() {
    return storage.getString(_key);
  }
}
