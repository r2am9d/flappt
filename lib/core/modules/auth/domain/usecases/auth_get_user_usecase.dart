import 'package:flappt/core/base/index.dart';
import 'package:flappt/core/modules/index.dart';

class AuthGetUserUseCase implements UseCase<User, NoParams> {
  AuthGetUserUseCase({
    required this.authRepository,
  });

  final AuthRepository authRepository;

  @override
  Future<User> execute(NoParams params) async {
    return authRepository.getUser();
  }
}
