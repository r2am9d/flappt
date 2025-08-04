import 'package:flappt/core/shared/infra/auth/index.dart';

class AuthSaveUserUseCase {
  AuthSaveUserUseCase({
    required this.authRepository,
  });

  final AuthRepository authRepository;

  Future<void> execute(User user) async {
    await authRepository.saveUser(user);
  }
}
