abstract class AppException implements Exception {
  const AppException({
    required this.message,
    this.code = '',
  });

  final String message;
  final String code;

  @override
  String toString() => '$code: $message';
}
