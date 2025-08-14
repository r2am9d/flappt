import 'package:flappt/core/base/index.dart';
import 'package:flappt/core/modules/index.dart';

class AuthLogoutUseCase implements UseCase<void, NoParams> {
  AuthLogoutUseCase({
    required this.authRepository,
  });

  final AuthRepository authRepository;

  @override
  Future<void> execute(NoParams params) async {
    await authRepository.logout();
  }
}
