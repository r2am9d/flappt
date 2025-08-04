part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthVerifiedUser extends AuthState {
  const AuthVerifiedUser({
    this.user,
  });

  final User? user;

  @override
  List<Object?> get props => [user];
}

final class AuthLoading extends AuthState {
  const AuthLoading({
    this.loading = false,
  });

  final bool loading;

  @override
  List<Object> get props => [loading];
}

final class AuthError extends AuthState {
  const AuthError({
    this.message = '',
  });

  final String message;

  @override
  List<Object> get props => [message];
}
