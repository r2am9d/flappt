import 'package:flappt/core/shared/index.dart';

abstract class AuthRepository {
  Future<User> login(String username, String password);
  Future<void> logout();
  Future<User> getUser();
  Future<void> saveUser(User user);
}
