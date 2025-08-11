import 'package:flappt/core/shared/infra/auth/index.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDependencies() async {
  final prefs = await SharedPreferences.getInstance();

  // Register external dependencies
  getIt.registerSingleton<SharedPreferences>(prefs);

  // Register application dependencies. Add below as needed.
  _authDependencies(prefs);
}

void _authDependencies(SharedPreferences prefs) {
  getIt
    ..registerLazySingleton<AuthDataSource>(
      () => AuthDataSourceImpl(prefs: prefs),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        dataSource: getIt<AuthDataSource>(),
      ),
    )
    ..registerLazySingleton<AuthLoginUsecase>(
      () => AuthLoginUsecase(
        authRepository: getIt<AuthRepository>(),
      ),
    )
    ..registerLazySingleton<AuthLogoutUsecase>(
      () => AuthLogoutUsecase(
        authRepository: getIt<AuthRepository>(),
      ),
    )
    ..registerLazySingleton<AuthSaveUserUsecase>(
      () => AuthSaveUserUsecase(
        authRepository: getIt<AuthRepository>(),
      ),
    )
    ..registerLazySingleton<AuthGetUserUsecase>(
      () => AuthGetUserUsecase(
        authRepository: getIt<AuthRepository>(),
      ),
    )
    ..registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        loginUseCase: getIt<AuthLoginUsecase>(),
        logoutUseCase: getIt<AuthLogoutUsecase>(),
        saveUserUseCase: getIt<AuthSaveUserUsecase>(),
        getUserUseCase: getIt<AuthGetUserUsecase>(),
      ),
    );
}
