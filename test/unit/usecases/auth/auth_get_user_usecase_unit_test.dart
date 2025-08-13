import 'package:flappt/core/base/index.dart';
import 'package:flappt/core/errors/index.dart';
import 'package:flappt/core/modules/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthGetUserUseCase usecase;
  late MockAuthRepository mockRepository;

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

  const testParams = NoParams();

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = AuthGetUserUseCase(authRepository: mockRepository);
  });

  group('AuthGetUserUseCase Unit Test', () {
    test('should return User when getUser is successful', () async {
      // arrange
      when(() => mockRepository.getUser()).thenAnswer((_) async => testUser);

      // act
      final result = await usecase.execute(testParams);

      // assert
      expect(result, equals(testUser));
      verify(() => mockRepository.getUser()).called(1);
    });

    test('should throw PersistenceException when user not found', () async {
      // arrange
      when(
        () => mockRepository.getUser(),
      ).thenThrow(PersistenceException.userNotFound());

      // act & assert
      expect(
        () => usecase.execute(testParams),
        throwsA(isA<PersistenceException>()),
      );

      verify(() => mockRepository.getUser()).called(1);
    });

    test('should throw PersistenceException when data access fails', () async {
      // arrange
      when(
        () => mockRepository.getUser(),
      ).thenThrow(PersistenceException.saveFailed());

      // act & assert
      expect(
        () => usecase.execute(testParams),
        throwsA(isA<PersistenceException>()),
      );

      verify(() => mockRepository.getUser()).called(1);
    });

    test('should throw NetworkException when network error occurs', () async {
      // arrange
      when(
        () => mockRepository.getUser(),
      ).thenThrow(NetworkException.noConnection());

      // act & assert
      expect(
        () => usecase.execute(testParams),
        throwsA(isA<NetworkException>()),
      );

      verify(() => mockRepository.getUser()).called(1);
    });

    test('should return user with correct properties', () async {
      // arrange
      when(() => mockRepository.getUser()).thenAnswer((_) async => testUser);

      // act
      final result = await usecase.execute(testParams);

      // assert
      expect(result.id, equals(1));
      expect(result.username, equals('jdoe'));
      expect(result.password, equals('admin12345'));
      expect(result.details.firstname, equals('John'));
      expect(result.details.lastname, equals('Doe'));
      expect(result.details.balance, equals(50000));
      expect(result.details.fullName, equals('John Doe'));

      verify(() => mockRepository.getUser()).called(1);
    });

    test('should handle user with minimal details', () async {
      // arrange
      const minimalUser = User(
        id: 2,
        username: 'minimal',
        password: 'test123',
        details: Details(
          firstname: 'Min',
          lastname: '',
          balance: 0,
        ),
      );

      when(() => mockRepository.getUser()).thenAnswer((_) async => minimalUser);

      // act
      final result = await usecase.execute(testParams);

      // assert
      expect(result, equals(minimalUser));
      expect(result.details.fullName, equals('Min'));
      expect(result.details.balance, equals(0));

      verify(() => mockRepository.getUser()).called(1);
    });

    test('should handle multiple consecutive calls', () async {
      // arrange
      when(() => mockRepository.getUser()).thenAnswer((_) async => testUser);

      // act
      final result1 = await usecase.execute(testParams);
      final result2 = await usecase.execute(testParams);

      // assert
      expect(result1, equals(testUser));
      expect(result2, equals(testUser));
      expect(result1, equals(result2));

      verify(() => mockRepository.getUser()).called(2);
    });

    test('should propagate generic Exception as-is', () async {
      // arrange
      const genericException = FormatException('Invalid data format');
      when(() => mockRepository.getUser()).thenThrow(genericException);

      // act & assert
      expect(
        () => usecase.execute(testParams),
        throwsA(isA<FormatException>()),
      );

      verify(() => mockRepository.getUser()).called(1);
    });
  });
}
