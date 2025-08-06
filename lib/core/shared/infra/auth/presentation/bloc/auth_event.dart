part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class AuthExecuteLogin extends AuthEvent {
  const AuthExecuteLogin({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;
}

final class AuthExecuteLogout extends AuthEvent {
  const AuthExecuteLogout();
}

final class AuthSaveUser extends AuthEvent {
  const AuthSaveUser({
    required this.user,
  });

  final User user;
}
