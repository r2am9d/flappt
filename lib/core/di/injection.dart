import 'package:dio/dio.dart';
import 'package:flappt/core/modules/index.dart';
import 'package:flappt/core/shared/index.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDependencies() async {
  const uuid = Uuid();
  final prefs = await SharedPreferences.getInstance();
  final dio = Dio()
    ..options = BaseOptions(
      baseUrl: 'https://api.example.com',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

  // Register external dependencies
  getIt
    ..registerSingleton<Uuid>(uuid)
    ..registerSingleton<SharedPreferences>(prefs)
    ..registerSingleton<Dio>(dio);

  // Register application dependencies. Add below as needed.
  _shellDependencies();
  _authDependencies(prefs);
}

void _shellDependencies() {
  getIt.registerLazySingleton<ShellBloc>(ShellBloc.new);
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
    ..registerLazySingleton<AuthLoginUseCase>(
      () => AuthLoginUseCase(
        authRepository: getIt<AuthRepository>(),
      ),
    )
    ..registerLazySingleton<AuthLogoutUseCase>(
      () => AuthLogoutUseCase(
        authRepository: getIt<AuthRepository>(),
      ),
    )
    ..registerLazySingleton<AuthSaveUserUseCase>(
      () => AuthSaveUserUseCase(
        authRepository: getIt<AuthRepository>(),
      ),
    )
    ..registerLazySingleton<AuthGetUserUseCase>(
      () => AuthGetUserUseCase(
        authRepository: getIt<AuthRepository>(),
      ),
    )
    ..registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        loginUseCase: getIt<AuthLoginUseCase>(),
        logoutUseCase: getIt<AuthLogoutUseCase>(),
        saveUserUseCase: getIt<AuthSaveUserUseCase>(),
        getUserUseCase: getIt<AuthGetUserUseCase>(),
      ),
    );
}
