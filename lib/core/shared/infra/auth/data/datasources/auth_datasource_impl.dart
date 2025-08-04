import 'dart:convert';

import 'package:flappt/core/shared/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthDataSourceImpl implements AuthDataSource {
  const AuthDataSourceImpl({
    required this.prefs,
  });

  final SharedPreferences prefs;

  // Default user data for testing
  // {
  //   'id': 1,
  //   'username': 'jdoe',
  //   'password': 'jdoe123',
  //   'details': {
  //     'firstname': 'John',
  //     'lastname': 'Doe',
  //     'balance': 1500.00,
  //   },
  // }

  @override
  Future<UserModel> login(String username, String password) async {
    final userEntry = await getUser();
    return (username == userEntry.username && password == userEntry.password)
        ? userEntry
        : throw Exception('Invalid credentials.');
  }

  @override
  Future<UserModel> getUser() async {
    final userDataJson = prefs.getString('default_user');
    if (userDataJson == null) {
      throw Exception('No user data found.');
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
