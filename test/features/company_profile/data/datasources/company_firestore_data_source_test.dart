import 'package:bizzie/core/data/models/firestore_cache_entry.dart';
import 'package:bizzie/features/company_profile/data/datasources/company_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/data/dtos/profile_dtos.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late CompanyFirestoreDataSourceImpl dataSource;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    dataSource = CompanyFirestoreDataSourceImpl(fakeFirestore);
  });

  const tTicker = 'AAPL';
  final tProfile = ProfileDto(
    symbol: 'AAPL',
    price: 150.0,
    beta: 1.2,
    marketCap: 2000000000,
    companyName: 'Apple Inc.',
    currency: 'USD',
    exchange: 'NASDAQ',
    exchangeShortName: 'NASDAQ',
    industry: 'Technology',
    website: 'https://apple.com',
    description: 'Tech company',
    ceo: 'Tim Cook',
    sector: 'Technology',
    country: 'US',
    fullTimeEmployees: '100000',
    phone: '1-800-APPLE',
    address: '1 Apple Park Way',
    city: 'Cupertino',
    state: 'CA',
    zip: '95014',
    image: 'https://example.com/image.png',
    ipoDate: '1980-12-12',
    isEtf: false,
    isActivelyTrading: true,
  );

  group('CompanyFirestoreDataSource - Profile', () {
    test('cacheProfile_success_storesDataInFirestore', () async {
      // arrange
      // act
      await dataSource.cacheProfile(tTicker, tProfile);

      // assert
      final docSnapshot = await fakeFirestore
          .collection('companies')
          .doc(tTicker)
          .collection('info')
          .doc('profile')
          .get();

      expect(docSnapshot.exists, isTrue);
      final data = docSnapshot.data()!;
      expect(data['data']['symbol'], 'AAPL');
      expect(data.containsKey('lastUpdated'), isTrue);
    });

    test('getCachedProfile_cacheValid_returnsProfileDto', () async {
      // arrange
      await dataSource.cacheProfile(tTicker, tProfile);

      // act
      final result = await dataSource.getCachedProfile(tTicker);

      // assert
      expect(result, isNotNull);
      expect(result!.symbol, 'AAPL');
    });

    test('getCachedProfile_cacheExpired_returnsNull', () async {
      // arrange
      final expiredDate = DateTime.now().subtract(const Duration(hours: 25));
      final entry = FirestoreCacheEntry(
        data: tProfile,
        lastUpdated: expiredDate,
      );

      await fakeFirestore
          .collection('companies')
          .doc(tTicker)
          .collection('info')
          .doc('profile')
          .set(entry.toJson((dto) => dto.toJson()));

      // act
      final result = await dataSource.getCachedProfile(tTicker);

      // assert
      expect(result, isNull);
    });
  });
}
