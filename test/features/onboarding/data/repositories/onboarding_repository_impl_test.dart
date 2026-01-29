import 'package:bizzie/features/onboarding/data/dtos/user_dto.dart';
import 'package:bizzie/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';

import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/features/user/domain/enums/investing_experience.dart';
import 'package:bizzie/features/user/domain/models/user_model.dart';
import 'package:bizzie/features/onboarding/data/datasources/onboarding_remote_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:mocktail/mocktail.dart';

class MockOnboardingRemoteDataSource extends Mock
    implements IOnboardingRemoteDataSource {}

class FakeUserDto extends Fake implements UserDto {}

void main() {
  late OnboardingRepositoryImpl repository;
  late MockOnboardingRemoteDataSource mockRemoteDataSource;

  setUpAll(() {
    registerFallbackValue(FakeUserDto());
  });

  setUp(() {
    mockRemoteDataSource = MockOnboardingRemoteDataSource();
    repository = OnboardingRepositoryImpl(mockRemoteDataSource);
  });

  group('OnboardingRepositoryImpl', () {
    test('getSectors_success_returnsSectorList', () async {
      // Arrange
      when(
        () => mockRemoteDataSource.getStockMarketSectors(),
      ).thenReturn(['Healthcare', 'Information Technology']);

      // Act
      final result = await repository.getSectors();

      // Assert
      expect(result.isRight(), true);
      result.fold((_) => fail('Should be Right'), (sectors) {
        expect(sectors.length, 2);
        expect(sectors.last, Sector.informationTechnology);
      });
    });

    test('saveUserProfile_validData_callsSaveUserProfile', () async {
      // Arrange
      final tUser = UserModel(
        uid: 'uid_123',
        name: 'John',
        favoriteSector: 'Technology',
        watchlist: [const Company(ticker: 'AAPL', name: 'Apple')],
        investingExperience: InvestingExperience.beginner,
        createdAt: DateTime.now(),
        isSubscribed: false,
        fcmTokens: {},
      );

      when(
        () => mockRemoteDataSource.saveUserProfile(any(), any()),
      ).thenAnswer((_) async {});

      // Act
      await repository.saveUserProfile(tUser);

      // Assert
      verify(
        () => mockRemoteDataSource.saveUserProfile(any(), any()),
      ).called(1);
    });

    test('saveUserProfile_saveThrows_throwsException', () async {
      // Arrange
      final tUser = UserModel(
        uid: 'uid_123',
        name: 'John',
        favoriteSector: 'Technology',
        watchlist: [],
        investingExperience: InvestingExperience.beginner,
        createdAt: DateTime.now(),
        isSubscribed: false,
        fcmTokens: {},
      );

      when(
        () => mockRemoteDataSource.saveUserProfile(any(), any()),
      ).thenThrow(Exception('Save Failed'));

      // Act & Assert
      // Act
      final result = await repository.saveUserProfile(tUser);

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (l) => expect(l, isA<ServerFailure>()),
        (_) => fail('Should be Left'),
      );
    });
  });
}
