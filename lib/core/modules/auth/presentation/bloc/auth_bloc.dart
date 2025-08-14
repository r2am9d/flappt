import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flappt/core/base/index.dart';
import 'package:flappt/core/di/injection.dart';
import 'package:flappt/core/mixins/index.dart';
import 'package:flappt/core/modules/index.dart';
import 'package:flappt/core/shared/index.dart';
import 'package:flappt/core/utils/index.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>
    with MultiStateMixin<AuthEvent, AuthState> {
  AuthBloc({
    // required this.authRepository,
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.saveUserUseCase,
    required this.getUserUseCase,
  }) : super(AuthInitial()) {
    // Event handlers
    on<AuthExecuteLogin>(
      _executeLogin,
      transformer: sequential(),
    );
    on<AuthExecuteLogout>(
      _executeLogout,
      transformer: sequential(),
    );
    on<AuthSaveUser>(
      _saveUser,
      transformer: sequential(),
    );
    on<AuthCheckSession>(
      _checkSession,
      transformer: sequential(),
    );

    // Hold State
    holdState(() => const AuthVerifiedUser());
    holdState(() => const AuthLoading());
    holdState(() => const AuthError());

    // Check for existing session on startup
    add(const AuthCheckSession());
  }

  // final AuthRepository authRepository;
  final AuthLoginUseCase loginUseCase;
  final AuthLogoutUseCase logoutUseCase;
  final AuthSaveUserUseCase saveUserUseCase;
  final AuthGetUserUseCase getUserUseCase;

  FutureOr<void> _executeLogin(
    AuthExecuteLogin event,
    Emitter<AuthState> emit,
  ) async {
    try {
      // Simulate network delay
      emit(const AuthLoading(loading: true));
      await Future<void>.delayed(const Duration(seconds: 2));

      final user = await loginUseCase.execute(
        LoginParams(
          username: event.username,
          password: event.password,
        ),
      );

      emit(AuthVerifiedUser(user: user));
    } on Exception catch (e, stackTrace) {
      AppLog.e(
        'Error during _executeLogin: $e',
        error: e,
        trace: stackTrace,
      );
      emit(AuthError(message: e.toString()));
    }
  }

  FutureOr<void> _executeLogout(
    AuthExecuteLogout event,
    Emitter<AuthState> emit,
  ) async {
    final shellBloc = getIt<ShellBloc>();

    try {
      // Simulate network delay
      shellBloc.add(const ShellSetLoading(loading: true));
      await Future<void>.delayed(const Duration(seconds: 2));

      await logoutUseCase.execute(const NoParams());

      // Set the user to null after logout
      emit(const AuthVerifiedUser());
    } on Exception catch (e, stackTrace) {
      AppLog.e(
        'Error during _executeLogout: $e',
        error: e,
        trace: stackTrace,
      );
      shellBloc.add(ShellSetError(message: e.toString()));
    } finally {
      shellBloc.add(const ShellSetLoading(loading: false));
    }
  }

  FutureOr<void> _saveUser(
    AuthSaveUser event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final user = event.user;
      await saveUserUseCase.execute(user);
    } on Exception catch (e, stackTrace) {
      AppLog.e(
        'Error during _saveUser: $e',
        error: e,
        trace: stackTrace,
      );
      emit(AuthError(message: e.toString()));
    }
  }

  FutureOr<void> _checkSession(
    AuthCheckSession event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final user = await getUserUseCase.execute(const NoParams());
      emit(AuthVerifiedUser(user: user));
    } on Exception catch (e, stackTrace) {
      AppLog.d(
        '_checkSession: $e',
        trace: stackTrace,
      );
    }
  }
}
