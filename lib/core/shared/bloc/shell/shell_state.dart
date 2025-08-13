part of 'shell_bloc.dart';

@immutable
sealed class ShellState extends Equatable {
  const ShellState();

  @override
  List<Object> get props => [];
}

final class ShellInitial extends ShellState {}

final class ShellLoading extends ShellState {
  const ShellLoading({
    this.loading = false,
  });

  final bool loading;

  @override
  List<Object> get props => [loading];
}

final class ShellError extends ShellState {
  const ShellError({
    this.message = '',
  });

  final String message;

  @override
  List<Object> get props => [message];
}
