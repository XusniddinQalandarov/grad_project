import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../domain/entities/app_user.dart';

/// Local data source for caching user data
class AuthLocalDataSource {
  static const String _userKey = 'cached_user';

  final SharedPreferences _prefs;

  AuthLocalDataSource(this._prefs);

  /// Save user to local storage
  Future<void> saveUser(AppUser user) async {
    final userJson = jsonEncode(user.toJson());
    await _prefs.setString(_userKey, userJson);
  }

  /// Get cached user
  AppUser? getCachedUser() {
    final userJson = _prefs.getString(_userKey);
    if (userJson == null) return null;

    try {
      final userMap = jsonDecode(userJson) as Map<String, dynamic>;
      return AppUser.fromJson(userMap);
    } catch (e) {
      return null;
    }
  }

  /// Clear cached user
  Future<void> clearUser() async {
    await _prefs.remove(_userKey);
  }
}
