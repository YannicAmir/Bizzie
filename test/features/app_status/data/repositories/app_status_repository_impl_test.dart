import 'dart:async';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/interfaces/i_connectivity_service.dart';
import 'package:bizzie/core/interfaces/i_lifecycle_service.dart';
import 'package:bizzie/core/services/app_info_service.dart';
import 'package:bizzie/core/enums/bizzie_lifecycle_state.dart';
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

class MockLifecycleService extends Mock implements ILifecycleService {}

void main() {
  late AppStatusRepositoryImpl repository;
  late MockConfigService mockConfigService;
  late MockConnectivityService mockConnectivityService;
  late MockLocalAppStatusDataSource mockLocalDataSource;
  late MockAppInfoService mockAppInfoService;
  late MockLifecycleService mockLifecycleService;

  setUp(() {
    mockConfigService = MockConfigService();
    mockConnectivityService = MockConnectivityService();
    mockLocalDataSource = MockLocalAppStatusDataSource();
    mockAppInfoService = MockAppInfoService();
    mockLifecycleService = MockLifecycleService();

    // Default: App is in foreground
    when(() => mockLifecycleService.isForeground).thenReturn(true);
    when(
      () => mockLifecycleService.onLifecycleChanged,
    ).thenAnswer((_) => Stream.value(BizzieLifecycleState.foreground));

    // Default: Last fetch was a long time ago (so checks proceed)
    when(
      () => mockConfigService.lastFetchTime,
    ).thenReturn(DateTime.fromMillisecondsSinceEpoch(0));

    repository = AppStatusRepositoryImpl(
      mockConfigService,
      mockLocalDataSource,
      mockConnectivityService,
      mockAppInfoService,
      mockLifecycleService,
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

      test('checkStatus_recentlyFetched_skipsFetch', () async {
        // arrange
        when(
          () => mockConnectivityService.hasInternetConnection,
        ).thenAnswer((_) async => true);
        when(
          () => mockConfigService.lastFetchTime,
        ).thenReturn(DateTime.now().subtract(const Duration(minutes: 1)));
        when(() => mockConfigService.maintenanceMode).thenReturn(false);
        when(() => mockConfigService.minAppVersion).thenReturn('1.0.0');
        when(() => mockConfigService.appStoreLink).thenReturn(tAppStoreLink);
        when(() => mockConfigService.playStoreLink).thenReturn(tPlayStoreLink);
        when(
          () => mockAppInfoService.getAppVersion(),
        ).thenAnswer((_) async => '1.0.0');

        // act
        final result = await repository.checkStatus(source: 'default');

        // assert
        expect(result, const AppStatus.normal());
        verifyNever(() => mockConfigService.fetchAndActivate());
        verify(() => mockConfigService.minAppVersion).called(1);
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

      test('watchStatus_debouncesConnectivityUpdates', () async {
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
      });

      test('watchStatus_backgroundApp_skipsChecks', () async {
        // arrange
        when(() => mockLifecycleService.isForeground).thenReturn(false);
        when(
          () => mockLifecycleService.onLifecycleChanged,
        ).thenAnswer((_) => Stream.value(BizzieLifecycleState.background));

        final configUpdateController = StreamController<void>();
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
        ).thenAnswer((_) => configUpdateController.stream);
        when(
          () => mockConnectivityService.onConnectivityChanged,
        ).thenAnswer((_) => const Stream.empty());
        when(
          () => mockAppInfoService.getAppVersion(),
        ).thenAnswer((_) async => '1.0.0');

        // act
        final subscription = repository.watchStatus().listen((_) {});

        await Future.delayed(Duration.zero);
        clearInteractions(mockConfigService);

        configUpdateController.add(null);
        await Future.delayed(Duration.zero);

        // assert
        verifyNever(() => mockConfigService.fetchAndActivate());

        subscription.cancel();
        configUpdateController.close();
      });

      test('watchStatus_foregroundApp_pollTimerStarts', () async {
        // arrange
        when(
          () => mockLifecycleService.onLifecycleChanged,
        ).thenAnswer((_) => Stream.value(BizzieLifecycleState.foreground));
      });
    });
  });
}
