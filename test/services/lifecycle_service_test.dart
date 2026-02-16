import 'package:bizzie/core/enums/bizzie_lifecycle_state.dart';
import 'package:bizzie/services/lifecycle_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late LifecycleService service;

  setUp(() {
    service = LifecycleService();
  });

  tearDown(() {
    service.dispose();
  });

  group('LifecycleService', () {
    test('isForeground_initialState_returnsFalse', () {
      // act
      final result = service.isForeground;

      // assert
      expect(result, isFalse);
    });

    test('onLifecycleChanged_resumedState_emitsForeground', () async {
      // arrange
      final states = <BizzieLifecycleState>[];
      final subscription = service.onLifecycleChanged.listen(states.add);

      // act
      service.didChangeAppLifecycleState(AppLifecycleState.resumed);
      await Future.delayed(Duration.zero);

      // assert
      expect(service.isForeground, isTrue);
      expect(states, contains(BizzieLifecycleState.foreground));

      subscription.cancel();
    });

    test('onLifecycleChanged_pausedState_emitsBackground', () async {
      // arrange
      final states = <BizzieLifecycleState>[];
      final subscription = service.onLifecycleChanged.listen(states.add);

      // act
      service.didChangeAppLifecycleState(AppLifecycleState.paused);
      await Future.delayed(Duration.zero);

      // assert
      expect(service.isForeground, isFalse);
      expect(states, contains(BizzieLifecycleState.background));

      subscription.cancel();
    });

    test('onLifecycleChanged_inactiveState_emitsInactive', () async {
      // arrange
      final states = <BizzieLifecycleState>[];
      final subscription = service.onLifecycleChanged.listen(states.add);

      // act
      service.didChangeAppLifecycleState(AppLifecycleState.inactive);
      await Future.delayed(Duration.zero);

      // assert
      expect(service.isForeground, isFalse);
      expect(states, contains(BizzieLifecycleState.inactive));

      subscription.cancel();
    });

    test('onLifecycleChanged_hiddenState_emitsBackground', () async {
      // arrange
      final states = <BizzieLifecycleState>[];
      final subscription = service.onLifecycleChanged.listen(states.add);

      // act
      service.didChangeAppLifecycleState(AppLifecycleState.hidden);
      await Future.delayed(Duration.zero);

      // assert
      expect(service.isForeground, isFalse);
      expect(states, contains(BizzieLifecycleState.background));

      subscription.cancel();
    });

    test('onLifecycleChanged_detachedState_emitsDetached', () async {
      // arrange
      final states = <BizzieLifecycleState>[];
      final subscription = service.onLifecycleChanged.listen(states.add);

      // act
      service.didChangeAppLifecycleState(AppLifecycleState.detached);
      await Future.delayed(Duration.zero);

      // assert
      expect(service.isForeground, isFalse);
      expect(states, contains(BizzieLifecycleState.detached));

      subscription.cancel();
    });

    test('dispose_closesSubject_blocksFurtherEmissions', () async {
      // arrange
      final states = <BizzieLifecycleState>[];
      final subscription = service.onLifecycleChanged.listen(states.add);

      // act
      service.dispose();

      // Since didChangeAppLifecycleState might still be called (theoretically)
      // but the subject is closed, we verify no more events or errors.
      // Note: behaviorSubject.add after close throws, but we check cleanup.

      // assert
      expect(
        () => service.didChangeAppLifecycleState(AppLifecycleState.resumed),
        throwsStateError,
      );

      subscription.cancel();
    });
  });
}
