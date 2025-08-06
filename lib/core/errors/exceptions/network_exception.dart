import 'package:flappt/core/errors/index.dart';

class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    super.code,
  });

  factory NetworkException.noConnection() {
    return const NetworkException(
      message: 'No internet connection.',
      code: 'NET_001',
    );
  }

  factory NetworkException.timeout() {
    return const NetworkException(
      message: 'Request timeout.',
      code: 'NET_002',
    );
  }
}
