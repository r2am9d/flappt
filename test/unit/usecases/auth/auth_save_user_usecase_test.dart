import 'package:flappt/core/errors/index.dart';
import 'package:flappt/core/shared/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FakeUser extends Fake implements User {}

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeUser());
  });

  late AuthSaveUserUsecase usecase;
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

  const invalidIdUser = User(
    id: 0,
    username: 'testuser',
    password: 'password123',
    details: Details(
      firstname: 'Test',
      lastname: 'User',
      balance: 1000,
    ),
  );

  const emptyUsernameUser = User(
    id: 1,
    username: '',
    password: 'password123',
    details: Details(
      firstname: 'Test',
      lastname: 'User',
      balance: 1000,
    ),
  );

  const emptyPasswordUser = User(
    id: 1,
    username: 'testuser',
    password: '',
    details: Details(
      firstname: 'Test',
      lastname: 'User',
      balance: 1000,
    ),
  );

  const negativeBalanceUser = User(
    id: 1,
    username: 'testuser',
    password: 'password123',
    details: Details(
      firstname: 'Test',
      lastname: 'User',
      balance: -1000,
    ),
  );

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = AuthSaveUserUsecase(authRepository: mockRepository);
  });

  group('AuthSaveUserUsecase', () {
    test('should complete successfully when save succeeds', () async {
      // arrange
      when(
        () => mockRepository.saveUser(testUser),
      ).thenAnswer((_) async {});

      // act
      final result = usecase.execute(testUser);

      // assert
      await expectLater(result, completes);
      verify(() => mockRepository.saveUser(testUser)).called(1);
    });

    test(
      'should throw ValidationException when user id is not greater than zero',
      () async {
        // act & assert
        expect(
          () => usecase.execute(invalidIdUser),
          throwsA(isA<ValidationException>()),
        );

        verifyNever(() => mockRepository.saveUser(any<User>()));
      },
    );

    test('should throw ValidationException when username is empty', () async {
      // act & assert
      expect(
        () => usecase.execute(emptyUsernameUser),
        throwsA(isA<ValidationException>()),
      );

      verifyNever(() => mockRepository.saveUser(any<User>()));
    });

    test('should throw ValidationException when password is empty', () async {
      // act & assert
      expect(
        () => usecase.execute(emptyPasswordUser),
        throwsA(isA<ValidationException>()),
      );

      verifyNever(() => mockRepository.saveUser(any<User>()));
    });

    test('should throw ValidationException when balance is negative', () async {
      // act & assert
      expect(
        () => usecase.execute(negativeBalanceUser),
        throwsA(isA<ValidationException>()),
      );

      verifyNever(() => mockRepository.saveUser(any<User>()));
    });

    test('should throw PersistenceException when save fails', () async {
      // arrange
      when(
        () => mockRepository.saveUser(testUser),
      ).thenThrow(PersistenceException.saveFailed());

      // act & assert
      expect(
        () => usecase.execute(testUser),
        throwsA(isA<PersistenceException>()),
      );

      verify(() => mockRepository.saveUser(testUser)).called(1);
    });

    test('should throw NetworkException when network error occurs', () async {
      // arrange
      when(
        () => mockRepository.saveUser(testUser),
      ).thenThrow(NetworkException.noConnection());

      // act & assert
      expect(
        () => usecase.execute(testUser),
        throwsA(isA<NetworkException>()),
      );

      verify(() => mockRepository.saveUser(testUser)).called(1);
    });
  });
}
