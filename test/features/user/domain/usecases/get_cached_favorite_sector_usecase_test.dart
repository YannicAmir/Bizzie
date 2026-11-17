import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/user/domain/interfaces/i_user_repository.dart';
import 'package:bizzie/features/user/domain/usecases/get_cached_favorite_sector_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements IUserRepository {}

const tSector = 'Technology';

void main() {
  late MockUserRepository mockRepository;
  late GetCachedFavoriteSectorUseCase sut;

  setUp(() {
    mockRepository = MockUserRepository();
    sut = GetCachedFavoriteSectorUseCase(mockRepository);
  });

  group('GetCachedFavoriteSectorUseCase', () {
    test('call_sectorCached_returnsCachedSector', () {
      // arrange
      when(() => mockRepository.getCachedFavoriteSector()).thenReturn(tSector);

      // act
      final result = sut(NoParams());

      // assert
      expect(result, tSector);
      verify(() => mockRepository.getCachedFavoriteSector()).called(1);
    });

    test('call_noSectorCached_returnsNull', () {
      // arrange
      when(() => mockRepository.getCachedFavoriteSector()).thenReturn(null);

      // act
      final result = sut(NoParams());

      // assert
      expect(result, isNull);
    });
  });
}
