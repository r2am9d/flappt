import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flappt/core/mixins/index.dart';
import 'package:flappt/core/utils/index.dart';
import 'package:meta/meta.dart';

part 'shell_event.dart';
part 'shell_state.dart';

class ShellBloc extends Bloc<ShellEvent, ShellState>
    with MultiStateMixin<ShellEvent, ShellState> {
  ShellBloc() : super(ShellInitial()) {
    // Event handlers
    on<ShellSetLoading>(_setLoading, transformer: sequential());
    on<ShellSetError>(_setError, transformer: sequential());

    // Hold state
    holdState(() => const ShellLoading());
    holdState(() => const ShellError());
  }

  FutureOr<void> _setLoading(
    ShellSetLoading event,
    Emitter<ShellState> emit,
  ) async {
    try {
      emit(ShellLoading(loading: event.loading));
    } on Exception catch (e, stackTrace) {
      AppLog.e(
        'Error during _setLoading: $e',
        error: e,
        trace: stackTrace,
      );
    }
  }

  FutureOr<void> _setError(
    ShellSetError event,
    Emitter<ShellState> emit,
  ) async {
    try {
      emit(ShellError(message: event.message));
    } on Exception catch (e, stackTrace) {
      AppLog.e(
        'Error during _setError: $e',
        error: e,
        trace: stackTrace,
      );
    }
  }
}
