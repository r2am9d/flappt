import 'dart:developer';

import 'package:logger/logger.dart';

class AdvancedConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    final buffer = StringBuffer();
    event.lines.forEach(buffer.writeln);
    log(buffer.toString());
  }
}

class AppLog {
  factory AppLog() => _instance;

  AppLog._internal();

  static final AppLog _instance = AppLog._internal();
  static final Logger _logger = Logger(
    filter: DevelopmentFilter(),
    printer: PrettyPrinter(
      printEmojis: false,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
      stackTraceBeginIndex: 1,
      levelColors: {
        // ANSI 249
        Level.debug: AnsiColor.fg(AnsiColor.grey(.75)),
      },
    ),
    output: AdvancedConsoleOutput(),
  );

  static void d(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? trace,
  }) {
    _logger.d(
      message,
      time: time,
      error: error,
      stackTrace: trace,
    );
  }

  static void w(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? trace,
  }) {
    _logger.w(
      message,
      time: time,
      error: error,
      stackTrace: trace,
    );
  }

  static void e(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? trace,
  }) {
    _logger.e(
      message,
      time: time,
      error: error,
      stackTrace: trace,
    );
  }
}
