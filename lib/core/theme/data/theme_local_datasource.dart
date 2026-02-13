import '../../storage/local_storage_service.dart';

class ThemeLocalDataSource {
  final LocalStorageService storage;

  static const _key = 'app_theme';

  ThemeLocalDataSource(this.storage);

  Future<void> saveTheme(String mode) async {
    await storage.setString(_key, mode);
  }

  String? getTheme() {
    return storage.getString(_key);
  }
}
