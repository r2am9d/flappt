// ignore_for_file: avoid_print, document_ignores

import 'dart:io';
import 'package:watcher/watcher.dart';

void main() {
  final arbDir = Directory('lib/core/l10n/arb');

  if (!arbDir.existsSync()) {
    print('❌ Directory lib/l10n does not exist.');
    exit(1);
  }

  print('👀 Watching ${arbDir.path} for .arb changes...');
  final watcher = DirectoryWatcher(arbDir.path);

  Future<void> runGenL10n() async {
    print('🔁 Running: flutter gen-l10n');
    final result = await Process.run('flutter', ['gen-l10n']);
    if (result.stdout.toString().isNotEmpty) {
      print(result.stdout);
    }
    if (result.stderr.toString().isNotEmpty) {
      print(result.stderr);
    }
  }

  watcher.events.listen((event) {
    if (event.path.endsWith('.arb')) {
      print('📝 Change detected: ${event.path}');
      runGenL10n();
    }
  });

  runGenL10n();
}
