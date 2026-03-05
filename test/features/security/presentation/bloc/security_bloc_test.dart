import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:bizzie/core/constants/security_constants.dart';
import 'package:bizzie/features/security/domain/enums/security_analytics_enums.dart';
import 'package:bizzie/features/security/presentation/analytics/security_tracker.dart';
import 'package:bizzie/features/security/presentation/bloc/security_bloc.dart';
import 'package:bizzie/features/security/presentation/bloc/security_event.dart';
import 'package:bizzie/features/security/presentation/bloc/security_state.dart';
import 'package:bizzie/services/security_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSecurityService extends Mock implements SecurityService {}

class MockSecurityTracker extends Mock implements SecurityTracker {}

void main() {
  late MockSecurityService mockSecurityService;
  late MockSecurityTracker mockSecurityTracker;
  late StreamController<({String type, bool isCritical})> threatController;

  setUpAll(() {
    registerFallbackValue(SecurityThreatType.unknown);
    registerFallbackValue(SecurityLockoutAction.closeApp);
  });

  setUp(() {
    mockSecurityService = MockSecurityService();
    mockSecurityTracker = MockSecurityTracker();
    threatController =
        StreamController<({String type, bool isCritical})>.broadcast();

    when(
      () => mockSecurityService.threatStream,
    ).thenAnswer((_) => threatController.stream);
    when(() => mockSecurityService.isThreatDetected).thenReturn(false);

    when(
      () => mockSecurityTracker.logThreatDetected(
        type: any(named: 'type'),
        isCritical: any(named: 'isCritical'),
      ),
    ).thenAnswer((_) async {});

    when(() => mockSecurityTracker.logLockoutViewed()).thenAnswer((_) async {});
    when(
      () => mockSecurityTracker.logLockoutAction(any()),
    ).thenAnswer((_) async {});
    when(
      () => mockSecurityTracker.setSecurityThreatProperty(any()),
    ).thenAnswer((_) async {});
  });

  tearDown(() {
    threatController.close();
  });

  group('SecurityBloc', () {
    test('securityBloc_initialState_isSafe', () {
      // arrange
      final securityBloc = SecurityBloc(
        mockSecurityService,
        mockSecurityTracker,
      );

      // assert
      expect(securityBloc.state, const SecurityState.safe());
      securityBloc.close();
    });

    blocTest<SecurityBloc, SecurityState>(
      'securityBloc_threatDetectedFromStream_emitsLockoutAndLogsAnalytics',
      build: () => SecurityBloc(mockSecurityService, mockSecurityTracker),
      act: (bloc) async {
        // arrange
        bloc.add(const SecurityEvent.started());
        await Future.delayed(Duration.zero);

        // act
        threatController.add((
          type: SecurityConstants.simulator,
          isCritical: false,
        ));
      },
      expect: () => [const SecurityState.lockout()],
      verify: (_) {
        // assert
        verify(
          () => mockSecurityTracker.logThreatDetected(
            type: SecurityThreatType.simulator,
            isCritical: false,
          ),
        ).called(1);
        verify(() => mockSecurityTracker.logLockoutViewed()).called(1);
        verify(
          () => mockSecurityTracker.setSecurityThreatProperty(
            SecurityThreatType.simulator,
          ),
        ).called(1);
      },
    );

    blocTest<SecurityBloc, SecurityState>(
      'securityBloc_startedWithExistingThreat_emitsLockoutAndLogsAnalytics',
      build: () {
        // arrange
        when(() => mockSecurityService.isThreatDetected).thenReturn(true);
        when(
          () => mockSecurityService.lastThreat,
        ).thenReturn((type: SecurityConstants.simulator, isCritical: false));
        return SecurityBloc(mockSecurityService, mockSecurityTracker);
      },
      act: (bloc) => bloc.add(const SecurityEvent.started()),
      expect: () => [const SecurityState.lockout()],
      verify: (_) {
        // assert
        verify(
          () => mockSecurityTracker.logThreatDetected(
            type: SecurityThreatType.simulator,
            isCritical: false,
          ),
        ).called(1);
      },
    );

    blocTest<SecurityBloc, SecurityState>(
      'securityBloc_lockoutActionTaken_logsAction',
      build: () => SecurityBloc(mockSecurityService, mockSecurityTracker),
      act: (bloc) => bloc.add(
        const SecurityEvent.lockoutActionTaken(SecurityLockoutAction.closeApp),
      ),
      verify: (_) {
        // assert
        verify(
          () => mockSecurityTracker.logLockoutAction(
            SecurityLockoutAction.closeApp,
          ),
        ).called(1);
      },
    );

    blocTest<SecurityBloc, SecurityState>(
      'securityBloc_trackerThrows_continuesNormally',
      build: () {
        // arrange
        when(
          () => mockSecurityTracker.logThreatDetected(
            type: any(named: 'type'),
            isCritical: any(named: 'isCritical'),
          ),
        ).thenThrow(Exception('Analytics Failure'));
        return SecurityBloc(mockSecurityService, mockSecurityTracker);
      },
      act: (bloc) async {
        // arrange
        bloc.add(const SecurityEvent.started());
        await Future.delayed(Duration.zero);

        // act
        threatController.add((
          type: SecurityConstants.simulator,
          isCritical: false,
        ));
      },
      expect: () => [const SecurityState.lockout()],
      verify: (_) {
        // assert
        verify(
          () => mockSecurityTracker.logThreatDetected(
            type: SecurityThreatType.simulator,
            isCritical: false,
          ),
        ).called(1);
      },
    );
  });
}
