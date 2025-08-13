import 'package:flappt/core/base/index.dart';
import 'package:flappt/core/errors/index.dart';
import 'package:flappt/core/modules/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthLogoutUseCase usecase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = AuthLogoutUseCase(authRepository: mockRepository);
  });

  group('AuthLogoutUseCase Unit Test', () {
    test('should complete successfully when logout succeeds', () async {
      // arrange
      when(
        () => mockRepository.logout(),
      ).thenAnswer((_) async {});

      // act
      final result = usecase.execute(const NoParams());

      // assert
      await expectLater(result, completes);
      verify(() => mockRepository.logout()).called(1);
    });

    test('should throw PersistenceException when logout fails', () async {
      // arrange
      when(
        () => mockRepository.logout(),
      ).thenThrow(PersistenceException.logoutFailed());

      // act & assert
      expect(
        () => usecase.execute(const NoParams()),
        throwsA(isA<PersistenceException>()),
      );

      verify(() => mockRepository.logout()).called(1);
    });

    test('should throw NetworkException when network error occurs', () async {
      // arrange
      when(
        () => mockRepository.logout(),
      ).thenThrow(NetworkException.noConnection());

      // act & assert
      expect(
        () => usecase.execute(const NoParams()),
        throwsA(isA<NetworkException>()),
      );

      verify(() => mockRepository.logout()).called(1);
    });
  });
}
