import 'package:flappt/core/base/index.dart';
import 'package:flappt/core/shared/infra/auth/index.dart';

class AuthLogoutUsecase implements UseCase<void, NoParams> {
  AuthLogoutUsecase({
    required this.authRepository,
  });

  final AuthRepository authRepository;

  @override
  Future<void> execute(NoParams params) async {
    await authRepository.logout();
  }
}
