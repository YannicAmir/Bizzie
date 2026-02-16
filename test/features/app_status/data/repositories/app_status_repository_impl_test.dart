import 'dart:async';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/interfaces/i_connectivity_service.dart';
import 'package:bizzie/core/services/app_info_service.dart';
import 'package:bizzie/features/app_status/data/repositories/app_status_repository_impl.dart';
import 'package:bizzie/features/app_status/domain/interfaces/i_local_app_status_data_source.dart';
import 'package:bizzie/features/app_status/domain/models/app_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockConfigService extends Mock implements IConfigService {}

class MockConnectivityService extends Mock implements IConnectivityService {}

class MockLocalAppStatusDataSource extends Mock
    implements ILocalAppStatusDataSource {}

class MockAppInfoService extends Mock implements IAppInfoService {}

void main() {
  late AppStatusRepositoryImpl repository;
  late MockConfigService mockConfigService;
  late MockConnectivityService mockConnectivityService;
  late MockLocalAppStatusDataSource mockLocalDataSource;
  late MockAppInfoService mockAppInfoService;

  setUp(() {
    mockConfigService = MockConfigService();
    mockConnectivityService = MockConnectivityService();
    mockLocalDataSource = MockLocalAppStatusDataSource();
    mockAppInfoService = MockAppInfoService();
    repository = AppStatusRepositoryImpl(
      mockConfigService,
      mockLocalDataSource,
      mockConnectivityService,
      mockAppInfoService,
    );
  });

  group('AppStatusRepositoryImpl', () {
    const tMinVersion = '2.0.0';
    const tCurrentVersion = '1.0.0';
    const tAppStoreLink = 'https://ios.link';
    const tPlayStoreLink = 'https://android.link';

    group('checkStatus', () {
      test('checkStatus_noInternet_returnsNoInternet', () async {
        // arrange
        when(
          () => mockConnectivityService.hasInternetConnection,
        ).thenAnswer((_) async => false);

        // act
        final result = await repository.checkStatus();

        // assert
        expect(result, const AppStatus.noInternet());
        verify(() => mockConnectivityService.hasInternetConnection);
        verifyNoMoreInteractions(mockConfigService);
      });

      test('checkStatus_maintenanceModeActive_returnsMaintenance', () async {
        // arrange
        when(
          () => mockConnectivityService.hasInternetConnection,
        ).thenAnswer((_) async => true);
        when(
          () => mockConfigService.fetchAndActivate(),
        ).thenAnswer((_) async => true);
        when(() => mockConfigService.maintenanceMode).thenReturn(true);
        when(() => mockConfigService.minAppVersion).thenReturn(tMinVersion);
        when(() => mockConfigService.appStoreLink).thenReturn(tAppStoreLink);
        when(() => mockConfigService.playStoreLink).thenReturn(tPlayStoreLink);

        // act
        final result = await repository.checkStatus();

        // assert
        expect(result, const AppStatus.maintenance());
        verify(() => mockConfigService.maintenanceMode);
      });

      test('checkStatus_versionLowerThanMin_returnsForceUpgrade', () async {
        // arrange
        when(
          () => mockConnectivityService.hasInternetConnection,
        ).thenAnswer((_) async => true);
        when(
          () => mockConfigService.fetchAndActivate(),
        ).thenAnswer((_) async => true);
        when(() => mockConfigService.maintenanceMode).thenReturn(false);
        when(() => mockConfigService.minAppVersion).thenReturn(tMinVersion);
        when(() => mockConfigService.appStoreLink).thenReturn(tAppStoreLink);
        when(() => mockConfigService.playStoreLink).thenReturn(tPlayStoreLink);
        when(
          () => mockAppInfoService.getAppVersion(),
        ).thenAnswer((_) async => tCurrentVersion);
        when(
          () => mockLocalDataSource.cacheMinAppVersion(any()),
        ).thenAnswer((_) async {});
        when(
          () => mockLocalDataSource.cacheAppStoreLink(any()),
        ).thenAnswer((_) async {});
        when(
          () => mockLocalDataSource.cachePlayStoreLink(any()),
        ).thenAnswer((_) async {});

        // act
        final result = await repository.checkStatus();

        // assert
        expect(
          result.maybeMap(
            forceUpgrade: (f) => f.minVersion == tMinVersion,
            orElse: () => false,
          ),
          isTrue,
        );
        verify(() => mockLocalDataSource.cacheMinAppVersion(tMinVersion));
      });

      test('checkStatus_versionGreater_returnsNormal', () async {
        // arrange
        when(
          () => mockConnectivityService.hasInternetConnection,
        ).thenAnswer((_) async => true);
        when(
          () => mockConfigService.fetchAndActivate(),
        ).thenAnswer((_) async => true);
        when(() => mockConfigService.maintenanceMode).thenReturn(false);
        when(() => mockConfigService.minAppVersion).thenReturn('1.0.0');
        when(() => mockConfigService.appStoreLink).thenReturn(tAppStoreLink);
        when(() => mockConfigService.playStoreLink).thenReturn(tPlayStoreLink);
        when(
          () => mockAppInfoService.getAppVersion(),
        ).thenAnswer((_) async => '1.1.0');
        when(
          () => mockLocalDataSource.cacheMinAppVersion(any()),
        ).thenAnswer((_) async {});
        when(
          () => mockLocalDataSource.cacheAppStoreLink(any()),
        ).thenAnswer((_) async {});
        when(
          () => mockLocalDataSource.cachePlayStoreLink(any()),
        ).thenAnswer((_) async {});

        // act
        final result = await repository.checkStatus();

        // assert
        expect(result, const AppStatus.normal());
      });

      test('checkStatus_fetchFails_fallsBackToCache', () async {
        // arrange
        when(
          () => mockConnectivityService.hasInternetConnection,
        ).thenAnswer((_) async => true);
        when(() => mockConfigService.fetchAndActivate()).thenThrow(Exception());
        when(
          () => mockLocalDataSource.getCachedMinAppVersion(),
        ).thenReturn(tMinVersion);
        when(
          () => mockLocalDataSource.getCachedAppStoreLink(),
        ).thenReturn(tAppStoreLink);
        when(
          () => mockLocalDataSource.getCachedPlayStoreLink(),
        ).thenReturn(tPlayStoreLink);
        when(
          () => mockAppInfoService.getAppVersion(),
        ).thenAnswer((_) async => tCurrentVersion);

        // act
        final result = await repository.checkStatus();

        // assert
        expect(
          result.maybeMap(
            forceUpgrade: (f) => f.minVersion == tMinVersion,
            orElse: () => false,
          ),
          isTrue,
        );
        verify(() => mockLocalDataSource.getCachedMinAppVersion());
      });
    });

    group('watchStatus', () {
      test('watchStatus_emitsInitialCachedThenFresh', () async {
        // arrange
        when(
          () => mockLocalDataSource.getCachedMinAppVersion(),
        ).thenReturn(null);
        when(
          () => mockConnectivityService.hasInternetConnection,
        ).thenAnswer((_) async => true);
        when(
          () => mockConfigService.fetchAndActivate(),
        ).thenAnswer((_) async => true);
        when(() => mockConfigService.maintenanceMode).thenReturn(false);
        when(() => mockConfigService.minAppVersion).thenReturn('1.0.0');
        when(() => mockConfigService.appStoreLink).thenReturn(tAppStoreLink);
        when(() => mockConfigService.playStoreLink).thenReturn(tPlayStoreLink);
        when(
          () => mockAppInfoService.getAppVersion(),
        ).thenAnswer((_) async => '1.0.0');
        when(
          () => mockLocalDataSource.cacheMinAppVersion(any()),
        ).thenAnswer((_) async {});
        when(
          () => mockLocalDataSource.cacheAppStoreLink(any()),
        ).thenAnswer((_) async {});
        when(
          () => mockLocalDataSource.cachePlayStoreLink(any()),
        ).thenAnswer((_) async {});

        when(
          () => mockConfigService.onConfigUpdated,
        ).thenAnswer((_) => const Stream.empty());
        when(
          () => mockConnectivityService.onConnectivityChanged,
        ).thenAnswer((_) => const Stream.empty());

        // act & assert
        expectLater(
          repository.watchStatus(),
          emitsInOrder([const AppStatus.normal(), const AppStatus.normal()]),
        );
      });

      test('watchStatus_connectivityDisconnected_emitsNoInternet', () async {
        // arrange
        final connectivityController = StreamController<bool>();
        when(
          () => mockLocalDataSource.getCachedMinAppVersion(),
        ).thenReturn(null);
        when(
          () => mockConnectivityService.hasInternetConnection,
        ).thenAnswer((_) async => true);
        when(
          () => mockConfigService.fetchAndActivate(),
        ).thenAnswer((_) async => true);
        when(
          () => mockConfigService.onConfigUpdated,
        ).thenAnswer((_) => const Stream.empty());
        when(
          () => mockConnectivityService.onConnectivityChanged,
        ).thenAnswer((_) => connectivityController.stream);
        when(() => mockConfigService.maintenanceMode).thenReturn(false);
        when(() => mockConfigService.minAppVersion).thenReturn('1.0.0');
        when(
          () => mockAppInfoService.getAppVersion(),
        ).thenAnswer((_) async => '1.0.0');
        when(
          () => mockLocalDataSource.cacheMinAppVersion(any()),
        ).thenAnswer((_) async {});
        when(
          () => mockLocalDataSource.cacheAppStoreLink(any()),
        ).thenAnswer((_) async {});
        when(
          () => mockLocalDataSource.cachePlayStoreLink(any()),
        ).thenAnswer((_) async {});

        // act & assert
        final results = <AppStatus>[];
        final subscription = repository.watchStatus().listen(results.add);

        await Future.delayed(Duration.zero);
        connectivityController.add(false);
        await Future.delayed(Duration.zero);

        expect(results, contains(const AppStatus.noInternet()));

        subscription.cancel();
        connectivityController.close();
      });
    });
  });
}
