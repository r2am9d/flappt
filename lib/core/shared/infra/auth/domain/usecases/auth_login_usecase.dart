import 'package:flappt/core/shared/infra/auth/index.dart';

class AuthLoginUsecase {
  AuthLoginUsecase({
    required this.authRepository,
  });

  final AuthRepository authRepository;

  Future<User> execute(String username, String password) async {
    return authRepository.login(username, password);
  }
}
