import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';

/// A powerful mixin that allows the usage of different states in a Bloc.
/// All states are registered using Bloc's [onChange] method.
mixin MultiStateMixin<BaseEvent, BaseState> on Bloc<BaseEvent, BaseState> {
  final List<BaseState> _states = [];

  @override
  void onChange(Change<BaseState> change) {
    super.onChange(change);
    holdState(() => change.nextState);
  }

  /// Puts an instance of [BaseState] in memory.
  void holdState(BaseState Function() instantiate) {
    final instance = instantiate.call();
    final reference = _findStateInstance(instance);

    if (reference != null) {
      final index = _states.indexOf(reference);
      _states[index] = instance;
    } else {
      _states.add(instance);
    }
  }

  /// Retrieves an instance of [ConcreteState].
  ConcreteState? states<ConcreteState extends BaseState>() =>
      _findStateByType<ConcreteState>();

  ConcreteState? _findStateByType<ConcreteState extends BaseState>() =>
      _states.whereType<ConcreteState>().firstOrNull;

  BaseState? _findStateInstance(BaseState state) =>
      _states.firstWhereOrNull((e) => e.runtimeType == state.runtimeType);
}
