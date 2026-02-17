import 'package:bizzie/core/constants/security_constants.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/env/app_env.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/services/security_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bizzie/core/config/flavor_config.dart';
import 'package:bizzie/di/injection.dart';
import 'package:dartz/dartz.dart';

class MockAppEnv extends Mock implements AppEnv {}

class MockIConfigService extends Mock implements IConfigService {}

class MockIAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late SecurityService securityService;
  late MockAppEnv mockAppEnv;
  late MockIConfigService mockConfigService;
  late MockIAuthRepository mockAuthRepository;

  setUp(() {
    FlavorConfig.reset();
    mockAppEnv = MockAppEnv();
    mockConfigService = MockIConfigService();
    mockAuthRepository = MockIAuthRepository();

    FlavorConfig.init('dev');

    getIt.reset();
    getIt.registerSingleton<IAuthRepository>(mockAuthRepository);

    when(() => mockAppEnv.bundleId).thenReturn('com.example.app');
    when(() => mockAppEnv.appleTeamId).thenReturn('TEAMID123');
    when(
      () => mockConfigService.securityWatcherMail,
    ).thenReturn('security@example.com');
    when(
      () => mockAuthRepository.signOut(),
    ).thenAnswer((_) async => right(null));

    securityService = SecurityService(
      mockAppEnv,
      mockConfigService,
      mockAuthRepository,
    );
  });

  tearDown(() {
    FlavorConfig.reset();
    getIt.reset();
  });

  group('SecurityService', () {
    test('initializes with correct config', () async {
      // Act
      expect(securityService, isA<SecurityService>());
    });

    group('handleThreat (Non-Prod / Dev)', () {
      setUp(() {
        FlavorConfig.init('dev');
      });

      test('handleThreat_unofficialStore_whitelistsThreat', () async {
        // Act
        await securityService.handleThreat(SecurityConstants.unofficialStore);

        // Assert
        expect(securityService.isThreatDetected.value, isFalse);
      });

      test('handleThreat_regularThreat_logsWarningButDoesNotLockout', () async {
        // Act
        await securityService.handleThreat(SecurityConstants.debugging);

        // Assert
        expect(securityService.isThreatDetected.value, isFalse);
      });
    });

    group('handleThreat (Prod)', () {
      setUp(() {
        FlavorConfig.init('prod');
      });

      test('handleThreat_unofficialStore_triggersLockoutAndSignOut', () async {
        // Act
        await securityService.handleThreat(SecurityConstants.unofficialStore);

        // Assert
        expect(securityService.isThreatDetected.value, isTrue);
        verify(() => mockAuthRepository.signOut()).called(1);
      });

      test('handleThreat_simulator_triggersLockoutAndSignOut', () async {
        // Act
        await securityService.handleThreat(SecurityConstants.simulator);

        // Assert
        expect(securityService.isThreatDetected.value, isTrue);
        verify(() => mockAuthRepository.signOut()).called(1);
      });
    });
  });
}
