import 'package:flappt/core/errors/index.dart';
import 'package:flappt/core/shared/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthLoginUsecase usecase;
  late MockAuthRepository mockRepository;

  // Test data
  const testUser = User(
    id: 1,
    username: 'testuser',
    password: 'password123',
    details: Details(
      firstname: 'Test',
      lastname: 'User',
      balance: 1000,
    ),
  );

  const testLoginParams = LoginParams(
    username: 'testuser',
    password: 'password123',
  );

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = AuthLoginUsecase(authRepository: mockRepository);
  });

  group('AuthLoginUseCase', () {
    test('should return User when login is successful', () async {
      // arrange
      when(
        () => mockRepository.login(
          testLoginParams.username,
          testLoginParams.password,
        ),
      ).thenAnswer((_) async => testUser);

      // act
      final result = await usecase.execute(testLoginParams);

      // assert
      expect(result, equals(testUser));
      verify(
        () => mockRepository.login(
          testLoginParams.username,
          testLoginParams.password,
        ),
      ).called(1);
    });

    test('should throw ValidationException when username is empty', () async {
      // arrange
      const params = LoginParams(
        username: '',
        password: 'password123',
      );

      // act & assert
      expect(
        () => usecase.execute(params),
        throwsA(isA<ValidationException>()),
      );

      verifyNever(
        () => mockRepository.login(
          any<String>(),
          any<String>(),
        ),
      );
    });

    test('should throw ValidationException when password is empty', () async {
      // arrange
      const params = LoginParams(
        username: 'testuser',
        password: '',
      );

      // act & assert
      expect(
        () => usecase.execute(params),
        throwsA(isA<ValidationException>()),
      );

      verifyNever(
        () => mockRepository.login(
          any<String>(),
          any<String>(),
        ),
      );
    });

    test(
      'should throw PersistenceException when credentials are invalid',
      () async {
        // arrange
        when(
          () => mockRepository.login(
            testLoginParams.username,
            testLoginParams.password,
          ),
        ).thenThrow(PersistenceException.invalidCredentials());

        // act & assert
        expect(
          () => usecase.execute(testLoginParams),
          throwsA(isA<PersistenceException>()),
        );

        verify(
          () => mockRepository.login(
            testLoginParams.username,
            testLoginParams.password,
          ),
        ).called(1);
      },
    );

    test('should throw NetworkException when network error occurs', () async {
      // arrange
      when(
        () => mockRepository.login(
          testLoginParams.username,
          testLoginParams.password,
        ),
      ).thenThrow(NetworkException.noConnection());

      // act & assert
      expect(
        () => usecase.execute(testLoginParams),
        throwsA(isA<NetworkException>()),
      );

      verify(
        () => mockRepository.login(
          testLoginParams.username,
          testLoginParams.password,
        ),
      ).called(1);
    });
  });
}
