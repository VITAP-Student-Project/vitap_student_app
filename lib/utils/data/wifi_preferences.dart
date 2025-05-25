import 'package:shared_preferences/shared_preferences.dart';

class WifiPreferencesService {
  static const String _usernameKey = 'wifi_username';
  static const String _passwordKey = 'wifi_password';
  static const String _rememberMeKey = 'remember_me';

  static Future<void> saveCredentials(
      {required String username,
      required String password,
      required bool rememberMe}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
    await prefs.setString(_passwordKey, password);
    await prefs.setBool(_rememberMeKey, rememberMe);
  }

  static Future<Map<String, dynamic>> getCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'username': prefs.getString(_usernameKey) ?? '',
      'password': prefs.getString(_passwordKey) ?? '',
      'rememberMe': prefs.getBool(_rememberMeKey) ?? false
    };
  }

  static Future<void> clearCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_usernameKey);
    await prefs.remove(_passwordKey);
    await prefs.remove(_rememberMeKey);
  }
}
