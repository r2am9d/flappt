import 'package:bloc/bloc.dart';
import 'package:flappt/core/utils/app_log.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    AppLog.d('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    AppLog.e(
      'onError(${bloc.runtimeType})',
      error: error,
      trace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }
}
