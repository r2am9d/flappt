import 'package:flappt/core/base/index.dart';
import 'package:flappt/core/shared/infra/auth/index.dart';

class AuthGetUserUsecase implements UseCase<User, NoParams> {
  AuthGetUserUsecase({
    required this.authRepository,
  });

  final AuthRepository authRepository;

  @override
  Future<User> execute(NoParams params) async {
    return authRepository.getUser();
  }
}
