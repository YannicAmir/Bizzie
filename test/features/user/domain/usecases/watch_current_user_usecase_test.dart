import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/core/enums/investing_experience.dart';
import 'package:bizzie/features/user/domain/interfaces/i_user_repository.dart';
import 'package:bizzie/core/domain/models/user_model.dart';
import 'package:bizzie/features/user/domain/usecases/watch_current_user_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements IUserRepository {}

void main() {
  late MockUserRepository mockRepository;
  late WatchCurrentUserUseCase useCase;

  final tUser = UserModel(
    uid: 'test-uid',
    name: 'Test User',
    favoriteSector: 'Technology',
    investingExperience: InvestingExperience.beginner,
    createdAt: DateTime(2024),
    isSubscribed: false,
  );

  setUp(() {
    mockRepository = MockUserRepository();
    useCase = WatchCurrentUserUseCase(mockRepository);
  });

  group('WatchCurrentUserUseCase', () {
    test('call_repositoryEmitsUser_emitsRightUser', () async {
      // arrange
      when(
        () => mockRepository.userStream,
      ).thenAnswer((_) => Stream.value(Right(tUser)));

      // act
      final result = await useCase(NoParams()).first;

      // assert
      expect(result, Right<Failure, UserModel?>(tUser));
    });

    test('call_repositoryEmitsFailure_emitsLeftFailure', () async {
      // arrange
      const tFailure = Failure.server('error');
      when(
        () => mockRepository.userStream,
      ).thenAnswer((_) => Stream.value(const Left(tFailure)));

      // act
      final result = await useCase(NoParams()).first;

      // assert
      expect(result, const Left<Failure, UserModel?>(tFailure));
    });
  });
}
