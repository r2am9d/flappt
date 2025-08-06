import 'dart:convert';

import 'package:flappt/core/errors/index.dart';
import 'package:flappt/core/shared/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthDataSourceImpl implements AuthDataSource {
  const AuthDataSourceImpl({
    required this.prefs,
  });

  final SharedPreferences prefs;

  @override
  Future<UserModel> login(String username, String password) async {
    final userEntry = await getUser();
    if (username != userEntry.username || password != userEntry.password) {
      throw PersistenceException.invalidCredentials();
    }

    return userEntry;
  }

  @override
  Future<UserModel> getUser() async {
    final userDataJson = prefs.getString('default_user');
    if (userDataJson == null) {
      throw PersistenceException.userNotFound();
    }

    final userData = jsonDecode(userDataJson) as Map<String, dynamic>;
    return UserModel.fromJson(userData);
  }

  @override
  Future<void> logout() async {
    await prefs.remove('default_user');
  }

  @override
  Future<void> saveUser(UserModel user) async {
    await prefs.setString('default_user', jsonEncode(user.toJson()));
  }
}
