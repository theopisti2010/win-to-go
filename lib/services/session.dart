import 'package:shared_preferences/shared_preferences.dart';
import '../models/role.dart';

class SessionService {
  static const _kRole = 'selectedRole';
  static const _kHasOnboarded = 'hasOnboarded';
  static final SessionService _instance = SessionService._internal();
  SessionService._internal();
  factory SessionService() => _instance;

  Future<UserRole> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    final v = prefs.getString(_kRole);
    return UserRoleX.fromStorage(v);
  }

  Future<void> setRole(UserRole role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kRole, role.storageValue);
    await prefs.setBool(_kHasOnboarded, true);
  }

  Future<bool> get hasOnboarded async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kHasOnboarded) ?? false;
  }

  Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
