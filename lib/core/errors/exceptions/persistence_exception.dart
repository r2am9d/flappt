import 'package:flappt/core/errors/index.dart';

class PersistenceException extends AppException {
  const PersistenceException({
    required super.message,
    super.code,
  });

  factory PersistenceException.invalidCredentials() {
    return const PersistenceException(
      message: 'Invalid username or password.',
      code: 'PST_001',
    );
  }

  factory PersistenceException.userNotFound() {
    return const PersistenceException(
      message: 'No user data found.',
      code: 'PST_002',
    );
  }
}
