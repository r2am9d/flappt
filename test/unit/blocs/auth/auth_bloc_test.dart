import 'package:bloc_test/bloc_test.dart';
import 'package:flappt/core/base/index.dart';
import 'package:flappt/core/errors/index.dart';
import 'package:flappt/core/modules/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FakeLoginParams extends Fake implements LoginParams {}

class FakeNoParams extends Fake implements NoParams {}

class FakeUser extends Fake implements User {}

// class MockAuthRepository extends Mock implements AuthRepository {}

class MockAuthLoginUseCase extends Mock implements AuthLoginUseCase {}

class MockAuthLogoutUseCase extends Mock implements AuthLogoutUseCase {}

class MockAuthSaveUserUseCase extends Mock implements AuthSaveUserUseCase {}

class MockAuthGetUserUseCase extends Mock implements AuthGetUserUseCase {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeLoginParams());
    registerFallbackValue(FakeNoParams());
    registerFallbackValue(FakeUser());
  });

  group('AuthBloc Bloc Test', () {
    late AuthBloc authBloc;

    // late MockAuthRepository mockAuthRepository;
    late MockAuthLoginUseCase mockAuthLoginUseCase;
    late MockAuthLogoutUseCase mockAuthLogoutUseCase;
    late MockAuthSaveUserUseCase mockAuthSaveUserUseCase;
    late MockAuthGetUserUseCase mockAuthGetUserUseCase;

    // Test data
    const testUser = User(
      id: 1,
      username: 'jdoe',
      password: 'admin12345',
      details: Details(
        firstname: 'John',
        lastname: 'Doe',
        balance: 50000,
      ),
    );

    setUp(() {
      // mockAuthRepository = MockAuthRepository();
      mockAuthLoginUseCase = MockAuthLoginUseCase();
      mockAuthLogoutUseCase = MockAuthLogoutUseCase();
      mockAuthSaveUserUseCase = MockAuthSaveUserUseCase();
      mockAuthGetUserUseCase = MockAuthGetUserUseCase();

      // Mock getUserUseCase for automatic AuthCheckSession call in constructor
      when(
        () => mockAuthGetUserUseCase.execute(any<NoParams>()),
      ).thenThrow(PersistenceException.userNotFound());

      authBloc = AuthBloc(
        loginUseCase: mockAuthLoginUseCase,
        logoutUseCase: mockAuthLogoutUseCase,
        saveUserUseCase: mockAuthSaveUserUseCase,
        getUserUseCase: mockAuthGetUserUseCase,
      );
    });

    test('initial AuthBloc state is [AuthInitial]', () {
      expect(authBloc.state, isA<AuthInitial>());
    });

    test('AuthCheckSession is called automatically on bloc creation', () {
      verify(() => mockAuthGetUserUseCase.execute(any<NoParams>())).called(1);
    });

    blocTest<AuthBloc, AuthState>(
      'emits [AuthVerifiedUser] when executeLogin succeeds',
      build: () => authBloc,
      setUp: () {
        when(
          () => mockAuthLoginUseCase.execute(any<LoginParams>()),
        ).thenAnswer((_) async => testUser);
      },
      act: (bloc) => bloc.add(
        AuthExecuteLogin(
          username: testUser.username,
          password: testUser.password,
        ),
      ),
      skip: 1, // Skip AuthLoading checks
      expect: () => [
        isA<AuthVerifiedUser>().having(
          (s) => s.user,
          'user',
          equals(testUser),
        ),
      ],
      verify: (_) {
        verify(
          () => mockAuthLoginUseCase.execute(any<LoginParams>()),
        ).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthError] when executeLogin fails',
      build: () => authBloc,
      setUp: () {
        when(
          () => mockAuthLoginUseCase.execute(any<LoginParams>()),
        ).thenThrow(Exception('Invalid credentials'));
      },
      act: (bloc) => bloc.add(
        AuthExecuteLogin(
          username: testUser.username,
          password: 'wrongPassword',
        ),
      ),
      skip: 1,
      expect: () => [
        isA<AuthError>().having(
          (s) => s.message,
          'message',
          isNotEmpty,
        ),
      ],
      verify: (_) {
        verify(
          () => mockAuthLoginUseCase.execute(any<LoginParams>()),
        ).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthVerifiedUser] when executeLogout succeeds',
      build: () => authBloc,
      setUp: () {
        when(
          () => mockAuthLogoutUseCase.execute(any<NoParams>()),
        ).thenAnswer((_) async {});
      },
      act: (bloc) => bloc.add(const AuthExecuteLogout()),
      skip: 1,
      expect: () => [
        isA<AuthVerifiedUser>().having(
          (s) => s.user,
          'user',
          isNull,
        ),
      ],
      verify: (_) {
        verify(() => mockAuthLogoutUseCase.execute(any<NoParams>())).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthError] when executeLogout fails',
      build: () => authBloc,
      setUp: () {
        when(
          () => mockAuthLogoutUseCase.execute(any<NoParams>()),
        ).thenThrow(Exception('Logout failed'));
      },
      act: (bloc) => bloc.add(const AuthExecuteLogout()),
      skip: 1,
      expect: () => [
        isA<AuthError>().having(
          (s) => s.message,
          'message',
          isNotEmpty,
        ),
      ],
      verify: (_) {
        verify(() => mockAuthLogoutUseCase.execute(any<NoParams>())).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'executes [saveUser] without emitting new state',
      build: () => authBloc,
      setUp: () {
        when(
          () => mockAuthSaveUserUseCase.execute(any<User>()),
        ).thenAnswer((_) async {});
      },
      act: (bloc) => bloc.add(const AuthSaveUser(user: testUser)),
      expect: () => <AuthState>[], // No new state
      verify: (_) {
        verify(() => mockAuthSaveUserUseCase.execute(any<User>())).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthError] when saveUser fails',
      build: () => authBloc,
      setUp: () {
        when(
          () => mockAuthSaveUserUseCase.execute(any<User>()),
        ).thenThrow(Exception('Save failed'));
      },
      act: (bloc) => bloc.add(const AuthSaveUser(user: testUser)),
      expect: () => [
        isA<AuthError>().having(
          (s) => s.message,
          'message',
          isNotEmpty,
        ),
      ],
      verify: (_) {
        verify(() => mockAuthSaveUserUseCase.execute(any<User>())).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      "emits [AuthError] when saveUser params user.id isn't greater than zero.",
      build: () => authBloc,
      setUp: () {
        when(
          () => mockAuthSaveUserUseCase.execute(testUser),
        ).thenThrow(ValidationException.greaterThanZero('id'));
      },
      act: (bloc) => bloc.add(const AuthSaveUser(user: testUser)),
      expect: () => [
        isA<AuthError>().having(
          (s) => s.message,
          'message',
          contains('id must be greater than zero.'),
        ),
      ],
      verify: (_) {
        verify(() => mockAuthSaveUserUseCase.execute(testUser)).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthError] when saveUser params user.password is empty.',
      build: () => authBloc,
      setUp: () {
        when(
          () => mockAuthSaveUserUseCase.execute(testUser),
        ).thenThrow(ValidationException.emptyField('password'));
      },
      act: (bloc) => bloc.add(const AuthSaveUser(user: testUser)),
      expect: () => [
        isA<AuthError>().having(
          (s) => s.message,
          'message',
          contains('password cannot be empty.'),
        ),
      ],
      verify: (_) {
        verify(() => mockAuthSaveUserUseCase.execute(testUser)).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthError] when saveUser params user.balance is negative.',
      build: () => authBloc,
      setUp: () {
        when(
          () => mockAuthSaveUserUseCase.execute(testUser),
        ).thenThrow(ValidationException.nonNegative('balance'));
      },
      act: (bloc) => bloc.add(const AuthSaveUser(user: testUser)),
      expect: () => [
        isA<AuthError>().having(
          (s) => s.message,
          'message',
          contains('balance must be non-negative.'),
        ),
      ],
      verify: (_) {
        verify(() => mockAuthSaveUserUseCase.execute(testUser)).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthVerifiedUser] when checkSession finds existing user',
      build: () => authBloc,
      setUp: () {
        when(
          () => mockAuthGetUserUseCase.execute(any<NoParams>()),
        ).thenAnswer((_) async => testUser);
      },
      act: (bloc) => bloc.add(const AuthCheckSession()),
      expect: () => [
        isA<AuthVerifiedUser>().having(
          (s) => s.user,
          'user',
          equals(testUser),
        ),
      ],
      verify: (_) {
        // Called twice: once in constructor, once in test
        verify(() => mockAuthGetUserUseCase.execute(any<NoParams>())).called(2);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'does not emit when checkSession throws exception',
      build: () => authBloc,
      setUp: () {
        when(
          () => mockAuthGetUserUseCase.execute(any<NoParams>()),
        ).thenThrow(PersistenceException.userNotFound());
      },
      act: (bloc) => bloc.add(const AuthCheckSession()),
      expect: () => <AuthState>[],
      verify: (_) {
        // Called twice: once in constructor, once in test
        verify(() => mockAuthGetUserUseCase.execute(any<NoParams>())).called(2);
      },
    );
  });
}
