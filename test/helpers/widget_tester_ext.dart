import 'package:flappt/core/l10n/l10n.dart';
import 'package:flappt/core/modules/index.dart';
import 'package:flappt/features/login/presentation/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterExt on WidgetTester {
  /// Pumps a widget wrapped in MaterialApp with proper theme and localization
  Future<void> pumpApp(Widget widget) {
    return pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: widget),
      ),
    );
  }

  /// Pumps widget and waits for all animations to settle
  Future<void> pumpAppAndSettle(Widget widget) async {
    await pumpApp(widget);
    await pumpAndSettle();
  }

  /// Pumps a widget with BLoC providers wrapped in MaterialApp
  Future<void> pumpAppWithBlocs(
    Widget widget, {
    List<BlocProvider> providers = const [],
  }) {
    return pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: providers.isEmpty
            ? widget
            : MultiBlocProvider(
                providers: providers,
                child: widget,
              ),
      ),
    );
  }

  /// Pumps widget with BLoCs and waits for all animations to settle
  Future<void> pumpAppWithBlocsAndSettle(
    Widget widget, {
    List<BlocProvider> providers = const [],
  }) async {
    await pumpAppWithBlocs(widget, providers: providers);
    await pumpAndSettle();
  }

  /// Convenience method for pumping LoginPage with AuthBloc
  Future<void> pumpLoginPage(AuthBloc authBloc) {
    return pumpAppWithBlocsAndSettle(
      const LoginPage(),
      providers: [
        BlocProvider<AuthBloc>.value(value: authBloc),
      ],
    );
  }

  /// Expects a widget of specific type to exist
  void expectWidgetExists<T extends Widget>() {
    expect(find.byType(T), findsOneWidget);
  }

  /// Expects text to be displayed
  void expectText(String text) {
    expect(find.text(text), findsOneWidget);
  }

  /// Expects an icon to be displayed
  void expectIcon(IconData icon) {
    expect(find.byIcon(icon), findsOneWidget);
  }

  /// Expects a container with specific decoration properties
  void expectContainer({
    double? width,
    double? height,
    BorderRadius? borderRadius,
  }) {
    final containerFinder = find.byType(Container);
    expect(containerFinder, findsAtLeastNWidgets(1));

    if (width != null || height != null) {
      final container = widget<Container>(containerFinder.first);
      final constraints = container.constraints;
      if (width != null && constraints != null) {
        expect(constraints.maxWidth, equals(width));
      }
      if (height != null && constraints != null) {
        expect(constraints.maxHeight, equals(height));
      }
    }
  }

  /// Expects a specific number of widgets of a type
  void expectWidgetCount<T extends Widget>(int count) {
    expect(find.byType(T), findsNWidgets(count));
  }
}
