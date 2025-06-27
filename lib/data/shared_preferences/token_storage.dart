import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    print('💾 TokenStorage - Token guardado: ${token.length} caracteres');
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    print('💾 TokenStorage - Token eliminado');
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    print(
      '💾 TokenStorage - Token recuperado: ${token != null ? "Presente (${token.length} chars)" : "No encontrado"}',
    );
    return token;
  }

  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
  }

  Future<void> saveUserData(String userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, userData);
  }

  Future<String?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userKey);
  }

  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}

final tokenStorageProvider = Provider<TokenStorage>((ref) => TokenStorage());
