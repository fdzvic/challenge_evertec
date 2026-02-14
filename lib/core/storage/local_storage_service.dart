import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorageService {
  Future<void> setString(String key, String value);
  String? getString(String key);
  Future<void> setBool(String key, bool value);
  bool? getBool(String key);
  Future<void> remove(String key);
}

class LocalStorageServiceImpl implements LocalStorageService {

  LocalStorageServiceImpl(this.prefs);
  final SharedPreferences prefs;

  @override
  Future<void> setString(String key, String value) async {
    await prefs.setString(key, value);
  }

  @override
  String? getString(String key) {
    return prefs.getString(key);
  }

  @override
  Future<void> setBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  @override
  bool? getBool(String key) {
    return prefs.getBool(key);
  }

  @override
  Future<void> remove(String key) async {
    await prefs.remove(key);
  }
}
