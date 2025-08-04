import 'package:flappt/core/shared/infra/auth/index.dart';

abstract class AuthDataSource {
  Future<UserModel> login(String username, String password);
  Future<void> logout();
  Future<UserModel> getUser();
  Future<void> saveUser(UserModel user);
}
