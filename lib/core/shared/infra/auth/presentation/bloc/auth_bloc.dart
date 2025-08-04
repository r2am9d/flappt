import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flappt/core/mixins/index.dart';
import 'package:flappt/core/shared/index.dart';
import 'package:flappt/core/utils/index.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>
    with MultiStateMixin<AuthEvent, AuthState> {
  AuthBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.saveUserUseCase,
    // required this.authRepository,
  }) : super(AuthInitial()) {
    // Event handlers
    on<AuthExecuteLogin>(_executeLogin, transformer: sequential());
    on<AuthExecuteLogout>(_executeLogout, transformer: sequential());
    on<AuthSaveUser>(_saveUser, transformer: sequential());

    // Hold State
    holdState(() => const AuthVerifiedUser());
    holdState(() => const AuthLoading());
    holdState(() => const AuthError());
  }

  final AuthLoginUsecase loginUseCase;
  final AuthLogoutUsecase logoutUseCase;
  final AuthSaveUserUseCase saveUserUseCase;
  // final AuthRepository authRepository;

  FutureOr<void> _executeLogin(
    AuthExecuteLogin event,
    Emitter<AuthState> emit,
  ) async {
    try {
      // Simulate a login process
      final username = event.username;
      final password = event.password;

      // Simulate network delay
      emit(const AuthLoading(loading: true));
      await Future<void>.delayed(const Duration(seconds: 2));

      final user = await loginUseCase.execute(username, password);

      emit(const AuthLoading());
      emit(AuthVerifiedUser(user: user));
    } on Exception catch (e, stackTrace) {
      AppLog.e(
        'Error during executeLogin: $e',
        error: e,
        trace: stackTrace,
      );
      emit(const AuthLoading());
      emit(AuthError(message: e.toString()));
    }
  }

  FutureOr<void> _executeLogout(
    AuthExecuteLogout event,
    Emitter<AuthState> emit,
  ) async {
    try {
      // Simulate network delay
      emit(const AuthLoading(loading: true));
      await Future<void>.delayed(const Duration(seconds: 2));

      await logoutUseCase.execute();

      // Set the user to null after logout
      emit(const AuthLoading());
      emit(const AuthVerifiedUser());
    } on Exception catch (e, stackTrace) {
      AppLog.e(
        'Error during executeLogout: $e',
        error: e,
        trace: stackTrace,
      );
      emit(const AuthLoading());
      emit(AuthError(message: e.toString()));
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
        'Error during saveUser: $e',
        error: e,
        trace: stackTrace,
      );
      emit(const AuthLoading());
      emit(AuthError(message: e.toString()));
    }
  }
}
