import 'package:flappt/core/config/index.dart';
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
    if (username != defaultUser.username || password != defaultUser.password) {
      throw PersistenceException.invalidCredentials();
    }

    final userModel = UserModel.fromEntity(defaultUser);
    await saveUser(userModel);

    return userModel;
  }

  @override
  Future<UserModel> getUser() async {
    final userDataJson = prefs.getString('default_user');
    if (userDataJson == null) {
      throw PersistenceException.userNotFound();
    }

    return UserModelMapper.fromJson(userDataJson);
  }

  @override
  Future<void> logout() async {
    final success = await prefs.remove('default_user');
    if (!success) {
      throw PersistenceException.logoutFailed();
    }
  }

  @override
  Future<void> saveUser(UserModel user) async {
    final success = await prefs.setString(
      'default_user',
      user.toJson(),
    );

    if (!success) {
      throw PersistenceException.saveFailed();
    }
  }
}
