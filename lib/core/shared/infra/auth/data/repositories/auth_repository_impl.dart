import 'package:flappt/core/shared/infra/auth/index.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required this.dataSource,
  });

  final AuthDataSource dataSource;

  @override
  Future<User> login(String username, String password) async {
    final user = await dataSource.login(username, password);
    return user.toEntity();
  }

  @override
  Future<void> logout() async {
    await dataSource.logout();
  }

  @override
  Future<User> getUser() async {
    final user = await dataSource.getUser();
    return user.toEntity();
  }

  @override
  Future<void> saveUser(User user) async {
    await dataSource.saveUser(
      UserModel.fromEntity(user),
    );
  }
}
