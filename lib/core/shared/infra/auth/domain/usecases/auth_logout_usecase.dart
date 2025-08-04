import 'package:flappt/core/shared/infra/auth/index.dart';

class AuthLogoutUsecase {
  AuthLogoutUsecase({
    required this.authRepository,
  });

  final AuthRepository authRepository;

  Future<void> execute() async {
    await authRepository.logout();
  }
}
