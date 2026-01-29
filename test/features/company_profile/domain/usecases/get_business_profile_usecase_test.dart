import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/business/domain/interfaces/i_business_repository.dart';
import 'package:bizzie/features/company_profile/business/domain/models/business_profile.dart';
import 'package:bizzie/features/company_profile/business/domain/usecases/get_business_profile_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIBusinessRepository extends Mock implements IBusinessRepository {}

void main() {
  late GetBusinessProfileUseCase useCase;
  late MockIBusinessRepository mockRepository;

  setUp(() {
    mockRepository = MockIBusinessRepository();
    useCase = GetBusinessProfileUseCase(mockRepository);
  });

  const tTicker = 'AAPL';
  final tBusinessProfile = BusinessProfile(
    symbol: tTicker,
    companyName: 'Apple Inc.',
    sector: 'Technology',
    industry: 'Consumer Electronics',
    description: 'Tech giant',
    ceo: 'Tim Cook',
    website: 'https://apple.com',
    address: '1 Infinite Loop',
    city: 'Cupertino',
    state: 'CA',
    zip: '95014',
    phone: '1-408-996-1010',
    fullTimeEmployees: '100000',
    executives: [],
    annualFilings: [],
    quarterlyFilings: [],
  );

  group('GetBusinessProfileUseCase', () {
    test('call_success_returnsBusinessProfile', () async {
      // arrange
      when(
        () => mockRepository.getBusinessProfile(tTicker),
      ).thenAnswer((_) async => Right(tBusinessProfile));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, Right(tBusinessProfile));
      verify(() => mockRepository.getBusinessProfile(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('call_failure_returnsServerFailure', () async {
      // arrange
      const tFailure = Failure.server('Server error');
      when(
        () => mockRepository.getBusinessProfile(tTicker),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.getBusinessProfile(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
