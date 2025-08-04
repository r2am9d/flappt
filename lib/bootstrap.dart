import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flappt/core/di/injection.dart';
import 'package:flappt/core/theme/app_theme.dart';
import 'package:flappt/core/utils/index.dart';
import 'package:flutter/material.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (err) {
    AppLog.e(
      err.exceptionAsString(),
      error: err,
      trace: err.stack,
    );
  };

  Bloc.observer = const AppBlocObserver();

  // Initialize theme
  AppTheme.initialize();

  // Setup dependencies
  await setupDependencies();

  runApp(await builder());
}
