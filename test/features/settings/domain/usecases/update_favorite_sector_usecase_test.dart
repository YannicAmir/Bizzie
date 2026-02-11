import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart' as auth;
import 'package:bizzie/features/settings/domain/usecases/update_favorite_sector_usecase.dart';
import 'package:bizzie/features/user/domain/enums/investing_experience.dart';
import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';
import 'package:bizzie/features/user/domain/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements IUserRepository {}

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late UpdateFavoriteSectorUseCase useCase;
  late MockUserRepository mockUserRepository;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    mockAuthRepository = MockAuthRepository();
    useCase = UpdateFavoriteSectorUseCase(
      mockUserRepository,
      mockAuthRepository,
    );

    registerFallbackValue(Sector.informationTechnology);
    registerFallbackValue(
      UserModel(
        uid: 'fallback',
        name: 'fallback',
        favoriteSector: 'fallback',
        investingExperience: InvestingExperience.beginner,
        createdAt: DateTime(2023),
        isSubscribed: false,
        notificationsEnabled: true,
      ),
    );
  });

  const tUserId = 'user_123';
  const tSector = Sector.informationTechnology;
  final tAuthUser = auth.UserModel(id: tUserId, email: 'test@example.com');
  final tUserModel = UserModel(
    uid: tUserId,
    name: 'Test User',
    favoriteSector: 'Finance',
    investingExperience: InvestingExperience.beginner,
    createdAt: DateTime(2023),
    isSubscribed: false,
    notificationsEnabled: true,
  );

  group('UpdateFavoriteSectorUseCase', () {
    test('call_allSuccess_returnsRight', () async {
      // arrange
      when(() => mockAuthRepository.currentUser).thenReturn(tAuthUser);
      when(
        () => mockUserRepository.getUser(any()),
      ).thenAnswer((_) async => Right(tUserModel));
      when(
        () => mockUserRepository.updateUser(any()),
      ).thenAnswer((_) async => const Right(null));

      // act
      final result = await useCase(tSector);

      // assert
      expect(result, const Right(null));
      verify(() => mockAuthRepository.currentUser).called(1);
      verify(() => mockUserRepository.getUser(tUserId)).called(1);
      verify(
        () => mockUserRepository.updateUser(
          any(
            that: isA<UserModel>().having(
              (u) => u.favoriteSector,
              'favoriteSector',
              tSector.name,
            ),
          ),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
      verifyNoMoreInteractions(mockUserRepository);
    });

    test('call_unauthenticated_returnsUserNotFoundFailure', () async {
      // arrange
      when(() => mockAuthRepository.currentUser).thenReturn(null);

      // act
      final result = await useCase(tSector);

      // assert
      expect(result, const Left(Failure.userNotFound()));
      verify(() => mockAuthRepository.currentUser).called(1);
      verifyZeroInteractions(mockUserRepository);
    });

    test('call_fetchUserFails_returnsFailure', () async {
      // arrange
      const tFailure = Failure.server('Fetch failed');
      when(() => mockAuthRepository.currentUser).thenReturn(tAuthUser);
      when(
        () => mockUserRepository.getUser(any()),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(tSector);

      // assert
      expect(result, const Left(tFailure));
      verify(() => mockAuthRepository.currentUser).called(1);
      verify(() => mockUserRepository.getUser(tUserId)).called(1);
      verifyNoMoreInteractions(mockUserRepository);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('call_updateUserFails_returnsFailure', () async {
      // arrange
      const tFailure = Failure.server('Update failed');
      when(() => mockAuthRepository.currentUser).thenReturn(tAuthUser);
      when(
        () => mockUserRepository.getUser(any()),
      ).thenAnswer((_) async => Right(tUserModel));
      when(
        () => mockUserRepository.updateUser(any()),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(tSector);

      // assert
      expect(result, const Left(tFailure));
      verify(() => mockAuthRepository.currentUser).called(1);
      verify(() => mockUserRepository.getUser(tUserId)).called(1);
      verify(() => mockUserRepository.updateUser(any())).called(1);
      verifyNoMoreInteractions(mockUserRepository);
      verifyNoMoreInteractions(mockAuthRepository);
    });
  });
}
