import 'package:shared_preferences/shared_preferences.dart';

class CountdownStorage {
  static const _keyPrefix = 'countdown_';
  static final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static Future<void> saveCountdown(String id, DateTime dob) async {
    final prefs = await _prefs;
    final key = '$_keyPrefix$id';
    await prefs.setString(key, dob.toString());
  }

  static Future<DateTime?> getCountdown(String id) async {
    final prefs = await _prefs;
    final key = '$_keyPrefix$id';
    final dobString = prefs.getString(key);
    return dobString != null ? DateTime.parse(dobString) : null;
  }

  static Future<void> clearCountdown(String id) async {
    final prefs = await _prefs;
    final key = '$_keyPrefix$id';
    await prefs.remove(key);
  }
}