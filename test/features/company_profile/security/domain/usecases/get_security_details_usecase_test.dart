import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/security/domain/interfaces/i_security_repository.dart';
import 'package:bizzie/features/company_profile/security/domain/models/security_details.dart';
import 'package:bizzie/features/company_profile/security/domain/usecases/get_security_details_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockISecurityRepository extends Mock implements ISecurityRepository {}

void main() {
  late GetSecurityDetailsUseCase useCase;
  late MockISecurityRepository mockRepository;

  setUp(() {
    mockRepository = MockISecurityRepository();
    useCase = GetSecurityDetailsUseCase(mockRepository);
  });

  const tTicker = 'AAPL';
  final tSecurityDetails = SecurityDetails(
    ticker: tTicker,
    name: 'Apple Inc.',
    sector: 'Technology',
    industry: 'Consumer Electronics',
    description: 'Tech giant',
    currency: 'USD',
    isEtf: false,
    isFund: false,
    isActivelyTrading: true,
    price: 150.0,
    changesPercentage: 1.5,
    change: 2.2,
    marketCap: 2000000000,
    peRatioTTM: 25.0,
    priceToFreeCashFlowTTM: 20.0,
    beta: 1.2,
    image: 'https://example.com/image.png',
    exchangeShortName: 'NASDAQ',
    country: 'US',
    ipoDate: '1980-12-12',
    website: 'https://apple.com',
  );

  group('GetSecurityDetailsUseCase', () {
    test('call_success_returnsSecurityDetails', () async {
      // arrange
      when(
        () => mockRepository.getSecurityDetails(tTicker),
      ).thenAnswer((_) async => Right(tSecurityDetails));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, Right(tSecurityDetails));
      verify(() => mockRepository.getSecurityDetails(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('call_failure_returnsServerFailure', () async {
      // arrange
      const tFailure = Failure.server('Server error');
      when(
        () => mockRepository.getSecurityDetails(tTicker),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.getSecurityDetails(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
