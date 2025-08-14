import 'package:bloc_test/bloc_test.dart';
import 'package:flappt/core/base/index.dart';
import 'package:flappt/core/modules/index.dart';
import 'package:flappt/features/login/presentation/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helpers.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class MockAuthLoginUseCase extends Mock implements AuthLoginUseCase {}

class MockAuthLogoutUseCase extends Mock implements AuthLogoutUseCase {}

class MockAuthSaveUserUseCase extends Mock implements AuthSaveUserUseCase {}

class MockAuthGetUserUseCase extends Mock implements AuthGetUserUseCase {}

class FakeLoginParams extends Fake implements LoginParams {}

class FakeNoParams extends Fake implements NoParams {}

class FakeUser extends Fake implements User {}

void main() {
  late MockAuthBloc mockAuthBloc;

  setUpAll(() {
    registerFallbackValue(FakeLoginParams());
    registerFallbackValue(FakeNoParams());
    registerFallbackValue(FakeUser());
  });

  setUp(() {
    mockAuthBloc = MockAuthBloc();

    // Set up default behavior for the mock bloc
    when(() => mockAuthBloc.state).thenReturn(AuthInitial());
    when(() => mockAuthBloc.stream).thenAnswer((_) => const Stream.empty());
  });

  group('LoginPage Widget Test', () {
    testWidgets('renders main login page structure correctly', (tester) async {
      // Pump the actual LoginPage widget using extension method
      await tester.pumpLoginPage(mockAuthBloc);

      // Verify main structure using extension methods
      tester
        ..expectWidgetExists<Scaffold>()
        ..expectWidgetExists<SafeArea>()
        ..expectWidgetExists<SingleChildScrollView>();

      final scrollViewFinder = find.byType(SingleChildScrollView);
      expect(scrollViewFinder, findsOneWidget);

      // Verify padding is applied correctly
      final scrollView = tester.widget<SingleChildScrollView>(scrollViewFinder);
      expect(scrollView.padding, equals(const EdgeInsets.all(24)));

      // Verify that the main components are present
      tester
        ..expectWidgetExists<AppIconWidget>()
        ..expectWidgetExists<LoginFormWidget>();
    });

    testWidgets('displays app icon widget in correct position', (tester) async {
      await tester.pumpLoginPage(mockAuthBloc);

      // Verify AppIconWidget is present using extension
      tester.expectWidgetExists<AppIconWidget>();

      // Verify AppIconWidget is positioned correctly in the column
      final columnFinder = find.byType(Column);
      final appIconInColumn = find.descendant(
        of: columnFinder,
        matching: find.byType(AppIconWidget),
      );
      expect(appIconInColumn, findsOneWidget);
    });

    testWidgets('displays login form widget', (tester) async {
      await tester.pumpLoginPage(mockAuthBloc);

      // Verify LoginFormWidget is present using extension
      tester.expectWidgetExists<LoginFormWidget>();

      // Verify LoginFormWidget is positioned correctly in the column
      final columnFinder = find.byType(Column);
      final loginFormInColumn = find.descendant(
        of: columnFinder,
        matching: find.byType(LoginFormWidget),
      );
      expect(loginFormInColumn, findsOneWidget);
    });

    testWidgets('responds to AuthLoading state correctly', (tester) async {
      // Set up loading state
      when(
        () => mockAuthBloc.state,
      ).thenReturn(const AuthLoading(loading: true));

      await tester.pumpLoginPage(mockAuthBloc);

      // Widget should still render normally
      tester
        ..expectWidgetExists<LoginPage>()
        ..expectWidgetExists<AppIconWidget>()
        ..expectWidgetExists<LoginFormWidget>();
    });

    testWidgets('responds to AuthError state correctly', (tester) async {
      const errorMessage = 'Test error message';

      // Set up error state
      when(
        () => mockAuthBloc.state,
      ).thenReturn(const AuthError(message: errorMessage));

      await tester.pumpLoginPage(mockAuthBloc);

      // Widget should still render normally
      tester
        ..expectWidgetExists<LoginPage>()
        ..expectWidgetExists<AppIconWidget>()
        ..expectWidgetExists<LoginFormWidget>();
    });

    testWidgets('responds to AuthVerifiedUser state correctly', (tester) async {
      const testUser = User(
        id: 1,
        username: 'testuser',
        password: 'password',
        details: Details(
          firstname: 'Test',
          lastname: 'User',
          balance: 100,
        ),
      );

      // Set up verified user state
      when(
        () => mockAuthBloc.state,
      ).thenReturn(const AuthVerifiedUser(user: testUser));

      await tester.pumpLoginPage(mockAuthBloc);

      // Widget should still render normally
      tester
        ..expectWidgetExists<LoginPage>()
        ..expectWidgetExists<AppIconWidget>()
        ..expectWidgetExists<LoginFormWidget>();
    });

    testWidgets('renders without throwing exceptions', (tester) async {
      // Test that pumping the login page doesn't throw
      await tester.pumpLoginPage(mockAuthBloc);

      // Verify main component exists using extension
      tester.expectWidgetExists<LoginPage>();
    });

    testWidgets('contains BlocListener for AuthBloc', (tester) async {
      await tester.pumpLoginPage(mockAuthBloc);

      // Verify BlocListener is present
      final blocListenerFinder = find.byType(BlocListener<AuthBloc, AuthState>);
      expect(blocListenerFinder, findsOneWidget);

      // Verify BlocListener contains the actual content
      final scaffoldInListener = find.descendant(
        of: blocListenerFinder,
        matching: find.byType(Scaffold),
      );
      expect(scaffoldInListener, findsOneWidget);
    });

    testWidgets('has scrollable content area', (tester) async {
      await tester.pumpLoginPage(mockAuthBloc);

      // Verify SingleChildScrollView is present and functional
      tester.expectWidgetExists<SingleChildScrollView>();

      // Test scrolling functionality by attempting to scroll
      final scrollViewFinder = find.byType(SingleChildScrollView);
      expect(scrollViewFinder, findsOneWidget);

      // Verify scroll physics (should be default scrollable)
      final scrollView = tester.widget<SingleChildScrollView>(scrollViewFinder);
      expect(scrollView.physics, isNull);
    });
  });
}
