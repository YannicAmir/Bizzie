import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:bizzie/services/config_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockConfigService extends Mock implements ConfigService {}

void main() {
  late MockConfigService mockConfigService;
  late ProfileRepositoryImpl repository;

  setUp(() {
    mockConfigService = MockConfigService();
    repository = ProfileRepositoryImpl(mockConfigService);
  });

  group('ProfileRepositoryImpl', () {
    const tSectorName = 'Technology';
    const tDescription = 'Tech Companies';
    const tDisplayName = 'Technology Sector';

    group('getSectorDescription', () {
      test(
        'getSectorDescription_configServiceSuccess_returnsDescription',
        () async {
          // arrange
          when(
            () => mockConfigService.getSectorDescription(tSectorName),
          ).thenReturn(tDescription);

          // act
          final result = await repository.getSectorDescription(tSectorName);

          // assert
          verify(
            () => mockConfigService.getSectorDescription(tSectorName),
          ).called(1);
          expect(result, const Right(tDescription));
        },
      );

      test(
        'getSectorDescription_configServiceThrows_returnsCacheFailure',
        () async {
          // arrange
          when(
            () => mockConfigService.getSectorDescription(tSectorName),
          ).thenThrow(Exception('Config Error'));

          // act
          final result = await repository.getSectorDescription(tSectorName);

          // assert
          verify(
            () => mockConfigService.getSectorDescription(tSectorName),
          ).called(1);
          expect(result.fold((l) => l, (r) => null), isA<CacheFailure>());
        },
      );
    });

    group('getSectorDisplayName', () {
      test(
        'getSectorDisplayName_configServiceSuccess_returnsDisplayName',
        () async {
          // arrange
          when(
            () => mockConfigService.getSectorDisplayName(tSectorName),
          ).thenReturn(tDisplayName);

          // act
          final result = await repository.getSectorDisplayName(tSectorName);

          // assert
          verify(
            () => mockConfigService.getSectorDisplayName(tSectorName),
          ).called(1);
          expect(result, const Right(tDisplayName));
        },
      );

      test(
        'getSectorDisplayName_configServiceThrows_returnsCacheFailure',
        () async {
          // arrange
          when(
            () => mockConfigService.getSectorDisplayName(tSectorName),
          ).thenThrow(Exception('Config Error'));

          // act
          final result = await repository.getSectorDisplayName(tSectorName);

          // assert
          verify(
            () => mockConfigService.getSectorDisplayName(tSectorName),
          ).called(1);
          expect(result.fold((l) => l, (r) => null), isA<CacheFailure>());
        },
      );
    });
  });
}
