import 'package:flappt/core/config/index.dart';
import 'package:flappt/core/di/injection.dart';
import 'package:flappt/core/l10n/l10n.dart';
import 'package:flappt/core/router/app_router.dart';
import 'package:flappt/core/shared/index.dart';
import 'package:flappt/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<AuthBloc>()..add(const AuthSaveUser(user: defaultUser)),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        theme: AppTheme.instance.lightTheme,
        darkTheme: AppTheme.instance.darkTheme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
