import 'package:flappt/core/base/index.dart';
import 'package:flappt/core/errors/index.dart';
import 'package:flappt/core/modules/index.dart';

class AuthSaveUserUseCase implements UseCase<void, User> {
  AuthSaveUserUseCase({
    required this.authRepository,
  });

  final AuthRepository authRepository;

  @override
  Future<void> execute(User user) async {
    if (user.id <= 0) {
      throw ValidationException.greaterThanZero('id');
    }

    if (user.username.isEmpty) {
      throw ValidationException.emptyField('username');
    }

    if (user.password.isEmpty) {
      throw ValidationException.emptyField('password');
    }

    if (user.details.firstname.isEmpty) {
      throw ValidationException.emptyField('firstname');
    }

    if (user.details.lastname.isEmpty) {
      throw ValidationException.emptyField('lastname');
    }

    if (user.details.balance < 0) {
      throw ValidationException.nonNegative('balance');
    }

    await authRepository.saveUser(user);
  }
}
