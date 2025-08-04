import 'package:flappt/core/keys/app_key.dart';
import 'package:flappt/core/shared/index.dart';
import 'package:flappt/features/home/index.dart';
import 'package:flappt/features/login/index.dart';
import 'package:flappt/features/profile/index.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  navigatorKey: AppKey.routerKey,
  initialLocation: '/login',
  routes: <RouteBase>[
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          ShellWidget(navigationShell: navigationShell),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
