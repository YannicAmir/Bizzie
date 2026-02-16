import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart' as auth;
import 'package:bizzie/features/market/domain/entities/sector_pe.dart';
import 'package:bizzie/features/market/domain/entities/sector_performance.dart';
import 'package:bizzie/features/market/domain/interfaces/i_market_repository.dart';
import 'package:bizzie/features/profile/domain/models/profile_display_data.dart';
import 'package:bizzie/features/profile/domain/usecases/get_profile_display_data_usecase.dart';
import 'package:bizzie/features/user/domain/enums/investing_experience.dart';
import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';
import 'package:bizzie/features/user/domain/models/user_model.dart';
import 'package:bizzie/core/interfaces/i_sector_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

class MockUserRepository extends Mock implements IUserRepository {}

class MockMarketRepository extends Mock implements IMarketRepository {}

class MockSectorService extends Mock implements ISectorService {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late MockUserRepository mockUserRepository;
  late MockMarketRepository mockMarketRepository;
  late MockSectorService mockSectorService;
  late GetProfileDisplayDataUseCase useCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockUserRepository = MockUserRepository();
    mockMarketRepository = MockMarketRepository();
    mockSectorService = MockSectorService();
    useCase = GetProfileDisplayDataUseCase(
      mockAuthRepository,
      mockUserRepository,
      mockMarketRepository,
      mockSectorService,
    );
  });

  group('GetProfileDisplayDataUseCase', () {
    const tUserId = 'user123';
    const tAuthUser = auth.UserModel(id: tUserId, email: 'test@test.com');
    final tJoinedDate = DateTime(2023, 1, 1);
    final tUser = UserModel(
      uid: tUserId,
      name: 'Test User',
      favoriteSector: 'technology',
      investingExperience: InvestingExperience.beginner,
      createdAt: tJoinedDate,
      isSubscribed: false,
      watchlist: [],
    );
    const tSectorDescription = 'Tech Companies';
    const tSectorDisplayName = 'Technology';

    final tSectorPeList = [
      const SectorPe(
        date: '2023-01-01',
        sector: 'technology',
        exchange: 'NASDAQ',
        pe: 25.5,
      ),
    ];
    final tSectorPerformanceList = [
      const SectorPerformance(
        date: '2023-01-01',
        sector: 'technology',
        exchange: 'NASDAQ',
        averageChange: 1.5,
      ),
    ];

    test('call_allSuccess_returnsProfileDisplayData', () async {
      // arrange
      when(() => mockAuthRepository.currentUser).thenReturn(tAuthUser);
      when(
        () => mockUserRepository.getUser(tUserId),
      ).thenAnswer((_) async => Right(tUser));
      when(
        () => mockSectorService.getSectorDescription(any()),
      ).thenReturn(tSectorDescription);
      when(
        () => mockSectorService.getSectorDisplayName(any()),
      ).thenReturn(tSectorDisplayName);
      when(
        () => mockSectorService.getSectorApiName(any()),
      ).thenReturn('technology');
      when(
        () => mockMarketRepository.getSectorPeList(),
      ).thenAnswer((_) async => Right(tSectorPeList));
      when(
        () => mockMarketRepository.getSectorPerformanceList(),
      ).thenAnswer((_) async => Right(tSectorPerformanceList));

      // act
      final result = await useCase(NoParams());

      // assert
      expect(
        result,
        Right(
          ProfileDisplayData(
            displayName: 'Test User',
            sectorName: tSectorDisplayName,
            sectorDescription: tSectorDescription,
            joinedDate: tJoinedDate,
            sectorPe: 25.5,
            sectorAverageChange: 1.5,
            marketDataDate: DateTime(2023, 1, 1),
          ),
        ),
      );
      verify(() => mockAuthRepository.currentUser).called(1);
      verify(() => mockUserRepository.getUser(tUserId)).called(1);
    });

    test('call_noUserInCache_returnsCacheFailure', () async {
      // arrange
      when(() => mockAuthRepository.currentUser).thenReturn(null);

      // act
      final result = await useCase(NoParams());

      // assert
      expect(result, const Left(CacheFailure('User not found in cache')));
      verify(() => mockAuthRepository.currentUser).called(1);
      verifyZeroInteractions(mockUserRepository);
    });

    test('call_getUserFails_returnsFailure', () async {
      // arrange
      when(() => mockAuthRepository.currentUser).thenReturn(tAuthUser);
      when(
        () => mockUserRepository.getUser(tUserId),
      ).thenAnswer((_) async => const Left(ServerFailure('User Error')));

      // act
      final result = await useCase(NoParams());

      // assert
      expect(result, const Left(ServerFailure('User Error')));
      verify(() => mockAuthRepository.currentUser).called(1);
      verify(() => mockUserRepository.getUser(tUserId)).called(1);
    });

    test('call_marketDatePriority_prioritizesPeListDate', () async {
      // arrange
      final tPeListWithDate = [
        const SectorPe(
          date: '2023-05-05',
          sector: 'technology',
          exchange: 'e',
          pe: 1,
        ),
      ];
      final tPerfListWithDifferentDate = [
        const SectorPerformance(
          date: '2023-01-01',
          sector: 'technology',
          exchange: 'e',
          averageChange: 1,
        ),
      ];

      when(() => mockAuthRepository.currentUser).thenReturn(tAuthUser);
      when(
        () => mockUserRepository.getUser(tUserId),
      ).thenAnswer((_) async => Right(tUser));
      when(() => mockSectorService.getSectorDescription(any())).thenReturn('d');
      when(() => mockSectorService.getSectorDisplayName(any())).thenReturn('n');
      when(
        () => mockSectorService.getSectorApiName(any()),
      ).thenReturn('technology');
      when(
        () => mockMarketRepository.getSectorPeList(),
      ).thenAnswer((_) async => Right(tPeListWithDate));
      when(
        () => mockMarketRepository.getSectorPerformanceList(),
      ).thenAnswer((_) async => Right(tPerfListWithDifferentDate));

      // act
      final result = await useCase(NoParams());

      // assert
      result.fold(
        (l) => fail('Should succeed'),
        (r) => expect(r.marketDataDate, DateTime(2023, 5, 5)),
      );
    });

    test('call_marketDateFallback_usesPerformanceListDate', () async {
      // arrange
      final tPeListNoMatch = <SectorPe>[]; // No date here
      final tPerfListWithDate = [
        const SectorPerformance(
          date: '2023-12-12',
          sector: 'technology',
          exchange: 'e',
          averageChange: 1,
        ),
      ];

      when(() => mockAuthRepository.currentUser).thenReturn(tAuthUser);
      when(
        () => mockUserRepository.getUser(tUserId),
      ).thenAnswer((_) async => Right(tUser));
      when(() => mockSectorService.getSectorDescription(any())).thenReturn('d');
      when(() => mockSectorService.getSectorDisplayName(any())).thenReturn('n');
      when(
        () => mockSectorService.getSectorApiName(any()),
      ).thenReturn('technology');
      when(
        () => mockMarketRepository.getSectorPeList(),
      ).thenAnswer((_) async => Right(tPeListNoMatch));
      when(
        () => mockMarketRepository.getSectorPerformanceList(),
      ).thenAnswer((_) async => Right(tPerfListWithDate));

      // act
      final result = await useCase(NoParams());

      // assert
      result.fold(
        (l) => fail('Should succeed'),
        (r) => expect(r.marketDataDate, DateTime(2023, 12, 12)),
      );
    });

    group('Linear Failure Chain Verification', () {
      test('given_peListFails_when_call_then_returnsLeftFailure', () async {
        // arrange
        when(() => mockAuthRepository.currentUser).thenReturn(tAuthUser);
        when(
          () => mockUserRepository.getUser(tUserId),
        ).thenAnswer((_) async => Right(tUser));
        when(
          () => mockSectorService.getSectorDescription(any()),
        ).thenReturn('d');
        when(
          () => mockSectorService.getSectorDisplayName(any()),
        ).thenReturn('n');
        when(
          () => mockSectorService.getSectorApiName(any()),
        ).thenReturn('technology');
        when(
          () => mockMarketRepository.getSectorPeList(),
        ).thenAnswer((_) async => const Left(ServerFailure('PE Error')));
        when(
          () => mockMarketRepository.getSectorPerformanceList(),
        ).thenAnswer((_) async => const Right([]));

        // act
        final result = await useCase(NoParams());

        // assert
        expect(result, const Left(ServerFailure('PE Error')));
      });
    });
  });
}
