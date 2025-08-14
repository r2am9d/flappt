import 'package:flappt/core/errors/index.dart';

class ValidationException extends AppException {
  const ValidationException({
    required super.message,
    super.code,
  });

  factory ValidationException.invalidFormat(String attribute) {
    return ValidationException(
      message: '$attribute is invalid format.',
      code: 'VAL_001',
    );
  }

  factory ValidationException.emptyField(String attribute) {
    return ValidationException(
      message: '$attribute cannot be empty.',
      code: 'VAL_002',
    );
  }

  factory ValidationException.greaterThanZero(String attribute) {
    return ValidationException(
      message: '$attribute must be greater than zero.',
      code: 'VAL_003',
    );
  }

  factory ValidationException.nonNegative(String attribute) {
    return ValidationException(
      message: '$attribute must be non-negative.',
      code: 'VAL_004',
    );
  }
}
