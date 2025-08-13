part of 'shell_bloc.dart';

@immutable
sealed class ShellEvent extends Equatable {
  const ShellEvent();

  @override
  List<Object> get props => [];
}

final class ShellSetLoading extends ShellEvent {
  const ShellSetLoading({
    required this.loading,
  });

  final bool loading;
}

final class ShellSetError extends ShellEvent {
  const ShellSetError({
    required this.message,
  });

  final String message;
}
